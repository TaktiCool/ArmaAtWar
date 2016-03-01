#include "script_macros.hpp"
params ["_eventType",["_params",nil],["_target",0]];

[_eventType, _params] remoteExecCall [QFUNC(localEvent), _target];
