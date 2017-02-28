#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy, joko // Jonas

    Description:
    Toggle Status Layer of current Sector

    Parameter(s):
    0: Show or Hide Layer <Bool>
    1: Sector <String>

    Returns:
    None
*/

params ["_show", "_sectorObject"];

if (_show) then {
    if !(isNull (uiNamespace getVariable [QEGVAR(UI,CaptureStatus), displayNull])) exitWith {
        [{
            if (GVAR(currentSector) != (_this select 1)) exitWith {};
            [true, _this select 1] call FUNC(showCaptureStatus);
        }, {
            (isNull (uiNamespace getVariable [QEGVAR(UI,CaptureStatus), displayNull]))
        }, _this] call CFUNC(waitUntil);
    };

    ([QEGVAR(UI,CaptureStatus)] call BIS_fnc_rscLayer) cutRsc [QEGVAR(UI,CaptureStatus), "PLAIN"];
    if (GVAR(captureStatusPFH) != -1) then {
        [GVAR(captureStatusPFH)] call CFUNC(removePerFrameHandler);
    };
    GVAR(captureStatusPFH) = [{
        params ["_args", "_id"];
        _args params ["_sector"];

        private _aside = _sector getVariable ["attackerSide", sideUnknown];
        private _side = _sector getVariable ["side", sideUnknown];
        private _progress = _sector getVariable ["captureProgress", 0];
        private _rate = _sector getVariable ["captureRate", 0];
        private _lastTick = _sector getVariable ["lastCaptureTick", serverTime];

        private _dialog = uiNamespace getVariable QEGVAR(UI,CaptureStatus);

        private _color = [
            [0.6, 0, 0, 1],
            [0, 0.4, 0.8, 1]
        ] select (_aside isEqualTo side group CLib_player);

        if (_aside isEqualTo sideUnknown) then {
            _color = [0.93, 0.7, 0.01, 1];
        };

        private _color2 = [
            [0.6, 0, 0, 1],
            [0, 0.4, 0.8, 1]
        ] select (_side isEqualTo side group CLib_player);

        if (_side isEqualTo sideUnknown) then {
            _color2 = [0.93, 0.7, 0.01, 1];
        };

        (_dialog displayCtrl 1001) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,Flag_%1), _side], "#(argb,8,8,3)color(0.5,0.5,0.5,0)"]);
        (_dialog displayCtrl 1002) ctrlSetStructuredText parseText format ["<t font='RobotoCondensedBold' size='1'>%1</t>  %2", _sector getVariable ["designator", ""], _sector getVariable ["fullName", ""]];
        (_dialog displayCtrl 1004) ctrlSetTextColor _color;
        (_dialog displayCtrl 1004) ctrlCommit 0;
        (_dialog displayCtrl 1004) progressSetPosition (_progress + (serverTime - _lastTick) * _rate);
        (_dialog displayCtrl 1998) ctrlSetText format ["#(argb,8,8,3)color(%1,%2,%3,0.6)", _color2 select 0, _color2 select 1, _color2 select 2];
        (_dialog displayCtrl 1997) ctrlSetText format ["#(argb,8,8,3)color(%1,%2,%3,1)", _color2 select 0, _color2 select 1, _color2 select 2];
    }, 0, [_sectorObject]] call CFUNC(addPerFrameHandler);
} else {
    [GVAR(captureStatusPFH)] call CFUNC(removePerFrameHandler);
    GVAR(captureStatusPFH) = -1;

    ([QEGVAR(UI,CaptureStatus)] call BIS_fnc_rscLayer) cutFadeOut 1;
};
nil;
