#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy, NetFusion

    Description:
    Handles "Promote"-Button Events

    Parameter(s):
    0: Unit <Object> (Default: objNull)

    Returns:
    None
*/

params [
    ["_unit", objNull, [objNull]]
];

[{
    params ["_unit"];

    if (CLib_Player != leader _unit) exitWith {};

    ["selectLeader", [group CLib_Player, _unit]] call CFUNC(serverEvent);
}, _unit, "respawn"] call CFUNC(mutex);
