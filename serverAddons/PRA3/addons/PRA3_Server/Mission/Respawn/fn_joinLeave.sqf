#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, NetFusion

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

private _selectedGroup = [206, [_currentSelection, 0]] call CFUNC(lnbLoad);
if (_selectedGroup != group PRA3_Player) then {
    [{
        if ((count units _this) < 9) then {
            [PRA3_Player] join _this;
        };
    }, _selectedGroup] call CFUNC(mutex);
} else {
    [PRA3_Player] join grpNull;
};