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


	[cursorTarget, "TestHold", "", "", {true}, {true}, {StartTime = time;}, {(time - StartTime)/10},{hint "COMPLETED";},{hint "INTERRUPTED"}] call CFUNC(addHoldAction)
    Returns:
    0: Return <Type>
*/
params
[
	["_target",objNull,[objNull,"",[]]],
	["_title","MISSING TITLE",[""]],
	["_iconIdle","MISSING ICON",["",{}]],
	["_iconProgress","MISSING ICON",["",{}]],
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

if (_target isEqualType "" && {_target == "VanillaAction"}) then {
	["inGameUIAction", {
		(_this select 0) params ["_target", "_caller", "_idx", "_id", "_title", "_priority"];

		if (_id == ((_this select 1) select 0)) then {
			private _keyNameRaw = actionKeysNames ["Action",1,"Keyboard"];
			private _keyName = _keyNameRaw select [1,count _keyNameRaw - 2];
			//STR_A3_HoldKeyTo: Hold %1 to %2
			private _keyNameColored = format["<t color='#ffae00'>%1</t>",_keyName];
			private _hint = format[localize "STR_A3_HoldKeyTo",_keyNameColored,_title];
			
			private _args = _this select 1;
			_args set [0, _title];
			_args set [1, _hint];
			_args set [11, _priority];
			[_target, _caller, _id, _this select 1] call FUNC(holdActionCallback);
		};

	},[_title,
	_hint,
	_iconIdle,
	_iconProgress,
	_condShow,
	_condProgress,
	_codeStart,
	_codeProgress,
	_codeCompleted,
	_codeInterrupted,
	_arguments,
	_priority,
	_removeCompleted,
	_showUnconscious]] call FUNC(addEventhandler);
} else {
	_title = format["<t color='#FFFFFF' align='left'>%1</t>        <t color='#83ffffff' align='right'>%2     </t>",_title,_keyName];
	[_title, _target, 0, _condShow, FUNC(holdActionCallback), ["arguments", [
		_title,
		_hint,
		_iconIdle,
		_iconProgress,
		_condShow,
		_condProgress,
		_codeStart,
		_codeProgress,
		_codeCompleted,
		_codeInterrupted,
		_arguments,
		_priority,
		_removeCompleted,
		_showUnconscious
		], "priority", _priority, "showWindow", true, "hideOnUse", false, "showUnconscious", _showUnconscious, "onActionAdded", {
			params ["_id", "_target", "_argArray"];
			_argArray params ["","","_args"];
			_args params
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

			_target setUserActionText [_id,_title,_iconIdle, "<img size='3' shadow='0' color='#ffffff' image='\A3\Ui_f\data\IGUI\Cfg\HoldActions\in\in_0_ca.paa'/><br/><br/>" + _hint];
		}]] call CFUNC(addAction);
	};
