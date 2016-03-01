#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    add a Perframe eventhandler

    Parameter(s):
    0: Function that get called <Code, String>
    1: Delay <Number>
    2: Arguments <Any>

    Returns:
    None
*/
params [["_fnc", {hint "idiot"}], ["_delay", 0, [0]], ["_args", []]];
private _handler = GVAR(PFHCache) getVariable QGVAR(PerframehandlerArray);
_handler pushBack [_fnc, _args, _delay, diag_tickTime];
GVAR(PFHCache) setVariable [QGVAR(PerframehandlerArray), _handler];
