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
if (isNull _oldGroup) then {
    deleteGroup _oldGroup;
};