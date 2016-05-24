#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Add Map Icon

    Parameter(s):
    0: Icon Id <String>
    1: Icon definition <Array>
    2: State <String> Default: "normal"

    Remarks:
    Icon <Array>:
        0: Texture <String>
        1: Color <Array> [r,g,b,a]
        2: Position <Position or Object>
        3: Width <Number>
        4: Height <Number>
        5: Angle <Number>
        6: Text <String>
        7: Shadow <Boolean/Number>
        8: Text Size <Number>
        9: Font <String>
        10: Align <String>
        11: Code <Code> called every draw frame

    Returns:
    None
*/
params ["_id", "_icon", ["_state", "normal"]];
if !((_icon select 0) isEqualType []) then {
    _icon = [_icon];
};
private _icons = [];
{
    _x params [
        ["_texture",""],
        ["_color",[0, 0, 0, 1]],
        ["_position", objNull, [[], objNull]],
        ["_size", 25],
        ["_angle", 0,[0,objNull]],
        ["_text",""],
        ["_shadow", 0],
        ["_textSize", 0.08],
        ["_font", "PuristaMedium"],
        ["_align","right"],
        ["_code", {}]
    ];
    private _width = 25;
    private _height = 25;
    if (_size isEqualType 25) then {
        _width = _size;
        _height = _size;
    } else {
        _width = _size select 0;
        _height = _size select 1;
    };
    _icons pushBack [_texture, _color, _position, _width, _height, _angle, _text, _shadow, _textSize, _font, _align, _code];
    nil
} count _icon;

private _stateNum = ["normal", "hover", "selected"] find _state;
if (_stateNum == -1) then {
    _stateNum = 0;
};

private _currentIcons = [GVAR(IconNamespace), _id, [0, [],[],[]]] call FUNC(getVariable);
_currentIcons set [_stateNum + 1, _icons];
GVAR(IconNamespace) setVariable [_id, _currentIcons];
GVAR(MapIconIndex) pushBackUnique _id;
