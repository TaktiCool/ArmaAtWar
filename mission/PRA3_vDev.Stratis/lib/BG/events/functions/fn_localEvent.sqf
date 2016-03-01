#include "script_macros.hpp"

params ["_eventType",["_params",nil]];


private _handlers = GVAR(eventHandlers) getVariable _eventType;

if (!isNil "_handlers") then {
    {
        if !(_x isEqualType 0) then {
            if (isNil "_params") then {
                call _x;
            } else {
                _params call _x;
            };
        };
        nil;
    } count _handlers;
 };
