#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    [Description]

    Parameter(s):
    0: Event ID <String>
    1: Functions <Code>
    2: Arguments <Any>

    Returns:
    None
*/
params [["_event", "", [""]], ["_function", {},[{}]], ["_args", []]];

_event = format ["Event_PRA3_", _event];
private _eventFunctions = GVAR(EventNamespace) getVariable _event;
if (isNil "_eventFunctions") then {
    _eventFunctions = [_function];
} else {
    _eventFunctions pushBack _function;
};

GVAR(EventNamespace) setVariable [_event, [_eventFunctions,_args]];
nil
