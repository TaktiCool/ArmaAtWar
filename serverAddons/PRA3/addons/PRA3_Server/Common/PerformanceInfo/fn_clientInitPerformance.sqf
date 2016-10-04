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
GVAR(maxFPS) = 0;

DFUNC(showIndicator) = {
    params ["_control", "_fps"];

    private _visible = _fps < 15;
    _control ctrlShow _visible;

    if (!_visible) exitWith {};

    private _color = [[1, 0, 0, 0.7], [1, 1, 0, 0.7]] select (_fps > 10);
    _control ctrlSetTextColor _color;
};

["missionStarted", {
    ([UIVAR(PerformanceStatus)] call BIS_fnc_rscLayer) cutRsc [UIVAR(PerformanceStatus),"PLAIN"];
    private _display = uiNamespace getVariable [UIVAR(PerformanceStatus), displayNull];

    ["performanceCheck", {
        params ["_serverFps", "_display"];

        if (isNull _display) exitWith {};

        // Server frames
        [_display displayCtrl 9001, _serverFps] call FUNC(showIndicator);

        // Client frames
        [_display displayCtrl 9002, diag_fps] call FUNC(showIndicator);
    }, _display] call CFUNC(addEventHandler);

#ifdef isDev
    for "_i" from 40 to 1 step -1 do {
        private _control = _display displayCtrl (9101 + _i);
        _control ctrlSetText "#(argb,8,8,3)color(1,1,1,1)";
    };

    [{
        params ["_display"];

        if (isNull _display) exitWith {};

        private _currentFPS = 1 / CGVAR(deltaTime);
        GVAR(maxFPS) = _currentFPS max GVAR(maxFPS);

        private _control = _display displayCtrl 9101;
        _control ctrlSetText str round GVAR(maxFPS);

        private _lastHeight = PY(5) * (_currentFPS / GVAR(maxFPS));
        private _maxHeight = 0;
        for "_i" from 40 to 1 step -1 do {
            private _control = _display displayCtrl (9101 + _i);
            private _position = ctrlPosition _control;
            private _height = _lastHeight;
            _lastHeight = _position select 3;
            _position set [1, PY(5) - _height];
            _position set [3, _height];
            _maxHeight = _maxHeight max _height;
            _control ctrlSetPosition _position;
            _control ctrlSetTextColor ([[1, 1, 1, 0.8], [1, 0, 0, 0.8]] select (_height < PY(2)));
            _control ctrlCommit 0;
        };

        if (PY(4) > _maxHeight) then {
            GVAR(maxFPS) = GVAR(maxFPS) * 0.8;
        };
    }, 0, _display] call CFUNC(addPerFrameHandler);
#endif

}] call CFUNC(addEventHandler);
