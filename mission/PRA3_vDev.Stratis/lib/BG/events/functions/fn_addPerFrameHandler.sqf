#include "script_macros.hpp"
params ["_handler",["_delay",0],["_params",[]]];

diag_log format["PFH added: %1",_handler];

private _handlerIndex = GVAR(perFrameHandlers) find -1;

if (_handlerIndex < 0) exitWith {
    GVAR(perFrameHandlers) pushBack [_handler,diag_tickTime+_delay,_delay,_params,count GVAR(perFrameHandlers)];
};

_handlers set [_handlerIndex,[_handler,diag_tickTime+_delay,_delay,_params,_handlerIndex]];

_handlerIndex;
