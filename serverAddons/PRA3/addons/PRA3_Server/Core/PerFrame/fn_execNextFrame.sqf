#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: esteldunedain ported by joko // Jonas

    Description:
    Execture a Code on the Next Frame

    Parameter(s):
    0: Code to execute <Code>
    1: Parameters to run the code with <Array>

    Returns:
    None
*/
params [["_func",{}], ["_params", []]];

if (isNil QGVAR(nextFrameBufferA)) then {
    GVAR(nextFrameBufferA) = [];
};
if (isNil QGVAR(nextFrameBufferB)) then {
    GVAR(nextFrameBufferB) = [];
};
if (isNil QGVAR(nextFrameNo)) then {
    GVAR(nextFrameNo) = diag_frameno + 1;
};
if (diag_frameno == GVAR(nextFrameNo)) then {
    GVAR(nextFrameBufferB) pushBack [_params, _func];
} else {
    GVAR(nextFrameBufferA) pushBack [_params, _func];
};
Nil
