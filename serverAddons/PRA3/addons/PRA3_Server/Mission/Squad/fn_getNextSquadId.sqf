#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    None

    Returns:
    Next available squad id <STRING>
*/
(GVAR(squadIds) - (allGroups select {side _x == playerSide} apply {_x getVariable QGVAR(Id)})) select 0