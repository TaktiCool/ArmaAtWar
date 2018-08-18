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
    if !(isNull (uiNamespace getVariable [UIVAR(CaptureStatus), displayNull])) exitWith {
        [{
            if (GVAR(currentSector) != (_this select 1)) exitWith {};
            _this call FUNC(showCaptureStatus);
        }, {
            (isNull (uiNamespace getVariable [UIVAR(CaptureStatus), displayNull]))
        }, _this] call CFUNC(waitUntil);
    };

    //QEGVAR(UI,CaptureStatus) cutRsc [QEGVAR(UI,CaptureStatus), "PLAIN"];
    UIVAR(CaptureStatus) cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
    private _display = uiNamespace getVariable ["RscTitleDisplayEmpty", displayNull];
    if (isNull _display) exitWith {};

    (_display displayCtrl 1202) ctrlSetFade 1;
    (_display displayCtrl 1202) ctrlShow false;
    (_display displayCtrl 1202) ctrlCommit 0;

    private _ctrlGrp = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
    _ctrlGrp ctrlSetPosition [ 0.5 - PX(10.5), safeZoneY + PY(4), PX(30), PY(3)];
    _ctrlGrp ctrlSetFade 1;
    _ctrlGrp ctrlCommit 0;

    private _ctrlBg = _display ctrlCreate ["RscText", -1, _ctrlGrp];
    _ctrlBg ctrlSetPosition [0, 0, PX(21), PY(2.5)];
    _ctrlBg ctrlSetBackgroundColor [0.5, 0.5, 0.5, 0.5];
    _ctrlBg ctrlCommit 0;

    private _ctrlProgressBar = _display ctrlCreate ["RscProgress", 1004, _ctrlGrp];
    _ctrlProgressBar ctrlSetPosition [0, 0, PX(21), PY(0.2)];
    _ctrlProgressBar ctrlCommit 0;

    private _textSize = PY(2.2) / (((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1);

    private _ctrlText = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrp];
    _ctrlText ctrlSetPosition [0, PY(0.2), PX(21), PY(2.3)];
    _ctrlText ctrlSetStructuredText parseText format ["<t size='%1' align='center' shadow=false><t font='RobotoCondensedBold'>%2</t>  %3</t>", _textSize, _sectorObject getVariable ["designator", ""], _sectorObject getVariable ["fullName", ""]];
    _ctrlText ctrlCommit 0;

    _ctrlGrp ctrlSetFade 0;
    _ctrlGrp ctrlCommit 1;


    uiNamespace setVariable [UIVAR(CaptureStatus), _display];


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

        private _dialog = uiNamespace getVariable UIVAR(CaptureStatus);

        private _color = [
            [0.6, 0, 0, 1],
            [0, 0.4, 0.8, 1]
        ] select (_aside isEqualTo side group CLib_player);

        if (_aside isEqualTo sideUnknown) then {
            _color = [0, 0, 0, 0];
        };

        (_dialog displayCtrl 1004) ctrlSetTextColor _color;
        (_dialog displayCtrl 1004) ctrlCommit 0;
        (_dialog displayCtrl 1004) progressSetPosition (_progress + (serverTime - _lastTick) * _rate);
    }, 0, [_sectorObject]] call CFUNC(addPerFrameHandler);
} else {
    [GVAR(captureStatusPFH)] call CFUNC(removePerFrameHandler);
    GVAR(captureStatusPFH) = -1;

    ([UIVAR(CaptureStatus)] call BIS_fnc_rscLayer) cutFadeOut 1;
};
nil;
