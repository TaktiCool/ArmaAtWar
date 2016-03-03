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

_event = format ["PRA3_Event_%1", _event];
private _eventArray = GVAR(EventNamespace) getVariable _event;
if (isNil "_eventArray") then {
    _eventArray = [_function, _args];
} else {
    _eventArray pushBack [_function, _args];
};

GVAR(EventNamespace) setVariable [_event, _eventArray];
nil
