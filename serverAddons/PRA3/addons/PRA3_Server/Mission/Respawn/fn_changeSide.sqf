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

    [_this, createGroup _this, [-1000, -1000, 0]] call FUNC(respawn);
    PRA3_Player setVariable [QGVAR(tempUnit), true];

    ["enableSimulation", [PRA3_Player, false]] call CFUNC(serverEvent);
    ["hideObject", [PRA3_Player, true]] call CFUNC(serverEvent);
}, _newSide] call CFUNC(mutex);
