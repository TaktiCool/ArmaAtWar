#include "macros.hpp"
/*
    Project Reality ArmA 3 - [Script Path]

    Author: joko // Jonas

    Description:
    [Description]

    Parameter(s):
    0: Argument Name <TYPE>

    Returns:
    0: Return Name <TYPE>

    Example:
    -
*/
params [["_event", "", [""]], ["_function", {},[{}]]];

_event = format [GEVENT(%1), _event];
private _eventFunctions = GVAR(EventNamespace) getVariable _event;
if (isNil "_event") then {
    _eventFunctions = [_function];
} else {
    _eventFunctions pushBack _function;
};

GVAR(EventNamespace) setVariable [_event, _eventFunctions];
nil
