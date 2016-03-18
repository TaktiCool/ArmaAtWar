#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, NetFusion

    Description:
    -

    Parameter(s):
    0: Unit <OBJECT>

    Returns:
    None
*/
[{
    params ["_unit"];

    if (PRA3_Player != leader _unit || PRA3_Player == _unit) exitWith {};

    [_unit] join grpNull;

}, _this] call CFUNC(mutex);