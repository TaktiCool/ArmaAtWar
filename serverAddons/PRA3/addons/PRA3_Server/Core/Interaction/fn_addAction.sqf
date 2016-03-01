#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion edit By Joko

    Description:
    Add an action to an object or type(s) of object(s).

    Parameter(s):
    0: the title of the action. <String, Code>
    1: the object (type) which the action should be added to. <Object, Array, String>
    2: the distance in which the action is visible. <Number>
    3: the condition which is evaluated on every frame (if play is in range) to determine whether the action is visible. <String>
    4: the callback which gets called when the action is activated. <Code>
    5: the arguments which get passed to the callback. <Array> (Default: [])

    Returns:
    None
*/
params ["_text","_onObject","_distance","_condition","_callback",["_args",[]]];

_condition = if (_distance > 0) then {"[_target, " + (str _distance) + "] call PRA3_Core_fnc_inRange && " + _condition} else {_condition};

if (typeName _text == "STRING") then {_text = compile ("format[""" + _text + """]")};
if (typeName _onObject == "STRING") then {_onObject = [_onObject];};

if (typeName _onObject == "ARRAY") then {
    {
        GVAR(Interaction_Actions) pushBack [_x, _text, _condition, _callback, _args];
        false
    } count _onObject;
};

if (typeName _onObject == "OBJECT") then {
    if (_onObject == PRA3_Player) then {
        _text = (call _text);
        _onObject addAction [_text, _callback, _args, 1.5, false, true, "", _condition];
        {
            waitUntil {(_this select 1) != PRA3_Player};
            _this set [1, PRA3_Player];
            _this call FUNC(addAction);
        };
    } else {
        GVAR(Interaction_Actions) pushBack [_onObject, _text, _condition, _callback, _args];
    };
};
