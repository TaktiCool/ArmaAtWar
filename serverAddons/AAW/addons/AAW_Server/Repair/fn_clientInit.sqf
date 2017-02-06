#include "macros.hpp"
/*
    Arma At War

    Author: NetFusion

    Description:
    Client init of repair module

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(supplyPoints) = [];

["entityCreated", {
    params ["_object"];

    private _supplyUses = _object getVariable "supplyUses";
    private _rearmAmount = _object getVariable "rearmAmount";
    private _refuelAmount = _object getVariable "refuelAmount";
    private _repairAmount = _object getVariable "repairAmount";

    if (!(isNil "_supplyUses" && isNil "_rearmAmount" && isNil "_refuelAmount" && isNil "_repairAmount")) then {
        private _index = GVAR(supplyPoints) pushBack _object;
        [
            {format ["Supply %1 at %2", getText (configFile >> "CfgVehicles" >> typeOf cursorObject >> "displayName"), getText (configFile >> "CfgVehicles" >> typeOf _args >> "displayName")]},
            ["Air", "LandVehicle", "Ship"],
            5,
            format ["call {
                private _repairPoint = %1 select %2;
                if (_repairPoint getVariable [""supplyUses"", 0] == 0 || !(_repairPoint in (_target nearObjects [""%3"", 20]))) exitWith {false};
                if (_repairPoint getVariable [""rearmAmount"", 0] > 0 && ({
                    _x params [""_className"", ""_turretPath"", ""_ammoCount""];
                    _ammoCount < (getNumber (configFile >> ""CfgMagazines"" >> _className >> ""count""))
                } count (magazinesAllTurrets _target)) > 0) exitWith {true};
                if (_repairPoint getVariable [""refuelAmount"", 0] > 0 && fuel _target < 1) exitWith {true};
                if (_repairPoint getVariable [""repairAmount"", 0] > 0 && (selectMax (getAllHitPointsDamage _target select 2)) > 0) exitWith {true};
                false
            }", QGVAR(supplyPoints), _index, typeOf _object],
            {
                params ["_vehicle", "_caller", "_id", "_repairPoint"];

                private _rearmAmount = _repairPoint getVariable ["rearmAmount", 0];
                private _refuelAmount = _repairPoint getVariable ["refuelAmount", 0];
                private _repairAmount = _repairPoint getVariable ["repairAmount", 0];
                private _supplyUses = _repairPoint getVariable ["supplyUses", 0];

                {
                    _x params ["_className", "_turretPath", "_ammoCount"];
                    private _maxAmmo = getNumber (configFile >> "CfgMagazines" >> _className >> "count");
                    if (_ammoCount < _maxAmmo) then {
                        [[_className, _turretPath], "removeMagazineTurret", _vehicle] call CFUNC(remoteExec);
                        [[_className, _turretPath, (_ammoCount + (_maxAmmo * _rearmAmount)) min _maxAmmo], "addMagazineTurret", _vehicle] call CFUNC(remoteExec);
                        _vehicle loadMagazine [_turretPath, "m256", _className];
                    };
                    nil
                } count (magazinesAllTurrets _vehicle);

                [[_vehicle, ((fuel _vehicle) + _refuelAmount) min 1], "setFuel", _vehicle] call CFUNC(remoteExec);

                private _currentDamage = selectMax (getAllHitPointsDamage _vehicle select 2);
                _vehicle setDamage ((_currentDamage - _repairAmount) max 0);

                if (_supplyUses > 0) then {
                    _repairPoint setVariable ["supplyUses", _supplyUses - 1];
                };
            },
            ["arguments", _object]
        ] call CFUNC(addAction);
    };
}] call CFUNC(addEventHandler);
