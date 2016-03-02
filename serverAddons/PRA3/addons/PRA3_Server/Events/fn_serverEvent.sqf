#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    trigger a event on the Server

    Parameter(s):
    0: Event Name <String>
    1: Arguments <Any>

    Returns:
    None
*/
[["_event", "EventError", [""]], ["_args", []]];

if (isServer) then {
    [_event, _args] call FUNC(localEvent);
} else {
    [_event, _args] remoteExecCall [QFUNC(localEvent), 2];
};
