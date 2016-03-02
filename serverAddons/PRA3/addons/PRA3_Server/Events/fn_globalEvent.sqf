#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    trigger a Event on every Maschine

    Parameter(s):
    0: Event Name <String>
    1: Arguments <Any>
    2: is Persistent <String, Number>

    Returns:
    None
*/
params [["_event", "EventError", [""]], ["_args", []], "_persistent"];

if (isNil "_persistent") then {
    [_event, _args] remoteExecCall [QFUNC(localEvent), 0];
} else {
    [_event, _args] remoteExecCall [QFUNC(localEvent), 0, _persistent];
};
