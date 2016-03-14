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
private _currentSide = side group PRA3_Player;

[{
    params ["_currentSide"];

    private _newSquad = createGroup _currentSide;

    _newSquad setVariable [QGVAR(Id), (GVAR(squadIds) - (allGroups select {side _x == side group PRA3_Player} apply {_x getVariable QGVAR(Id)})) select 0, true];
    _newSquad setVariable [QGVAR(Description), ctrlText 204, true];
    ctrlSetText [204, ""];

    [PRA3_Player] join _newSquad;

    [QGVAR(updateSquadList), _currentSide] call CFUNC(targetEvent);
    [QGVAR(updateDeploymentList)] call CFUNC(localEvent);
}, [_currentSide]] call CFUNC(mutex);
