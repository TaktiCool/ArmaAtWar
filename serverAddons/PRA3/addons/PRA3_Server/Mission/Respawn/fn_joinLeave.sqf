#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Handles "Join/Leave"-Button Events

    Parameter(s):
    0: Button <Control>

    Returns:
    None
*/
disableSerialization;

if (!dialog) exitWith {};

private _currentSelection = lnbCurSelRow 206;

if (_currentSelection < 0) exitWith {}; // This should never happen. Safety check.

private _selectedGroup = groupFromNetId (lnbData [206, [_currentSelection, 0]]);
if (_selectedGroup != group PRA3_Player) then {
    if ((count units _selectedGroup) < 9) then {
        [PRA3_Player] join _selectedGroup;
    };
} else {
    [PRA3_Player] join grpNull;
};

[QGVAR(updateSquadList)] call CFUNC(globalEvent); //@todo only currentSide needs to update