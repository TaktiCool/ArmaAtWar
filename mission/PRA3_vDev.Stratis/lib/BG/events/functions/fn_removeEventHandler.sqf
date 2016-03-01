#include "script_macros.hpp"
params["_eventType","_handlerIndex"];

private _handlers = GVAR(eventHandlers) getVariable _eventType;

if (!isNil "_handlers") then {
    if (count _handlers > _handlerIndex) then {
        _handlers set [_handlerIndex, -1];
    };
};
