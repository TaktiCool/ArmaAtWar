#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    -

    Returns:
    -
*/
private _newSide = call compile ((GVAR(competingSides) select { _x != str playerSide }) select 0);

[{
    //@todo think about restrictions

    private _oldUnit = PRA3_Player;
    private _newUnit = (createGroup _this) createUnit [getText (missionConfigFile >> "PRA3" >> "Sides" >> (str _this) >> "playerClass"), [-1000, -1000, 0], [], 0, "NONE"];
    _newUnit setVariable [QGVAR(tempUnit), true];

    selectPlayer _newUnit;
    ["playerChanged", [_newUnit, _oldUnit]] call CFUNC(localEvent);
    PRA3_Player = _newUnit;

    ["enableSimulation", [_newUnit, false]] call CFUNC(serverEvent);
    ["hideObject", [_newUnit, true]] call CFUNC(serverEvent);

    if (_oldUnit getVariable [QGVAR(tempUnit), false]) then {
        deleteVehicle _oldUnit;
    };
}, _newSide] call CFUNC(mutex);
