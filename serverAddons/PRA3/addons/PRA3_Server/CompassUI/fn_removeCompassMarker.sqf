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

private _allMarkers = [GVAR(lineMarkers), QGVAR(allLineMarkers), []] call CFUNC(getVariableLoc);

_id = toLower (_id);

if (_id in _allMarkers) then {
    _allMarkers deleteAt (_allMarkers find _id);
    GVAR(lineMarkers) setVariable [QGVAR(allLineMarkers), _allMarkers];
    GVAR(lineMarkers) setVariable [_id, nil];
};
