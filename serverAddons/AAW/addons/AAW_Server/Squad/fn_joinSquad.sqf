#include "macros.hpp"
/*
    Arma At War - AAW

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
    if (_group == group CLib_Player) exitWith {};

    private _groupType = _group getVariable [QGVAR(Type), ""];
    private _groupSize = [format [QGVAR(GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSettingOld);

    if (count ([_group] call CFUNC(groupPlayers)) >= _groupSize) exitWith {};

    private _oldGroup = group CLib_Player;
    [CLib_Player] join _group;

    // Make sure invalid groups are not in allGroups
    if ((count ([_oldGroup] call CFUNC(groupPlayers))) == 0) then {
        ["deleteGroup", _oldGroup] call CFUNC(serverEvent);
    };
}, _this, "respawn"] call CFUNC(mutex);
