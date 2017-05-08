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

private _groupControls = [];

private _playerBg = _display ctrlCreate ["RscPicture", -1, _ctrlListGroup];
_groupControls pushBack _playerBg;

private _verticalPosition = 0;
{
    if (side _x == _side && groupId _x in EGVAR(Squad,squadIds)) then {
        {
            private _playerGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlListGroup];
            _playerGroup ctrlSetPosition [0, _verticalPosition, PX(39), PY(4)];
            _playerGroup ctrlCommit 0;

            private _uid = getPlayerUID _x;

            private _scores = GVAR(ScoreNamespace) getVariable [_uid+"_SCORES", [0,0,0,0,0]];

            private _ctrlPlayerName = _display ctrlCreate ["RscTitle", -1, _playerGroup];
            _ctrlPlayerName ctrlSetFontHeight PY(2.2);
            _ctrlPlayerName ctrlSetFont "RobotoCondensed";
            _ctrlPlayerName ctrlSetTextColor [1, 1, 1, 1];
            _ctrlPlayerName ctrlSetPosition [PX(1), PY(0.5), PX(38), PY(3)];
            _ctrlPlayerName ctrlSetText ([_x] call CFUNC(name));
            _ctrlPlayerName ctrlCommit 0;


            private _ctrlPlayerScore = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
            _ctrlPlayerScore ctrlSetFontHeight PY(2.2);
            _ctrlPlayerScore ctrlSetFont "RobotoCondensed";
            _ctrlPlayerScore ctrlSetPosition [PX(33), PY(0.5), PX(6), PY(3)];
            _ctrlPlayerScore ctrlSetText str (_scores select 4);
            _ctrlPlayerScore ctrlCommit 0;

            _groupControls pushBack _playerGroup;
            _verticalPosition = _verticalPosition + PY(4);
            nil;
        //} count units _x;
        } count ([_x] call CFUNC(groupPlayers));
    };
    nil;
} count allGroups;

_ctrlListGroup setVariable [QGVAR(groupControls), _groupControls];

_playerBg ctrlSetPosition [0, 0, PX(39), _verticalPosition];
_playerBg ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.2)";;
_playerBg ctrlCommit 0;
