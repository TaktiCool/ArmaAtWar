#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Visualization of Blood

    Parameter(s):
    0: Intensity (0..1) <Number>

    Returns:
    None
*/
disableSerialization;
params ["_intensity"];
private _firstInit = false;
if (isnull (uinamespace getVariable ["RscHealthTextures", displayNull])) then {
    ([QGVAR(PPBloodEffect)] call bis_fnc_rscLayer) cutRsc ["RscHealthTextures","plain"];
    _firstInit = true;
    GVAR(PPBloodEffectIntensity) = 0;
};

private _lowerIntensity = 0 max ((_intensity*3) min 1);
private _middleIntensity = 0 max ((_intensity*3-1) min 1);
private _upperIntensity = 0 max ((_intensity*3-2) min 1);

private _display = uinamespace getVariable "RscHealthTextures";

private _x = ((0 * safezoneW) + safezoneX) + ((safezoneW - (2.125 * safezoneW * 3/4)) / 2);
private _y = (-0.0625 * safezoneH) + safezoneY;
private _w = 2.125 * safezoneW * 3/4;
private _h = 1.125 * safezoneH;


private _texLower = _display displayctrl 1211;
private _texMiddle = _display displayctrl 1212;
private _texUpper = _display displayctrl 1213;


if (_firstInit) then {
    _texLower ctrlSetFade 1;
    _texMiddle ctrlSetFade 1;
    _texUpper ctrlSetFade 1;

    _texLower ctrlsetposition [_x, _y, _w, _h];
    _texMiddle ctrlsetposition [_x, _y, _w, _h];
    _texUpper ctrlsetposition [_x, _y, _w, _h];

    _texLower ctrlCommit 0;
    _texMiddle ctrlCommit 0;
    _texUpper ctrlCommit 0;
};

hint format["texLower: %1", ctrlFade _texLower];

if (GVAR(PPBloodEffectIntensity) > _intensity) exitWith {};

GVAR(PPBloodEffectIntensity) = _intensity;


_texLower ctrlSetFade (1 - 0.8 * _lowerIntensity);
_texMiddle ctrlSetFade (1 - 0.8 * _middleIntensity);
_texUpper ctrlSetFade (1 - 0.8 * _upperIntensity);

_texLower ctrlCommit 0.1;
_texMiddle ctrlCommit 0.1;
_texUpper ctrlCommit 0.1;

private _fadeOut = {
    disableSerialization;
    params ["_tex", "_time"];
    _tex ctrlsetfade 1;
    _tex ctrlCommit _time;
};

[{GVAR(PPBloodEffectIntensity) = 0;}, 1.5, [_texUpper,1.5]] call CFUNC(wait);

if (_upperIntensity > 0) then {
    [_fadeOut, 1.5, [_texUpper,1.5]] call CFUNC(wait);
};

if (_middleIntensity > 0) then {
    [_fadeOut, 2, [_texMiddle,1]] call CFUNC(wait);
};

if (_lowerIntensity > 0) then {
    [_fadeOut, 2.5, [_texLower,0.8]] call CFUNC(wait);
};
