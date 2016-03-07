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

[{
    if (PRA3_Player == leader _this) then {
        [_this] join grpNull;
        [QGVAR(updateSquadList), side group PRA3_Player] call CFUNC(targetEvent);
    };
}, _selectedUnit] call CFUNC(mutex);