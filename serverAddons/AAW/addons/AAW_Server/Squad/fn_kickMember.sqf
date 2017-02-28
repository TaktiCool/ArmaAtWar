#include "macros.hpp"
/*
    Arma At War - AAW

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

    if (CLib_Player != leader _unit || CLib_Player == _unit) exitWith {};

    [_unit] join grpNull;

}, _this, "respawn"] call CFUNC(mutex);
