#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Camera update loop for the spectator camera

    Parameter(s):
    None

    Returns:
    None
*/

private _forward = [sin GVAR(CameraDir), cos GVAR(CameraDir), 0];
private _right = [cos GVAR(CameraDir), -sin GVAR(CameraDir), 0];

// Calculate velocity
private _velocity = [0, 0, 0];
if (GVAR(InputMode) == 0) then {
    if (inputAction "cameraMoveForward" > 0) then {
        _velocity = _velocity vectorAdd _forward;
    };
    if (inputAction "cameraMoveBackward" > 0) then {
        _velocity = _velocity vectorDiff _forward;
    };
    if (inputAction "cameraMoveRight" > 0) then {
        _velocity = _velocity vectorAdd _right;
    };
    if (inputAction "cameraMoveLeft" > 0) then {
        _velocity = _velocity vectorDiff _right;
    };
    if (inputAction "cameraMoveUp" > 0) then {
        _velocity = _velocity vectorAdd [0, 0, 1];
    };
    if (inputAction "cameraMoveDown" > 0) then {
        _velocity = _velocity vectorAdd [0, 0, -1];
    };
};

switch (GVAR(CameraMode)) do {
    case 1: { // FREE
        GVAR(CameraPos) = GVAR(CameraPos) vectorAdd (_velocity vectorMultiply (GVAR(CameraSpeed) * CGVAR(deltaTime)));
    };
    case 2: { // FOLLOW
        if (isNull GVAR(CameraFollowTarget)) exitWith {
            GVAR(CameraMode) = 1;
            [QGVAR(CameraModeChanged), GVAR(CameraMode)] call CFUNC(localEvent);
        };
        GVAR(CameraRelPos) = GVAR(CameraRelPos) vectorAdd (_velocity vectorMultiply (GVAR(CameraSpeed) * CGVAR(deltaTime)));
        GVAR(CameraPos) = getPosASLVisual GVAR(CameraFollowTarget) vectorAdd GVAR(CameraRelPos);
    };
};

private _position = GVAR(CameraPos);
private _direction = GVAR(CameraDir) + GVAR(CameraDirOffset);
private _pitch = GVAR(CameraPitch) + GVAR(CameraPitchOffset);

// Smoothing
if (GVAR(CameraSmoothingTime) > 0) then {
    GVAR(CameraPreviousState) params [
        ["_lastTime", time - 0.1],
        ["_lastPosition", _position],
        ["_lastDirection", _direction],
        ["_lastPitch", _pitch]
    ];

    private _smoothingAmount = GVAR(CameraSmoothingTime) / (time - _lastTime);
    _position = (_lastPosition vectorMultiply _smoothingAmount vectorAdd _position) vectorMultiply (1 / (1 + _smoothingAmount));

    private _sinDirection = ((sin _lastDirection) * _smoothingAmount + sin _direction) / (1 + _smoothingAmount);
    private _cosDirection = ((cos _lastDirection) * _smoothingAmount + cos _direction) / (1 + _smoothingAmount);
    _cameraDirection = _sinDirection atan2 _cosDirection;

    private _sinPitch = ((sin _lastPitch) * _smoothingAmount + sin _pitch) / (1 + _smoothingAmount);
    private _cosPitch = ((cos _lastPitch) * _smoothingAmount + cos _pitch) / (1 + _smoothingAmount);
    _cameraPitch = _sinPitch atan2 _cosPitch;

    GVAR(CameraPreviousState) = [time, _position, _direction, _pitch];
} else {
    GVAR(CameraPreviousState) = [];
};

GVAR(Camera) setPosASL _position;
GVAR(Camera) setVectorDirAndUp [[sin _direction * cos _pitch, cos _direction * cos _pitch, sin _pitch], [0, 0, cos _pitch]];
