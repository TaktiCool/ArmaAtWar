#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, NetFusion

    Description:
    Handles "Create Squad"-Button Events

    Parameter(s):
    0: Button <Control>

    Returns:
    None
*/
[{
    private _newSquad = createGroup playerSide;

    _newSquad setVariable [QGVAR(Id), (GVAR(squadIds) - (allGroups select {side _x == playerSide} apply {_x getVariable QGVAR(Id)})) select 0, true];
    _newSquad setVariable [QGVAR(Description), ctrlText 204, true];
    _newSquad setVariable [QGVAR(Type), "Rifle"];
    ctrlSetText [204, ""];

    [PRA3_Player] join _newSquad;
}] call CFUNC(mutex);
