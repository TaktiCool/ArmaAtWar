#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, NetFusion

    Description:
    The player leaves his squad

    Parameter(s):
    None

    Returns:
    None
*/
private _oldGroup = group PRA3_Player;

[PRA3_Player] join grpNull;

// Make sure invalid groups are not in allGroups
if ((count ([_oldGroup] call CFUNC(groupPlayers))) == 0) then {
    ["deleteGroup", _oldGroup] call CFUNC(serverEvent);
};
