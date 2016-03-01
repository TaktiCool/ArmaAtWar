#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Frame Loop for Sector Controll

    Parameter(s):
    None

    Returns:
    None
*/


if (!isServer) exitWith {};

if (GVAR(allSectorsArray) isEqualTo []) exitWith {};

GVAR(sectorLoopCounter) = GVAR(sectorLoopCounter) mod (count GVAR(allSectorsArray));
private _cIdx = GVAR(sectorLoopCounter);
private _cSector = GVAR(allSectorsArray) select GVAR(sectorLoopCounter);
GVAR(sectorLoopCounter) = (GVAR(sectorLoopCounter)+1) mod (count GVAR(allSectorsArray));

while {!([_cSector] call FUNC(isCaptureable)) && _cIdx != GVAR(sectorLoopCounter)} do {
    _cSector = GVAR(allSectorsArray) select GVAR(sectorLoopCounter);
    GVAR(sectorLoopCounter) = (GVAR(sectorLoopCounter)+1) mod (count GVAR(allSectorsArray));
};

if (_cIdx == GVAR(sectorLoopCounter)) exitWith {};

private _tick = serverTime;
private _lastTick = _cSector getVariable ["lastCaptureTick",_tick];
private _captureRate = _cSector getVariable ["captureRate",0];
private _lastCaptureRate = _captureRate;
private _captureProgress = _cSector getVariable ["captureProgress",1];
private _lastCaptureProgress = _captureProgress;
private _minUnits = _cSector getVariable ["minUnits",1];
private _side = _cSector getVariable ["side",sideUnknown];
private _lastSide = str _side;
private _attackerSide = _cSector getVariable ["attackerSide",sideUnknown];
private _lastAttackerSide = str _attackerSide;

(_cSector getVariable ["captureTime",[30,60]]) params ["_captureTimeMin","_captureTimeMax"];


private _activeSides = _cSector getVariable ["activeSides",[]];


private _force = [];

private _nbrSides = {
    private _c = {alive _x} count list (_cSector getVariable [format ["trigger_%1",_x],[]]);
    _force pushBack [_c,_x];
    true;
} count _activeSides;

_force sort false; //descending

private _leadingSide = _force select 0 select 1;
private _diff = 0;
if (_nbrSides > 1) then {
    _diff = (_force select 0 select 0) - (_force select 1 select 0);
} else {
    _diff = (_force select 0 select 0);
};

private _forceCount = (_force select 0 select 0);

if (_forceCount >= _minUnits && _diff > 0) then {
    if (_side in [_attackerSide, sideUnknown]) then {
        if (_captureProgress < 1) then {
            _attackerSide = _leadingSide;
            _captureRate = 1/(_captureTimeMin-_captureTimeMax*_diff/9);
        };
    } else {
        _captureRate = -1/(_captureTimeMin-_captureTimeMax*_diff/9);
    };
} else {
    _captureRate = 0;
};

_captureProgress = _captureProgress + (_tick-_lastTick)*_captureRate;

if (_captureProgress <= 0 && _captureRate < 0) then {
    _side = sideUnknown;
    _attackerSide = _leadingSide;
    _captureProgress = 0;
};

if (_captureProgress >= 1 && _captureRate > 0) then {
    _side = _leadingSide;
    _captureProgress = 1;
    _captureRate = 0;
};


_cSector setVariable ["lastCaptureTick",_tick];

if (_captureRate != _lastCaptureRate) then {
    _cSector setVariable ["captureRate",_captureRate, true];
    _cSector setVariable ["captureProgress",_captureProgress,true];
    _cSector setVariable ["lastCaptureTick",_tick, true];
};

if (_captureProgress != _lastCaptureProgress) then {
    _cSector setVariable ["captureProgress",_captureProgress];
};

if ((str _attackerSide) != _lastAttackerSide) then {
    _cSector setVariable ["attackerSide",_attackerSide, true];
};
if ((str _side) != _lastSide) then {
    _cSector setVariable ["side",_side,true];
    ["sector_side_changed",[_cSector,_lastSide,_side]] call FUNC(events,globalEvent);
};
