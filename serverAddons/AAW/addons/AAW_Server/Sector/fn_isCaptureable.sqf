#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Check if a Sector is Captureable

    Parameter(s):
    0: Sector to Check <Object> or <String>

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
    !(_currentSectorSide in [sideUnknown,_side])
} count (_sector getVariable ["dependency",[]]);

if (isServer) then {
    _sector setVariable ["activeSides", _activeSides];
};

(_currentCount > 0);
