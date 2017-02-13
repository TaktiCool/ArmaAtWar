#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas, NetFusion

    Description:
    Add a compass line marker to the compass hub.

    Parameter(s):
    0: Id <String> (Default: "")
    1: Color <Array> (Default: [0, 0, 0, 1])
    2: Position <Array> (Default: [0, 0, 0])

    Returns:
    None
*/

params [
    ["_id", "", [""]],
    ["_color", [], [[]], 4],
    ["_position", [0, 0, 0], [[]], 3]
];

[GVAR(lineMarkers), _id, [_color, _position], QGVAR(lineMarkersCache)] call CFUNC(setVariable);
