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
    "_showUnconscious"
];

GVAR(HoldActionPrevActionEH) = ["inGameUIPrevAction", {true}] call FUNC(addEventhandler);
GVAR(HoldActionNextActionEH) = ["inGameUINextAction", {true}] call FUNC(addEventhandler);

{inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "NextAction"];


[_target, _caller, _id, _arguments] call _codeStart;

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
        private _currentProgressIcon = format ["<img size='3' shadow='0' color='#ffffffff' image='\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_%1_ca.paa'/>", floor (_ret*24)];

        if (_id isEqualType 123) then {
            _target setUserActionText [_id,_title,_iconProgress, _currentProgressIcon + "<br/><br/>" + _hint];
        } else {
            ([UIVAR(HoldAction)] call BIS_fnc_rscLayer) cutRsc [UIVAR(HoldAction),"PLAIN",0];
            private _display = uiNamespace getVariable [UIVAR(HoldAction),displayNull];
            (_dialog displayCtrl 6000) ctrlSetStructuredText parseText _iconProgress;
            (_dialog displayCtrl 6001) ctrlSetStructuredText parseText (_currentProgressIcon + "<br/><br/>" + _hint);
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
        
        ["inGameUIPrevAction", GVAR(HoldActionPrevActionEH)] call CFUNC(removeEventHandler);
        ["inGameUINextAction", GVAR(HoldActionNextActionEH)] call CFUNC(removeEventHandler);

        if (_id isEqualType 123) then {
            _target setUserActionText [_id,_title,_iconIdle, "<img size='3' shadow='0' color='#ffffff' image='\A3\Ui_f\data\IGUI\Cfg\HoldActions\in\in_0_ca.paa'/><br/><br/>" + _hint];
        } else {
            ([UIVAR(HoldAction)] call BIS_fnc_rscLayer) cutFadeOut 0;
        };
        _handle call CFUNC(removePerFrameHandler);
    };
}, 0, _this] call CFUNC(addPerFrameHandler);
