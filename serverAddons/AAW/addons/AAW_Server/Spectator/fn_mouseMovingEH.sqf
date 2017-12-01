#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    MouseMoving-EH for the Spectator

    Parameter(s):
    0: display <Display>
    1: deltaX <Number>
    2: deltaY <Number>
    Returns:
    None
*/
params ["", "_deltaX", "_deltaY"];

if (GVAR(CameraOffsetMode)) then {
    GVAR(cameraDirOffset) = GVAR(cameraDirOffset) + _deltaX*0.5;
    GVAR(cameraPitchOffset) = -89.0 max (89.9 min (GVAR(cameraPitchOffset) - _deltaY*0.5));
} else {
    GVAR(cameraDir) = GVAR(cameraDir) + _deltaX*0.5;
    GVAR(cameraPitch) = -89.0 max (89.9 min (GVAR(cameraPitch) - _deltaY*0.5));
};
