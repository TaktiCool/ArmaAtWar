#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Hold Action Handler

    Parameter(s):
    3: Arguments <Array>
        0: onStart <Code>
        1: onProgress <Code>
        2: onCompletion <Code>
        2: onAbortion <Code>
        3: idleIcon <String>
        4: progressIcon <String>
        5: idleText <String>
        6: arguments <Array>

    Returns:
    0: Return <Type>
*/
params
[
	["_target",objNull,[objNull]],
    ["_distance",2,[123]],
	["_title","MISSING TITLE",[""]],
	["_iconIdle","MISSING ICON",["",{}]],
	["_iconProgress",_iconIdle,["",{}]],
	["_condShow",{true},[{}]],
	["_condProgress",{true},[{}]],
	["_codeStart",{},[{}]],
	["_codeProgress",{},[{}]],
	["_codeCompleted",{},[{}]],
	["_codeInterrupted",{},[{}]],
	["_arguments",[],[[]]],
	["_priority",1000,[123]],
	["_removeCompleted",true,[true]],
	["_showUnconscious",false,[true]]
];

//preprocess data
private _keyNameRaw = actionKeysNames ["Action",1,"Keyboard"];
private _keyName = _keyNameRaw select [1,count _keyNameRaw - 2];
//STR_A3_HoldKeyTo: Hold %1 to %2
private _keyNameColored = format["<t color='#ffae00'>%1</t>",_keyName];
private _hint = format[localize "STR_A3_HoldKeyTo",_keyNameColored,_title];
_hint = format["<t font='RobotoCondensedBold'>%1</t>",_hint];
_title = format["<t color='#FFFFFF' align='left'>%1</t>        <t color='#83ffffff' align='right'>%2     </t>",_title,_keyName];

[_title, _target, _distance, _condShow, {
    params ["_target", "_caller", "_id", "_args"];
    _args params
    [
        "_distance", "_title", "_hint",
    	["_iconIdle","MISSING ICON",["",{}]],
    	["_iconProgress","",[""]],
    	["_condProgress",{true},[{}]],
    	["_codeProgress",{},[{}]],
    	["_codeCompleted",{},[{}]],
    	["_codeInterrupted",{},[{}]],
    	["_arguments",[],[[]]]
    ];

    [_target, _caller, _id, _arguments] call _codeStart;

    [{
        params ["_args", "_handle"];
        _args params ["_target", "_caller", "_id", "_args"];
        _args params
        [
            "_distance", "_title", "_hint",
        	["_iconIdle","MISSING ICON",["",{}]],
        	["_iconProgress","",[""]],
        	["_condProgress",{true},[{}]],
        	["_codeProgress",{},[{}]],
        	["_codeCompleted",{},[{}]],
        	["_codeInterrupted",{},[{}]],
        	["_arguments",[],[[]]]
        ];

        if ((inputAction "Action" < 0.5 && {inputAction "ActionContext" < 0.5}) || !(call _condProgress)) exitWith {
            _args call _onAbortion;
            _handle call CFUNC(removePerFrameHandler);
        };

        private _ret = _args call _codeProgress;
        if (_ret isEqualType 0) then {
            _ret = (_ret min 1) max 0;
            private _progressIcon = format ["\A3\Ui_f\data\IGUI\Cfg\HoldActions\progress\progress_%1_ca.paa", floor (_ret*24)];

            _target setUserActionText [_id,_title,_progressIcon, _iconProgress];


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

            _handle call CFUNC(removePerFrameHandler);
        };
    }, 0, _this] call CFUNC(addPerFrameHandler);



}, [_distance, _title, _hint, _iconIdle, _iconProgress, _condProgress, _codeProgress, _codeCompleted, _codeInterrupted, _arguments]] call CFUNC(addAction);
