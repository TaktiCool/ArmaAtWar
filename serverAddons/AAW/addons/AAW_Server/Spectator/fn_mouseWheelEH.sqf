#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    MouseWheel-EH for the Spectator

    Parameter(s):
    0: display <Display>
    1: value <Number>
    Returns:
    None
*/
params ["_display", "_value"];
if (GVAR(CameraSpeedMode)) exitWith {
    GVAR(CameraSpeed) = CAMERAMINSPEED max (CAMERAMAXSPEED min (GVAR(CameraSpeed)*sqrt(2)^_value));
    [QGVAR(CameraSpeedChanged)] call CFUNC(localEvent);
    true;
};

if (GVAR(CameraSmoothingMode)) exitWith {
    if (GVAR(CameraSmoothingTime) == 0) then {
        GVAR(CameraSmoothingTime) = 0.05;
    };
    GVAR(CameraSmoothingTime) = 0.05 max (1.6 min (GVAR(CameraSmoothingTime)*sqrt(2)^_value));
    if (GVAR(CameraSmoothingTime) <= 0.05) then {
        GVAR(CameraSmoothingTime) = 0;
    };
    [QGVAR(CameraSmoothingChanged)] call CFUNC(localEvent);
    true;
};
false;
