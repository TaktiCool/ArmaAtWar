#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    this Function is a Fail Save Wraper Function for findEmptyPosition
    Find a Save Postion for a Unit, this function everytime return a Position

    Parameter(s):
    0: Postion <Array>
    1: Radius <Float>
    2: Vehicle Class <String> (Optional)

    Returns:
    Save Position <Array>
*/

params ["_pos", "_radius", "_type"];
private _haveType = isNil "_type";
private _retPos = if (_haveType) then {
    _pos findEmptyPosition [0, _radius];
} else {
    _pos findEmptyPosition [0, _radius, _type];
};

if (_retPos isEqualTo []) exitWith {
    if (_haveType) then {
        [_pos, _radius + 10] call (missionNamespace getVariable [_fnc_scriptName, {}]);
    } else {
        [_pos, _radius + 10, _type] call (missionNamespace getVariable [_fnc_scriptName, {}]);
    };
};

_retPos
