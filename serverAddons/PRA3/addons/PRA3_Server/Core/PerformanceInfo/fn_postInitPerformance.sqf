#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Post Init

    Parameter(s):
    None

    Returns:
    None
*/

DFUNC(performanceLoop) = {
    if (isServer) then {
        if (diag_fps < 15) then {
            ["lowServerFrames", [true, diag_fps]] call CFUNC(globalEvent);
        } else {
            ["lowServerFrames", [false, diag_fps]] call CFUNC(globalEvent);
        };
    };
    if (isMultiplayer) then {
        disableSerialization;
        private _ctrl = uiNamespace getVariable [UIVAR(PerformanceStatus), disPlayNull];
        if (diag_fps < 20) then {
            private _color = [[1,0,0,0.7], [1,1,0,0.7]] select (diag_fps > 15);
            (_ctrl displayCtrl 9092) ctrlSetTextColor _color;
        } else {
            (_ctrl displayCtrl 9092) ctrlSetTextColor [0,0,0,0];
        };
    };
    [FUNC(performanceLoop), 20] call CFUNC(wait);
};

["missionStarted", {
    if (hasInterface) then {
        ([UIVAR(PerformanceStatus)] call BIS_fnc_rscLayer) cutRsc [UIVAR(PerformanceStatus),"PLAIN"];
        ["lowServerFrames", {
            (_this select 0) params ["_status", "_fps"];
            disableSerialization;
            private _ctrl = uiNamespace getVariable [UIVAR(PerformanceStatus), disPlayNull];
            if (isNull _ctrl) exitWith {};
            if (_status) then {
                private _color = [[1,0,0,0.7], [1,1,0,0.7]] select (diag_fps > 10);
                (_ctrl displayCtrl 9091) ctrlSetTextColor _color;
            } else {
                (_ctrl displayCtrl 9091) ctrlSetTextColor [0,0,0,0];
            };
        }] call CFUNC(addEventHandler);
    };
    [FUNC(performanceLoop), 1] call CFUNC(wait);
}] call CFUNC(addEventHandler);
