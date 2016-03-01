#include "script_macros.hpp"

params["_eventType","_handler"];

diag_log format["EVENT added: %1, %2",_eventType, _handler];

private _handlers = GVAR(eventHandlers) getVariable _eventType;

if (isNil "_handlers") exitWith {
    GVAR(eventHandlers) setVariable [_eventType,[_handler]];
    0;
};

_handlerIndex = _handlers find -1;

if (_handlerIndex < 0) exitWith {
    _handlers pushBack _handler;
};

_handlers set [_handlerIndex,_handler];

_handlerIndex;
