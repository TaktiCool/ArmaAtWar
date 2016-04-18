#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Draws the Map Icons

    Parameter(s):
    0: Map <Control>

    Remarks:
    None

    Returns:
    None
*/
disableSerialization;
params ["_map"];

private _mapScale = ctrlMapScale _map;
private _cache = [];

{
    private _mapIconId = _x;
    private _icon = GVAR(IconNamespace) getVariable _mapIconId;

    if !(isNil "_icon") then {
        private _icons = _icon select (1 + (_icon select 0));
        if (_icons isEqualTo []) then {
            _icons = _icon select 1;
        };
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

            if ((_iconPart select 5) isEqualType objNull) then {
                _iconPart set [5, getDirVisual (_iconPart select 5)];
            };

            if ((_iconPart select 2) isEqualType [] && {(_iconPart select 2 select 1) isEqualType []}) then {
                private _pos = _iconPart select 2 select 0;
                private _offset = _iconPart select 2 select 1;
                if (_pos isEqualType objNull) then {
                    _pos = getPosVisual _pos;
                };
                _pos = _map ctrlMapWorldToScreen _pos;
                _pos = [(_pos select 0) + (_offset select 0)/640, (_pos select 1) + (_offset select 1)/480];
                _pos = _map ctrlMapScreenToWorld _pos;
                _iconPart set [2, _pos];
            };

            if ((_iconPart select 2) isEqualType objNull) then {
                _iconPart set [2, getPosVisual (_iconPart select 2)];
            };

            if (_mapScale < 0.1) then {
                private _fontScale = (_mapScale/0.1) max 0.5;
                _iconPart set [8, (_iconPart select 8)*_fontScale];
            };

            private _pos = _iconPart select 2;
            if (!isNil "_pos") then {
                _map drawIcon _iconPart;
            };
            _cache pushBack [_mapIconId, _pos, _iconPart select 3, _iconPart select 4];
            nil
        } count _icons;
    };
    nil
} count GVAR(MapIconIndex);

GVAR(MapIconCache) = _cache;
