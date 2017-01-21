#include "macros.hpp"
/*
    Arma At War

    Author: NetFusion

    Description:
    -

    Parameter(s):
    None

    Returns:
    Next available squad id <STRING>
*/
(GVAR(squadIds) - ((allGroups select {side _x == playerSide && (_x != group CLib_Player || count (_x call CFUNC(groupPlayers)) > 1)}) apply {groupId _x})) select 0;
