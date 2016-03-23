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

[_event, _args] remoteExecCall [QFUNC(localEvent), 0];
if !(isNil "_persistent") then {
    ["registerJIPQuery", [_persistent, _args, _event]] call CFUNC(serverEvent);
};
