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
(_this select 0) params ["_btn"];
disableSerialization;

if ((ctrlText _btn) == "JOIN") then {
    private _selectedGroup = missionNamespace getVariable [lnbData [206,[lnbCurSelRow 206,0]], grpNull];
    _selectedGroup = group _selectedGroup;
    ["joinGroupRequested",[_selectedGroup,PRA3_player]] call CFUNC(serverEvent);
} else {
    [PRA3_player] join grpNull;
};
