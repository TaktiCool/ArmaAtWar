#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, NetFusion

    Description:
    Handles "Join/Leave"-Button Events

    Parameter(s):
    0: New group <Group>

    Returns:
    None
*/
[{
    params ["_group"];

    // Check conditions for creation
    if (_group == group PRA3_Player) exitWith {};

    private _groupType = _group getVariable [QGVAR(Type), ""];
    private _groupSize = [format [QGVAR(GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting);

    if (count units _group >= _groupSize) exitWith {};

    [PRA3_Player] join _group;
}, _this] call CFUNC(mutex);