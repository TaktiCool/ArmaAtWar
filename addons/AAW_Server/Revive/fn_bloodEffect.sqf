#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Visualization of Blood

    Parameter(s):
    0: Intensity (0..1) <Number>

    Returns:
    None
*/
params ["_intensity"];

private _firstInit = false;
if (isNull (uiNamespace getVariable ["RscHealthTextures", displayNull])) then {
    ([QGVAR(PPBloodEffect)] call BIS_fnc_rscLayer) cutRsc ["RscHealthTextures", "plain"];
    _firstInit = true;
    GVAR(PPBloodEffectIntensity) = 0;
};

private _lowerIntensity = 0 max ((_intensity * 3) min 1);
private _middleIntensity = 0 max ((_intensity * 3 - 1) min 1);
private _upperIntensity = 0 max ((_intensity * 3 - 2) min 1);

private _display = uiNamespace getVariable "RscHealthTextures";

private _x = ((0 * safeZoneW) + safeZoneX) + ((safeZoneW - (2.125 * safeZoneW * 3 / 4)) / 2);
private _y = (-0.0625 * safeZoneH) + safeZoneY;
private _w = 2.125 * safeZoneW * 3 / 4;
private _h = 1.125 * safeZoneH;

private _texLower = _display displayCtrl 1211;
private _texMiddle = _display displayCtrl 1212;
private _texUpper = _display displayCtrl 1213;

if (_firstInit) then {
    _texLower ctrlSetFade 1;
    _texMiddle ctrlSetFade 1;
    _texUpper ctrlSetFade 1;

    _texLower ctrlSetPosition [_x, _y, _w, _h];
    _texMiddle ctrlSetPosition [_x, _y, _w, _h];
    _texUpper ctrlSetPosition [_x, _y, _w, _h];

    _texLower ctrlCommit 0;
    _texMiddle ctrlCommit 0;
    _texUpper ctrlCommit 0;
};

if (GVAR(PPBloodEffectIntensity) > _intensity) exitWith {};

GVAR(PPBloodEffectIntensity) = _intensity;

_texLower ctrlSetFade (1 - 0.8 * _lowerIntensity);
_texMiddle ctrlSetFade (1 - 0.8 * _middleIntensity);
_texUpper ctrlSetFade (1 - 0.8 * _upperIntensity);

_texLower ctrlCommit 0.1;
_texMiddle ctrlCommit 0.1;
_texUpper ctrlCommit 0.1;

private _fadeOut = {
    params ["_tex", "_time"];
    _tex ctrlSetFade 1;
    _tex ctrlCommit _time;
};

[{GVAR(PPBloodEffectIntensity) = 0}, 1.5, [_texUpper, 1.5]] call CFUNC(wait);

if (_upperIntensity > 0) then {
    [_fadeOut, 1.5, [_texUpper, 1.5]] call CFUNC(wait);
};

if (_middleIntensity > 0) then {
    [_fadeOut, 2, [_texMiddle, 1]] call CFUNC(wait);
};

if (_lowerIntensity > 0) then {
    [_fadeOut, 2.5, [_texLower, 0.8]] call CFUNC(wait);
};
