#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Draws the map icons on map

    Parameter(s):
    0: Map <Control>

    Remarks:
    None

    Returns:
    None
*/
params ["_map"];

private _mapScale = ctrlMapScale _map;
private _cache = [];

if (GVAR(MapGraphicsCacheVersion) != GVAR(MapGraphicsCacheBuildFlag)) then {
    GVAR(MapGraphicsCacheVersion) = GVAR(MapGraphicsCacheBuildFlag);
    call FUNC(buildMapGraphicsCache);
};
// iterate through all mapGraphic objects
{
    private _state = _x select 2;
    private _group = _x select (3 + _state);

    {
        private _groupId = _x select 0;
        private _iconData = _x select 1;
        private _type = _iconData select 0;


        switch (_type) do {
            case ("ICON"): {
                _iconData params ["_type", "_texture", "_color", "_position", "_width", "_height", "_angle", "_text", "_shadow", "_textSize", "_font", "_align", "_code"];
                call _code;

                if (_align isEqualType objNull) then {
                    _align = getDirVisual _align;
                };

                _position = [_position, _map] call CFUNC(mapGraphicsPosition);

                if (_mapScale < 0.1) then {
                    private _fontScale = (_mapScale/0.1) max 0.5;
                    _iconPart set [8, (_iconPart select 8)*_fontScale];
                };

                _map drawIcon [_texture, _color, _position, _width, _height, _angle, _text, _shadow, _textSize, _font, _align];
                _cache pushBack [_groupId, _position, _width, _height, _angle];
            };
            case ("RECTANGLE"): {
                _iconData params ["_position", "_width", "_height", "_angle", "_lineColor", "_fillColor", "_code"];
                call _code;

                if (_align isEqualType objNull) then {
                    _align = getDirVisual _align;
                };

                _position = [_position, _map] call CFUNC(mapGraphicsPosition);

                _map drawRectangle [_position, _width, _height, _angle, _lineColor, _fillColor];
                _cache pushBack [_groupId, _position, _width, _height, _angle];
            };
            case ("ELLIPSE"): {
                _iconData params ["_position", "_width", "_height", "_angle", "_lineColor", "_fillColor", "_code"];
                call _code;

                if (_align isEqualType objNull) then {
                    _align = getDirVisual _align;
                };

                _position = [_position, _map] call CFUNC(mapGraphicsPosition);

                _map drawEllipse [_position, _width, _height, _angle, _lineColor, _fillColor];
                _cache pushBack [_groupId, _position, _width, _height, _angle];
            };
            case ("LINE"): {
                _iconData params ["_pos1", "_pos2", "_lineColor", "_code"];
                call _code;

                _pos1 = [_pos1, _map] call CFUNC(mapGraphicsPosition);
                _pos2 = [_pos2, _map] call CFUNC(mapGraphicsPosition);

                _map drawLine [_pos1, _pos2, _lineColor];
            };
            case ("ARROW"): {
                _iconData params ["_pos1", "_pos2", "_lineColor", "_code"];
                call _code;

                _pos1 = [_pos1, _map] call CFUNC(mapGraphicsPosition);
                _pos2 = [_pos2, _map] call CFUNC(mapGraphicsPosition);

                _map drawLine [_pos1, _pos2, _lineColor];
            };
            case ("ARROW"): {
                _iconData params ["_positions", "_lineColor", "_code"];
                call _code;
                {
                    _positions set [_forEachIndex, [_x, _map] call CFUNC(mapGraphicsPosition)];
                } forEach _positions;

                _map drawLine [_positions, _lineColor];
            };
        };
        nil
    } count _group;

    nil
} count GVAR(MapGraphicsCache);

GVAR(MapGraphicsGeometryCache) = _cache;
