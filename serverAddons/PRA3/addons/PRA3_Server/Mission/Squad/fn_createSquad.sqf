#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, NetFusion

    Description:
    Creates a squad on players side

    Parameter(s):
    1: Description <STRING>
    2: Type <STRING>

    Returns:
    None
*/
[{
    params ["_description", "_type"];

    // Check conditions for creation
    if (_description == "" || !([_type] call FUNC(canUseSquadType))) exitWith {};

    // Leave old squad first
    call FUNC(leaveSquad);

    // Create new squad
    private _newGroup = createGroup playerSide;
    private _groupId = call FUNC(getNextSquadId);
    _newGroup setGroupIdGlobal [_groupId];
    _newGroup setVariable [QGVAR(Description), _description, true];
    _newGroup setVariable [QGVAR(Type), _type, true];

    [PRA3_Player] join _newGroup;
}, _this] call CFUNC(mutex);