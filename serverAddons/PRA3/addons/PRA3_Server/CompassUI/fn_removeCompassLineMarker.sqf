#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Remove a Position from the Compass

    Parameter(s):
    0: Marker ID <String>

    Returns:
    None
*/
params ["_id"];
_id = toLower _id;

private _lineMarkerIDs = [GVAR(lineMarkers), QGVAR(lineMarkerIDs), []] call CFUNC(getVariable);

if (_id in _lineMarkerIDs) then {
    _lineMarkerIDs deleteAt (_lineMarkerIDs find _id);
    GVAR(lineMarkers) setVariable [QGVAR(lineMarkerIDs), _lineMarkerIDs];
    GVAR(lineMarkers) setVariable [_id, nil];
};
