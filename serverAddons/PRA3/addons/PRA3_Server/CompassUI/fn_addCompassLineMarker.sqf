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

GVAR(lineMarkers) setVariable [_id, [_color, _position]];
