#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Call Funcion Directly and change the Env

    Parameter(s):
    0: Code or Function that called <Code>
    1: Arguments <Any>

    Returns:
    Return of the Function <Any>
*/
params [["_code", {}, [{}]], ["_arguments", []]];
private "_return";
if !(canSuspend) exitWith {
    _arguments call _code;
};

"_return = _arguments call _code" configClasses (missionConfigFile >> "PRA3" >> "dummy");
if !(isNil "_return") then {_return};
