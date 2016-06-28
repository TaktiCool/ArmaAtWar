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
(GVAR(squadIds) - ((allGroups select {side _x == playerSide && (_x != group PRA3_Player || count (_x call CFUNC(groupPlayers)) > 1)}) apply {groupId _x})) select 0;
