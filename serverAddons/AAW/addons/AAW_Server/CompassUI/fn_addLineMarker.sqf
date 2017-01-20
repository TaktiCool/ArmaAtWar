#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas, NetFusion

    Description:
    Add a compass line marker to the compass hub.

    Parameter(s):
    0: Id <String>
    1: Color <Array>
    2: Position <Array>

    Returns:
    None
*/
params ["_id", "_color", "_position"];

[GVAR(lineMarkers), _id, [_color, _position], QGVAR(lineMarkersCache)] call CFUNC(setVariable);
