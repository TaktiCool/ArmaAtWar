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

private _r = 100000;
private _nearestIcon = "";
{
    private _iconId = _x;
    private _icon = GVAR(IconNamespace) getVariable _iconId;
    private _icons = _icon select 1;
    {
        private _iconPart = _x call {
            params [
                ["_texture",""],
                ["_color",[0, 0, 0, 1]],
                ["_position", objNull, [[], objNull]],
                ["_width", 25],
                ["_height", 25],
                ["_angle", 0,[0,objNull]],
                ["_text",""],
                ["_shadow", 0],
                ["_textSize", 0.08],
                ["_font", "PuristaMedium"],
                ["_align","right"],
                ["_code", {}]
            ];
            call _code;
            [_texture, _color, _position, _width, _height, _angle, _text, _shadow, _textSize, _font, _align];
        };
        _iconPart params ["", "", "_pos", "_width", "_height"];
        if (_pos isEqualType [] && {(_pos select 1) isEqualType []}) then {
            private _offset = _pos select 1;
            private _tempPos = _pos select 0;
            if (_tempPos isEqualType objNull) then {
                _tempPos = getPosVisual _tempPos;
            };
            _tempPos = _map ctrlMapWorldToScreen _tempPos;
            _pos = [(_tempPos select 0) + (_offset select 0)/640, (_tempPos select 1) + (_offset select 1)/480];
        } else {
            if (_pos isEqualType objNull) then {
                _pos = getPosVisual _pos;
            };
            _pos = _map ctrlMapWorldToScreen _pos;
        };
        // DUMP(_pos)
        private _temp1 = (_pos select 0) - (_mousePosition select 0);
        private _temp2 = (_pos select 1) - (_mousePosition select 1);

        if (abs(_temp1*640) < _width/2 && abs(_temp2*480) < _height/2) then {
            _temp1 = _pos distance _mousePosition;
            if (_temp1 < _r) then {
                _nearestIcon = _iconId;
                _r = _temp1;
            };
        };
        nil
    } count _icons;
    nil;
} count GVAR(MapIconIndex);
private _temp = [_this, _nearestIcon];

_nearestIcon
