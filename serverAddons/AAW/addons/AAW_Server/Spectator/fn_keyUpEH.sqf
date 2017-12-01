#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    KeyUp-EH for the Spectator

    Parameter(s):
    0: display <Display>
    1: keyCode <Number>
    2: isShiftPressed <Boolean>
    2: isCtrlPressed <Boolean>
    2: isAltPressed <Boolean>
    Returns:
    None
*/
params ["_display", "_keyCode"];

switch (_keyCode) do {
    case (0x2A): {
        GVAR(CameraSpeedMode) = false;
        false;
    };
    case (0x1D): {
        GVAR(CameraSmoothingMode) = false;
        false;
    };
    case (0x38): {
        GVAR(CameraOffsetMode) = false;
        GVAR(cameraDirOffset) = 0;
        GVAR(cameraPitchOffset) = 0;
        false;
    };
    default {
        false;
    };
};
