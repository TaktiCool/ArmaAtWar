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
    private _newSide = ((EGVAR(Mission,competingSides) select { _x != playerSide }) select 0);

    //@todo #112 think about restrictions

    // Leave old squad first
    call FUNC(leaveSquad);

    // Respawn as new unit
    [[-1000, -1000, 10], false, _newSide] call CFUNC(respawn);
}, [], "respawn"] call CFUNC(mutex);
