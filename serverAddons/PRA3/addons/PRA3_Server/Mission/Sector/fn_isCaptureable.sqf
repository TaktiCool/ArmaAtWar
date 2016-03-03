#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Check if a Area is Captureable

    Parameter(s):
    0: Sector to Check <Object>

    Returns:
    is Captureable <Bool>
*/

params ["_sector"];
private _side = _sector getVariable ["side",sideUnknown];
private _activeSides = [];
private _currentCount = {
        private _currentSectorSide = ([_x] call FUNC(getSector)) getVariable ["side",sideUnknown];
        if (_currentSectorSide != sideUnknown) then {
            _activeSides pushBackUnique _currentSectorSide;
        };
        _side != _currentSectorSide && _currentSectorSide != sideUnknown;
    } count (_sector getVariable ["dependency",[]]);

_sector setVariable ["activeSides",_activeSides];
private _ret = true;

if (!(_currentCount > 0) || {(_sector getVariable ["captureProgress",[]]) >= 1}) exitWith {
    if (isServer) then {

        if (_side == sideUnknown && {(_sector getVariable ["captureProgress",[]]) != 0}) then {
            _sector setVariable ["captureProgress",0,true];
        };

        if (_side != sideUnknown && {(_sector getVariable ["captureProgress",[]]) < 1}) then {
            _sector setVariable ["captureProgress",1,true];
        };

        if ((_sector getVariable ["captureRate",0]) != 0) then {
            _sector setVariable ["lastCaptureTick",serverTime,true];
            _sector setVariable ["captureRate",0,true];
        };
    };
    false;
};

_ret;
