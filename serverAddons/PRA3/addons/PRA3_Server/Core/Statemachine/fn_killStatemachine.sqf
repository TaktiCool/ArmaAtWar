#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Kill a Statemachine.

    Parameter(s):
    0: Statemachine Index or Statemachine <Number, Location>

    Returns:
    None
*/
params ["_index"];

private "_stateMachine";
if (_index isEqualType 0) then {
    _stateMachine = EGVAR(Statemachine,allStatemachines) param [_index, nil];
} else {
    _stateMachine = _index;
    _index = _index getVariable SMSVAR(PFHIndex);
};

_index call CFUNC(removePerFrameHandler);
deleteLocation _stateMachine;
EGVAR(Statemachine,allStatemachines) set [_index, nil];
// cleanup Array
{
    if !(isNil "_x") then {
        EGVAR(Statemachine,allStatemachines) set [_forEachIndex, _x];
    };
} forEach EGVAR(Statemachine,allStatemachines)
