#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Get Icon at Position (Screen Coordinates)

    Parameter(s):
    0: Map <Control>
    1: X coordinate <Number>
    2: Y coordinate <Number>

    Remarks:
    None

    Returns:
    Icon ID <String>
*/
disableSerialization;
params ["_map", "_xPos", "_yPos"];

private _mousePosition = [_xPos, _yPos];

private _r = 100000;
private _nearestIcon = "";
{
    private _iconId = _x select 0;
    private _pos = _map ctrlMapWorldToScreen (_x select 1);
    private _width = _x select 2;
    private _height = _x select 3;

    private _temp1 = (_pos select 0) - (_mousePosition select 0);
    private _temp2 = (_pos select 1) - (_mousePosition select 1);

    if (abs(_temp1*640) < _width/2 && abs(_temp2*480) < _height/2) then {
        _temp1 = _pos distance _mousePosition;
        if (_temp1 < _r) then {
            _nearestIcon = _iconId;
            _r = _temp1;
        };
    };


    nil;
} count GVAR(MapIconCache);

_nearestIcon
