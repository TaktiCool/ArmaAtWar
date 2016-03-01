#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Toggle Status Layer of current Sector

    Parameter(s):
    0: Show or Hide Layer <Bool>
    1: Sector <String>

    Returns:
    None
*/

params ["_show","_sector"];

if (_show) then {
    _sector = [_sector] call FUNC(getSector);
    ([QGVAR(CaptureStatus)] call BIS_fnc_rscLayer) cutRsc [QGVAR(CaptureStatus),"PLAIN"];
    if (GVAR(captureStatusPFH) != -1) then {
        [GVAR(captureStatusPFH)] call CFUNC(removePerFrameHandler);
    };

    [{
            disableSerialization;
            params ["_args","_id"];
            _args params ["_sector"];
            private _aside = _sector getVariable ["attackerSide",sideUnknown];
            private _side = _sector getVariable ["side",sideUnknown];
            private _progress = _sector getVariable ["captureProgress",0];
            private _rate = _sector getVariable ["captureRate",0];
            private _lastTick = _sector getVariable ["lastCaptureTick",serverTime];

            private _dialog = uiNamespace getVariable QGVAR(CaptureStatus);

            (_dialog displayCtrl 101) ctrlSetText (missionNamespace getVariable [format ["%1_%2",QGVAR(Flag),_side],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
            (_dialog displayCtrl 102) ctrlSetText (_sector getVariable ["designator",""]);
            (_dialog displayCtrl 103) ctrlSetText (_sector getVariable ["fullName",""]);
            (_dialog displayCtrl 104) ctrlSetTextColor (missionNamespace getVariable [format ["%1_%2",QGVAR(SideColor),_aside],[0,1,0,1]]);
            (_dialog displayCtrl 104) ctrlCommit 0;
            (_dialog displayCtrl 104) progressSetPosition (_progress + (serverTime - _lastTick)*_rate);
            if !(GVAR(captureStatusPFH)) then {
                [GVAR(captureStatusPFH)] call CFUNC(removePerFrameHandler);
            };
        }, 0, [_sector]] call CFUNC(addPerFrameHandler);
        GVAR(captureStatusPFH) = true;
} else {
    GVAR(captureStatusPFH) = false;

    ([QGVAR(CaptureStatus)] call BIS_fnc_rscLayer) cutFadeOut 1;
};
