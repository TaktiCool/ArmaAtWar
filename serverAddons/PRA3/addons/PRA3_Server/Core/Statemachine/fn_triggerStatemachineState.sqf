#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Trigger only One single state on a Statemachine.

    Parameter(s):
    0: Statemachine Object <Location>
    1: State Name <String>
    2: State Arguments <Any> (default: [])

    Returns:
    Statemachine Return
*/
params ["_stateMachine", "_stateName", ["_stateArgs", []]];

private _stateData = _stateMachine getVariable _stateName;

// check if state data exist.
if (isNil "_stateData") exitWith {
    LOG("Error Next State is Unknown: " + _currentState)
};

_stateData params ["_code", "_args"];

[_args, _stateArgs] call _code;
