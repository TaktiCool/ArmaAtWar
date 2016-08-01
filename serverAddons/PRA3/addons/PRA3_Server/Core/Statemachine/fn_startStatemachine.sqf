#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Start a Statemachine.

    Parameter(s):
    0: Statemachine Object <Location>
    1: First State <String> (default: "init")
    2: Tick Time <Number> (default: 0)

    Returns:
    Index of the Statemachine PFH <Number>
*/
params ["_stateMachine", "_firstState", ["_tickeTime", 0]];

if (_stateMachine in EGVAR(Statemachine,allStatemachines)) exitWith {
    LOG("Error Statemachine is allready Running")
};

if !(isNil "_firstState") then {
    _stateMachine setVariable [SMSVAR(nextStateData), _firstState];
};

private _index = [FUNC(loopStatemachine), _tickeTime, _stateMachine] call CFUNC(addPerFrameHandler);

_stateMachine setVariable [SMSVAR(PFHIndex), _index];
EGVAR(Statemachine,allStatemachines) set [_index, _stateMachine];
_index
