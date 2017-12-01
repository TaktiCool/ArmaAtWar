#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Camera update loop (pfh) for the Spectator camera

    Parameter(s):
    None
    Returns:
    None
*/

private _forward = [sin GVAR(cameraDir) , cos GVAR(cameraDir), 0];
private _right = [cos GVAR(cameraDir) , -sin GVAR(cameraDir), 0];
private _velVector = [0, 0, 0];
if (GVAR(InputMode) == 0) then {
    if (inputAction "cameraMoveForward" > 0) then {
        _velVector = _velVector vectorAdd _forward;
    };
    if (inputAction "cameraMoveBackward" > 0) then {
        _velVector = _velVector vectorDiff _forward;
    };
    if (inputAction "cameraMoveRight" > 0) then {
        _velVector = _velVector vectorAdd _right;
    };
    if (inputAction "cameraMoveLeft" > 0) then {
        _velVector = _velVector vectorDiff _right;
    };
    if (inputAction "cameraMoveUp" > 0) then {
        _velVector = _velVector vectorAdd [0, 0, 1];
    };
    if (inputAction "cameraMoveDown" > 0) then {
        _velVector = _velVector vectorAdd [0, 0, -1];
    };
};

switch (GVAR(CameraMode)) do {
    case (1): { // FREE
        if !(_velVector isEqualTo [0,0,0]) then {
            GVAR(cameraPos) = GVAR(cameraPos) vectorAdd (_velVector vectorMultiply (GVAR(CameraSpeed)*CGVAR(deltaTime)));
        };
    };
    case (2): { // FOLLOW
        if (isNull GVAR(CameraFollowTarget)) exitWith {
            GVAR(CameraMode) = 1;
            [QGVAR(CameraModeChanged), GVAR(CameraMode)] call CFUNC(localEvent);
        };
        GVAR(CameraRelPos) = GVAR(CameraRelPos) vectorAdd (_velVector vectorMultiply (GVAR(CameraSpeed)*CGVAR(deltaTime)));
        GVAR(cameraPos) = getPosASLVisual GVAR(CameraFollowTarget) vectorAdd GVAR(CameraRelPos);
    };
};

[] call DFUNC(setCameraPosDirPitch);
