#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    -

    Returns:
    -
*/
[{
    private _newSide = call compile ((EGVAR(Mission,competingSides) select { _x != str playerSide }) select 0);

    //@todo think about restrictions

    // Leave old squad first
    call FUNC(leaveSquad);

    // Respawn as new unit
    [_newSide, createGroup _newSide, [-1000, -1000, 10], true] call CFUNC(respawn);
}] call CFUNC(mutex);
