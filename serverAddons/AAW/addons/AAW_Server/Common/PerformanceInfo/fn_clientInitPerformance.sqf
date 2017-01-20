#include "macros.hpp"
/*
    Arma At War

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
}] call CFUNC(addEventHandler);
