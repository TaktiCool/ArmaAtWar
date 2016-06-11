#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Updates Sector State when Sector is Active

    Parameter(s):
    0: Sector

    Returns:
    None
*/

params ["_params", "_pfhId"];
_params params ["_sector"];

// if sector is not active (e.g. dependencies are not fulfilled )
if !(_sector getVariable ["isActive", false]) exitWith {
    // if sector is neutral and is being captured
    if (_side == sideUnknown && {(_sector getVariable ["captureProgress",[]]) != 0}) then {
        // reset capture progress to 0
        _sector setVariable ["captureProgress", 0, true];
    };

    // if sector is owned by a faction but captured by another faction
    if (_side != sideUnknown && {(_sector getVariable ["captureProgress",[]]) < 1}) then {
        // reset capture progress to 1
        _sector setVariable ["captureProgress", 1, true];
    };

    // if sector is being captured
    if ((_sector getVariable ["captureRate",0]) != 0) then {
        // reset capture variables
        _sector setVariable ["lastCaptureTick", serverTime, true];
        _sector setVariable ["captureRate", 0, true];
    };
    _pfhId call CFUNC(removePerFrameHandler);
};

// get all necessary variables from sector
private _tick = serverTime;
private _lastTick = _sector getVariable ["lastCaptureTick",_tick];
private _captureRate = _sector getVariable ["captureRate",0];
private _lastCaptureRate = _captureRate;
private _captureProgress = _sector getVariable ["captureProgress",1];
private _lastCaptureProgress = _captureProgress;
private _minUnits = _sector getVariable ["minUnits",1];
private _side = _sector getVariable ["side",sideUnknown];
private _lastSide = _side;
private _attackerSide = _sector getVariable ["attackerSide",sideUnknown];
private _lastAttackerSide = str _attackerSide;
private _activeSides = _sector getVariable ["activeSides",[]];

(_sector getVariable ["captureTime",[30,60]]) params ["_captureTimeMin","_captureTimeMax"];

// load firstCaptureTime, when sector was not captured before
if !(_sector getVariable ["firstCaptureDone", false]) then {
    private _temp = (_sector getVariable ["firstCaptureTime",[5,15]]);
    _captureTimeMin = _temp select 0;
    _captureTimeMax = _temp select 1;
};

// Get all active units of available sides
private _force = [];
private _nbrSides = {
    private _c = {_x call CFUNC(isAlive)} count (_sector getVariable [format ["units%1", _x], []]);
    _force pushBack [_c,_x];
    true;
} count _activeSides;

// calculate leading force by sorting
_force sort false; //descending
private _leadingSide = _force select 0 select 1;

// calculate force difference
private _diff = 0;
if (_nbrSides > 1) then {
    _diff = (_force select 0 select 0) - (_force select 1 select 0);
} else {
    _diff = (_force select 0 select 0);
};

private _forceCount = (_force select 0 select 0); // absolute player force of leading side

// calculate capture rate depending on unit difference
if (_forceCount >= _minUnits && _diff > 0) then {
    if (_side in [_leadingSide, sideUnknown]) then {
        if (_captureProgress < 1) then {
            _attackerSide = _leadingSide;
            _captureRate = 1/(_captureTimeMin+(_captureTimeMax-_captureTimeMin)*(1-((_diff/9) min 1)));
        };
    } else {
        _captureRate = -1/(_captureTimeMin+(_captureTimeMax-_captureTimeMin)*(1-((_diff/9) min 1)));
    };
} else {
    _captureRate = 0;
};

// Update current capture progress
_captureProgress = _captureProgress + (_tick-_lastTick)*_captureRate;

// neutralize sector if capture progress is <= 0
if (_captureProgress <= 0 && _captureRate < 0) then {
    _side = sideUnknown;
    _attackerSide = _leadingSide;
    _captureProgress = 0;
};

// change sides if capture progress is >= 1
if (_captureProgress >= 1 && _captureRate > 0) then {
    _side = _leadingSide;
    _captureProgress = 1;
    _captureRate = 0;
};

// update variables on sector (if necessary)
_sector setVariable ["lastCaptureTick",_tick];

if (_captureRate != _lastCaptureRate) then {
    _sector setVariable ["captureRate",_captureRate, true];
    _sector setVariable ["captureProgress",_captureProgress,true];
    _sector setVariable ["lastCaptureTick",_tick, true];
};

if (_captureProgress != _lastCaptureProgress) then {
    _sector setVariable ["captureProgress",_captureProgress];
};

if ((str _attackerSide) != _lastAttackerSide) then {
    _sector setVariable ["attackerSide",_attackerSide, true];
};

// throw event when sector side changes
if (str _side != str _lastSide) then {
    _sector setVariable ["side",_side,true];
    ["sectorSideChanged",[_sector,_lastSide,_side]] call CFUNC(globalEvent);
    _sector setVariable ["firstCaptureDone", true, true];
};
