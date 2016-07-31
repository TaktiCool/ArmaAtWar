#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Kill a Statemaschine.

    Parameter(s):
    0: Statemaschine Index <Number>

    Returns:
    None
*/
params ["_index"];

_index call CFUNC(removePerFrameHandler);
