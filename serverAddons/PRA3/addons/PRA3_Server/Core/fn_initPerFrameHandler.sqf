#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    init for PFH

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(waitArray) = [];
GVAR(waitUntilArray) = [];
GVAR(perFrameHandlerArray) = [];
GVAR(PFHhandles) = [];
GVAR(nextFrameBufferA) = [];
GVAR(nextFrameBufferB) = [];
GVAR(nextFrameNo) = diag_frameno;
GVAR(deltaTime) = 0;
GVAR(lastFrameTime) = diag_tickTime;
[QGVAR(OnEachFrameID), "onEachFrame", {
    PERFORMANCECOUNTER_START(PFHCounter)

    {
        _x params ["_function", "_delay", "_delta", "", "_args", "_handle"];

        if (diag_tickTime > _delta) then {
            _x set [2, _delta + _delay];
            [_args, _handle] call _function;
            false
        };
    } count +GVAR(perFrameHandlerArray);


    // Code Ported from ACE changed by joko // Jonas
    while {!(GVAR(waitArray) isEqualTo []) && {GVAR(waitArray) select 0 select 0 <= time}} do {
        private _entry = GVAR(waitArray) deleteAt 0;
        (_entry select 2) call (_entry select 1);
    };

    GVAR(waitUntilArray) = GVAR(waitUntilArray) select {
        if ((_x select 2) call (_x select 1)) then {
            (_x select 2) call (_x select 0);
            false
        } else {
            true
        };
    };

    //Handle the execNextFrame array:
    {
        (_x select 0) call (_x select 1);
        false
    } count GVAR(nextFrameBufferA);

    //Swap double-buffer:
    GVAR(nextFrameBufferA) = +GVAR(nextFrameBufferB);
    GVAR(nextFrameBufferB) = [];
    GVAR(nextFrameNo) = diag_frameno + 1;

    // Delta time Describe the time that the last Frame needed to calculate this is required for some One Each Frame Balance Math Calculations
    GVAR(deltaTime) = diag_tickTime - GVAR(lastFrameTime);
    GVAR(lastFrameTime) = diag_tickTime;

    if (getClientState == "GAME FINISHED") then {
        [QGVAR(OnEachFrameID), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
    };

    PERFORMANCECOUNTER_END(PFHCounter)
}] call BIS_fnc_addStackedEventHandler;
