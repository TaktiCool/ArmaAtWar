#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Add a Compass Position Marker

    Parameter(s):
    0: ID <String>
    1:

    Returns:
    None
*/
// easy to use for Events
if (_this select 0 isEqualType "") then {
    _this = [_this];
};
(_this select 0) params ["_id", "_color", "_position"];

private _allMarkers = [GVAR(lineMarkers), QGVAR(allLineMarkers), []] call CFUNC(getVariableLoc);
_id = toLower(_id);
if !(_id in _allMarkers) then {
    _allMarkers pushBack _id;
    GVAR(lineMarkers) setVariable [QGVAR(allLineMarkers), _allMarkers];
};

GVAR(lineMarkers) setVariable [_id, [_color, _position]];
