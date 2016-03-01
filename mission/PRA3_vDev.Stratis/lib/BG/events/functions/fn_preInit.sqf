#include "script_macros.hpp"

GVAR(eventHandlers) = "Logic" createVehicleLocal [0, 0];
GVAR(perFrameHandlers) = [];

[QGVAR(perFrameHandler), "onEachFrame", {
    {
        if !(_x isEqualType 0) then {
            private _handler = _x;
            if (_handler params ["_func", "_execTime", "_delay", "_params","_id"]) then {
                if (diag_tickTime > _execTime) then {
                    [_params, _id] call _func;
                    _execTime = diag_tickTime + _delay;
                    _handler set [1, _execTime];
                };
            };
        };
        nil;
    } count GVAR(perFrameHandlers);
}] call BIS_fnc_addStackedEventHandler;
