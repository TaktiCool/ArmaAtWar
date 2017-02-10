#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy, NetFusion

    Description:
    The player leaves his squad

    Parameter(s):
    None

    Returns:
    None
*/

private _oldGroup = group CLib_Player;

[CLib_Player] join grpNull;

// Make sure invalid groups are not in allGroups
if ((count ([_oldGroup] call CFUNC(groupPlayers))) == 0) then {
    ["deleteGroup", _oldGroup] call CFUNC(serverEvent);
};
