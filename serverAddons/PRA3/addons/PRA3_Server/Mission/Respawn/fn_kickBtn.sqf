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
(_this select 0) params ["_btn"];
disableSerialization;

private _unit = missionNamespace getVariable [call compile lnbData [209,[lnbCurSelRow 209,0]],objNull];
if (!isNull _unit && PRA3_player == leader PRA3_player) then {
    [_unit] join grpNull;
};
