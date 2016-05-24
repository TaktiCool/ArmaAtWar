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
params ["_id", "_color", "_position"];
_id = toLower _id;

private _lineMarkerIDs = [GVAR(lineMarkers), QGVAR(lineMarkerIDs), []] call CFUNC(getVariable);

if (!(_id in _lineMarkerIDs)) then {
    _lineMarkerIDs pushBack _id;
    GVAR(lineMarkers) setVariable [QGVAR(lineMarkerIDs), _lineMarkerIDs]; //@todo maybe we do not need this and use allVariables instead?
};

GVAR(lineMarkers) setVariable [_id, [_color, _position]];
