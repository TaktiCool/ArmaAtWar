#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy, NetFusion

    Description:
    Kicks a unit out of the squad.

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

    if (CLib_Player != leader _unit || CLib_Player == _unit) exitWith {};

    [_unit] join grpNull;
}, _unit, "respawn"] call CFUNC(mutex);
