#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Toggle Status Layer of current Sector

    Parameter(s):
    0: Show or Hide Layer <Bool>
    1: Sector <String>

    Returns:
    None
*/

params ["_show","_sectorObject"];

if (_show) then {
    if !(isNull (uiNamespace getVariable [QEGVAR(UI,CaptureStatus), displayNull])) exitWith {
        [{
            [true, _this select 1] call FUNC(showCaptureStatus);
        }, {
            (isNull (uiNamespace getVariable [QEGVAR(UI,CaptureStatus), displayNull]))
        }, _this] call CFUNC(waitUntil);
    };

    ([QEGVAR(UI,CaptureStatus)] call BIS_fnc_rscLayer) cutRsc [QEGVAR(UI,CaptureStatus),"PLAIN"];
    if (GVAR(captureStatusPFH) != -1) then {
        [GVAR(captureStatusPFH)] call CFUNC(removePerFrameHandler);
    };
    GVAR(captureStatusPFH) = [{
        disableSerialization;
        params ["_args","_id"];
        _args params ["_sector"];

        private _aside = _sector getVariable ["attackerSide",sideUnknown];
        private _side = _sector getVariable ["side",sideUnknown];
        private _progress = _sector getVariable ["captureProgress",0];
        private _rate = _sector getVariable ["captureRate",0];
        private _lastTick = _sector getVariable ["lastCaptureTick", serverTime];

        private _dialog = uiNamespace getVariable QEGVAR(UI,CaptureStatus);

        (_dialog displayCtrl 1001) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,Flag_%1),_side],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
        (_dialog displayCtrl 1002) ctrlSetText (_sector getVariable ["designator",""]);
        (_dialog displayCtrl 1003) ctrlSetText (_sector getVariable ["fullName",""]);
        (_dialog displayCtrl 1004) ctrlSetTextColor (missionNamespace getVariable [format [QEGVAR(Mission,SideColor_%1),_aside],[0,1,0,1]]);
        (_dialog displayCtrl 1004) ctrlCommit 0;
        (_dialog displayCtrl 1004) progressSetPosition (_progress + (serverTime - _lastTick) * _rate);
    }, 0, [_sectorObject]] call CFUNC(addPerFrameHandler);
} else {
    [GVAR(captureStatusPFH)] call CFUNC(removePerFrameHandler);
    GVAR(captureStatusPFH) = -1;

    ([QEGVAR(UI,CaptureStatus)] call BIS_fnc_rscLayer) cutFadeOut 1;
};
