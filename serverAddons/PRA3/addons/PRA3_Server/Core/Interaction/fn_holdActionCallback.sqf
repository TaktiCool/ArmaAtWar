#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Callback function for the Hold Action

    Parameter(s):
    0: Argument <Type>

    Returns:
    0: Return <Type>
*/

params ["_target", "_caller", "_id", "_actionArguments"];
_actionArguments params
[
    "_title",
    "_hint",
    "_iconIdle",
    "_iconProgress",
    "_condShow",
    "_condProgress",
    "_codeStart",
    "_codeProgress",
    "_codeCompleted",
    "_codeInterrupted",
    "_arguments",
    "_priority",
    "_removeCompleted",
    "_showUnconscious",
    "_ignoredCanInteractConditions"
];

GVAR(DisablePrevAction) = true;
GVAR(DisableNextAction) = true;

[_target, _caller, _id, _arguments] call _codeStart;

if (isNull (uiNamespace getVariable [UIVAR(HoldAction),displayNull])) then {
    ([UIVAR(HoldAction)] call BIS_fnc_rscLayer) cutRsc [UIVAR(HoldAction),"PLAIN",0];
};

GVAR(HoldActionStartTime) = diag_tickTime;

[{
    params ["_args", "_handle"];
    _args params ["_target", "_caller", "_id", "_actionArguments"];
    _actionArguments params
    [
        "_title",
        "_hint",
        "_iconIdle",
        "_iconProgress",
        "_condShow",
        "_condProgress",
        "_codeStart",
        "_codeProgress",
        "_codeCompleted",
        "_codeInterrupted",
        "_arguments",
        "_priority",
        "_removeCompleted",
        "_showUnconscious"
    ];
    private _ret = !((inputAction "Action" < 0.5 && {inputAction "ActionContext" < 0.5}) || !([_target, _caller, _id, _arguments] call _condProgress));


    if (_ret) then {
        _ret = [_target, _caller, _id, _arguments] call _codeProgress;
    };

    if (_ret isEqualType 0) then {
        _ret = (_ret min 1) max 0;
        private _progressIconPath = format ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_%1_ca.paa", floor (_ret*24)];
        if (diag_tickTime - GVAR(HoldActionStartTime) <= 0.15) then {
            _progressIconPath = format ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\in\in_%1_ca.paa", floor ((diag_tickTime - GVAR(HoldActionStartTime)) / 0.05)];
        };

        if (_id isEqualType 123) then {
            _target setUserActionText [_id,_title,_iconProgress, format ["<img size='3' shadow='0' color='#ffffffff' image='%1'/>", _progressIconPath]];
        } else {
            private _display = uiNamespace getVariable [UIVAR(HoldAction),displayNull];
            (_display displayCtrl 6000) ctrlSetStructuredText parseText _iconProgress;
            (_display displayCtrl 6001) ctrlSetStructuredText parseText (format ["<img size='3.5' shadow='0' color='#ffffffff' image='%1'/>", _progressIconPath]);
            (_display displayCtrl 6000) ctrlCommit 0;
            (_display displayCtrl 6001) ctrlCommit 0;

        };



        if (_ret >= 1) then {
            _ret = true;
        };
    };

    if (_ret isEqualType true) then {
        if (_ret) then {
            _args call _codeCompleted;
        } else {
            _args call _codeInterrupted;
        };

        GVAR(DisablePrevAction) = false;
        GVAR(DisableNextAction) = false;

        if (_id isEqualType 123) then {
            _target setUserActionText [_id,_title,_iconIdle, "<img size='3' shadow='0' color='#ffffff' image='\A3\Ui_f\data\IGUI\Cfg\HoldActions\in\in_0_ca.paa'/><br/><br/>" + _hint];
        } else {
            ([UIVAR(HoldAction)] call BIS_fnc_rscLayer) cutFadeOut 0;
        };
        _handle call CFUNC(removePerFrameHandler);
    };
}, 0, _this] call CFUNC(addPerFrameHandler);
