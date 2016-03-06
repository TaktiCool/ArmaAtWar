#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Handles "Promote"-Button Events

    Parameter(s):
    0: Button <Control>

    Returns:
    None
*/
disableSerialization;

if (!dialog) exitWith {};

private _currentSelection = lnbCurSelRow 209;

if (_currentSelection < 0) exitWith {}; // This should never happen. Safety check.

private _selectedUnit = objectFromNetId (lnbData [209, [_currentSelection, 0]]);
if (PRA3_Player == leader _selectedUnit) then {
    [group PRA3_Player, _selectedUnit] remoteExecCall ["selectLeader", groupOwner group PRA3_Player];
};

[QGVAR(updateSquadMemberButtons)] call CFUNC(globalEvent); //@todo only group PRA3_Player needs to update