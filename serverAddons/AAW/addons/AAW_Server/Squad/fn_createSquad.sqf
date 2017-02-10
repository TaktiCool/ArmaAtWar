#include "macros.hpp"
/*
    Arma At War

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

    // Remove leading whitespace
    private _descriptionArray = toArray _description;
    for "_i" from 0 to (count _descriptionArray - 1) do {
        if (!((_descriptionArray select _i) in [9, 10, 13, 32])) exitWith {
            _description = _description select [_i]
        };
    };

    // Check conditions for creation
    if (!([_type] call FUNC(canUseSquadType))) exitWith {};

    // Leave old squad first
    call FUNC(leaveSquad);

    // Create new squad
    private _newGroup = createGroup playerSide;
    private _groupId = call FUNC(getNextSquadId);
    _newGroup setGroupIdGlobal [_groupId];
    _newGroup setVariable [QGVAR(Description), _description, true];
    _newGroup setVariable [QGVAR(Type), _type, true];

    [CLib_Player] join _newGroup;
}, _this, "respawn"] call CFUNC(mutex);
