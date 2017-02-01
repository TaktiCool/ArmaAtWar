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

GVAR(repairPoints) = [];

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
                if (_repairPoint getVariable [""rearmAmount"", 0] > 0) exitWith {
                    {

                    } count (magazinesAllTurrets _target);
                };
                if (_repairPoint getVariable [""refuelAmount"", 0] > 0 && fuel _target < 1) exitWith {true};
                if (_repairPoint getVariable [""repairAmount"", 0] > 0 && damage _target < 1) exitWith {true};
                false
            }", QGVAR(repairPoints), _index, typeOf _object],
            {
                params ["_vehicle", "_caller", "_id", "_repairPoint"];

                private _repairAmount = _repairPoint getVariable ["repairAmount", 0];
                private _supplyUses = _repairPoint getVariable ["supplyUses", 0];

                _vehicle setDamage (((damage _vehicle) - _repairAmount) max 0);

                if (_supplyUses > 0) then {
                    _repairPoint setVariable ["supplyUses", _supplyUses - 1];
                };
            },
            ["arguments", _object]
        ] call CFUNC(addAction);
    };
}] call CFUNC(addEventHandler);
