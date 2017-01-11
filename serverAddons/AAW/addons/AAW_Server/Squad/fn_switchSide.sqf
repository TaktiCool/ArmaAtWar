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
    private _newSide = ((EGVAR(Common,competingSides) select { _x != playerSide }) select 0);

    private _oldSide = playerSide;

    if !(call FUNC(canSwitchSide)) exitWith {};

    // Leave old squad first
    call FUNC(leaveSquad);

    // Respawn as new unit
    [[-1000, -1000, 10], _newSide] call EFUNC(Common,respawnNewSide);
}, [], "respawn"] call CFUNC(mutex);
