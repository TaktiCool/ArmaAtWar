#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Sets the spectator cameras position, pitch and direction

    Parameter(s):
    0: position <Position3D>
    1: pitch [in Degree] <Number>
    2: direction [in Degree] <Number>
    Returns:
    None
*/
params [
    ["_pos", GVAR(cameraPos)],
    ["_dir", GVAR(cameraDir) + GVAR(cameraDirOffset)],
    ["_pitch", GVAR(cameraPitch) + GVAR(cameraPitchOffset)]
];

if (GVAR(CameraSmoothingTime) > 0) then {
    GVAR(CameraStateHistory) params [["_time", time-0.1],["_posHist", _pos], ["_dirHist", _dir], ["_pitchHist", _pitch]];
    _pos = (_posHist vectorMultiply GVAR(CameraSmoothingTime)/(time-_time) vectorAdd _pos) vectorMultiply (1/(1+GVAR(CameraSmoothingTime)/(time-_time)));
    private _sinDir = ((sin _dirHist)*GVAR(CameraSmoothingTime)/(time-_time) + sin _dir) * 1/((1+GVAR(CameraSmoothingTime)));
    private _cosDir = ((cos _dirHist)*GVAR(CameraSmoothingTime)/(time-_time) + cos _dir) * 1/((1+GVAR(CameraSmoothingTime)));
    _dir = _sinDir atan2 _cosDir;
    private _sinPitch = ((sin _pitchHist)*GVAR(CameraSmoothingTime)/(time-_time) + sin _pitch) * 1/((1+GVAR(CameraSmoothingTime)/(time-_time)));
    private _cosPitch = ((cos _pitchHist)*GVAR(CameraSmoothingTime)/(time-_time) + cos _pitch) * 1/((1+GVAR(CameraSmoothingTime)/(time-_time)));
    _pitch = _sinPitch atan2 _cosPitch;
    GVAR(CameraStateHistory) = [time, _pos, _dir, _pitch];
} else {
    GVAR(CameraStateHistory) = [];
};


GVAR(camera) setPosASL _pos;
GVAR(camera) setVectorDirAndUp ([_dir, _pitch] call DFUNC(angle2Vec));
