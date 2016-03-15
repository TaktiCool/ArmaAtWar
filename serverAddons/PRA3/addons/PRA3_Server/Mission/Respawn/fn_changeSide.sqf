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
    selectPlayer _newUnit;
    _newUnit setDamage 1;
    ["enableSimulation", [_newUnit, false]] call CFUNC(serverEvent);
    ["hideObject", [_newUnit, true]] call CFUNC(serverEvent);

    deleteVehicle _oldUnit;
}, _newSide] call CFUNC(mutex);
