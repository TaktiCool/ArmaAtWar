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
params ["_map", "_xPos", "_yPos"];

private _mousePosition = [_xPos, _yPos];

private _r = 1000;
private _nearestIcon = "";
{
    private _iconId = _x;
    private _icon = GVAR(IconNamespace) getVariable _iconId;
    private _icons = _icon select 1;
    {
        private _pos = _x select 2;
        private _width = _x select 3;
        private _height = _x select 4;
        if (_pos isEqualType [] && {(_pos select 1) isEqualType []}) then {
            private _pos = _pos select 0;
            private _offset = _pos select 1;
            if (_pos isEqualType objNull) then {
                _pos = getPosVisual _pos;
            };
            _pos = _map ctrlMapWorldToScreen _pos;
            _pos = [(_pos select 0) + (_offset select 0)/640, (_pos select 1) + (_offset select 1)/480];
        } else {
            if (_pos isEqualType objNull) then {
                _pos = getPosVisual _pos;
            };
            _pos = _map ctrlMapWorldToScreen _pos;
        };
        private _temp1 = (_pos select 0) - (_mousePosition select 0);
        private _temp2 = (_pos select 1) - (_mousePosition select 1);

        if (abs(_temp1*640) < _width/2 && abs(_temp2*480) < _height/2) then {
            _temp1 = _pos distance _mousePosition;
            if (_temp1 < _r) then {
                _nearestIcon = _iconId;
                _r = _temp1;
            };
        };
    } count _icons;
    nil;
} count GVAR(MapIconIndex);
private _temp = [_this, _nearestIcon];

_nearestIcon
