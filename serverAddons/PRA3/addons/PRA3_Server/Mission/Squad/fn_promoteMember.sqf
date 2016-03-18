#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, NetFusion

    Description:
    Handles "Promote"-Button Events

    Parameter(s):
    0: Button <Control>

    Returns:
    None
*/
[{
    params ["_unit"];

    if (PRA3_Player != leader _unit) exitWith {};

    ["selectLeader", [group PRA3_Player, _unit]] call CFUNC(serverEvent);
}, _this] call CFUNC(mutex);
