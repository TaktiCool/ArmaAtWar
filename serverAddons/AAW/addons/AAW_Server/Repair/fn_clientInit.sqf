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

    private _repairUses = _object getVariable "repairUses";
    private _repairAmount = _object getVariable "repairAmount";
    if (!((isNil "_repairUses") || (isNil "_repairAmount"))) then {
        private _index = GVAR(repairPoints) pushBack _object;
        [
            {format ["Supply %1 at %2", getText (configFile >> "CfgVehicles" >> typeOf cursorObject >> "displayName"), getText (configFile >> "CfgVehicles" >> typeOf _args >> "displayName")]},
            ["Air", "LandVehicle", "Ship"],
            5,
            format ["call {
                if (damage _target == 0) exitWith {false};
                private _repairPoint = %1 select %2;
                (_repairPoint getVariable [""repairUses"", 0] != 0) && (_repairPoint getVariable [""repairAmount"", 0] > 0) && _repairPoint in (_target nearObjects [""%3"", 20])
            }", QGVAR(repairPoints), _index, typeOf _object],
            {
                params ["_vehicle", "_caller", "_id", "_repairPoint"];

                private _repairAmount = _repairPoint getVariable ["repairAmount", 0];
                private _repairUses = _repairPoint getVariable ["repairUses", 0];

                _vehicle setDamage (((damage _vehicle) - _repairAmount) max 0);

                if (_repairUses > 0) then {
                    _repairPoint setVariable ["repairUses", _repairUses - 1];
                };
            },
            ["arguments", _object]
        ] call CFUNC(addAction);
    };
}] call CFUNC(addEventHandler);
