#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:


    Parameter(s):


    Returns:

*/
params ["_ctrlListGroup", "_side"];

// Copy old Positon and parent control
//private _oldPosition = ctrlPosition _ctrlListGroup;
//private _parentCtrl = ctrlParentControlsGroup _ctrlListGroup;
private _display = ctrlParent _ctrlListGroup;
//ctrlDelete _ctrlListGroup;

// create new one
//private _ctrlListGroup = _display ctrlCreate ["RscControlsGroupNoHScrollbars", -1, _parentCtrl];
//_ctrlListGroup ctrlSetPosition _oldPosition;
//_ctrlListGroup ctrlCommit 0;

{
    ctrlDelete _x;
} count (_ctrlListGroup getVariable [QGVAR(groupControls), []]);

private _verticalPosition = 0;
private _groupControls = [];
{
    if (side _x == _side && groupId _x in EGVAR(Squad,squadIds)) then {
        private _groupGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlListGroup];
        private _groupGroupHeight = [_groupGroup, _x] call FUNC(createGroupEntry);

        _groupGroup ctrlSetPosition [0, _verticalPosition, PX(80), _groupGroupHeight];
        _groupGroup ctrlCommit 0;
        _groupControls pushBack _groupGroup;
        _verticalPosition = _verticalPosition + _groupGroupHeight + PY(1);
    };
    nil;
} count allGroups;
_ctrlListGroup setVariable [QGVAR(groupControls), _groupControls];
