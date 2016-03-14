#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Check if Kit is usable or all Kits are away(in Group)

    Parameter(s):
    0: Kit name

    Remarks:
    _kitName: Current Kit

    Returns:
    is Selectable <Bool>
*/
params ["_kitName"];

private _kitDetails = [_kitName, [["isLeader", 0]]] call FUNC(getKitDetails);

// Check leader

true
