#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Client init of performance info.

    Parameter(s):
    None

    Returns:
    None
*/
GVAR(maxDeltaTime) = 0;

DFUNC(showIndicator) = {
    params ["_control", "_fps"];

    disableSerialization;

    private _visible = _fps < 15;
    _control ctrlShow _visible;

    if (!_visible) exitWith {};

    private _color = [[1, 0, 0, 0.7], [1, 1, 0, 0.7]] select (_fps > 10);
    _control ctrlSetTextColor _color;
};

["missionStarted", {
    ([UIVAR(PerformanceStatus)] call BIS_fnc_rscLayer) cutRsc [UIVAR(PerformanceStatus),"PLAIN"];

    ["performanceCheck", {
        (_this select 0) params ["_serverFps"];

        private _display = uiNamespace getVariable [UIVAR(PerformanceStatus), displayNull];
        if (isNull _display) exitWith {};

        // Server frames
        [_display displayCtrl 9001, _serverFps] call FUNC(showIndicator);

        // Client frames
        [_display displayCtrl 9002, diag_fps] call FUNC(showIndicator);
    }] call CFUNC(addEventHandler);

    [{
        disableSerialization;

        private _display = uiNamespace getVariable [UIVAR(PerformanceStatus), displayNull];
        if (isNull _display) exitWith {};

        GVAR(maxDeltaTime) = GVAR(deltaTime) max GVAR(maxDeltaTime);

        private _lastHeight = PY(5) * (GVAR(deltaTime) / GVAR(maxDeltaTime));
        private _maxHeight = 0;
        for "_i" from 40 to 1 step -1 do {
            private _control = _display displayCtrl (9100 + _i);
            private _position = ctrlPosition _control;
            private _height = _lastHeight;
            _lastHeight = _position select 3;
            _position set [1, PY(5) - _height];
            _position set [3, _height];
            _maxHeight = _maxHeight max _height;
            _control ctrlSetPosition _position;
            _control ctrlCommit 0;
        };

        if (PY(4) > _maxHeight) then {
            GVAR(maxDeltaTime) = GVAR(maxDeltaTime) * 0.8;
        };
    }] call FUNC(addPerFrameHandler);
}] call CFUNC(addEventHandler);