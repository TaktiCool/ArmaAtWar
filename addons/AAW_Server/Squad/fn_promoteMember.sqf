#include "macros.hpp"
/*
    Arma At War - AAW

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

    if (CLib_Player != leader _unit) exitWith {};

    ["selectLeader", [group CLib_Player, _unit]] call CFUNC(serverEvent);
}, _this, "respawn"] call CFUNC(mutex);
