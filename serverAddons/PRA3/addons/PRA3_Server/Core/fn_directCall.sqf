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
params [["_code", {0}, [{}]], ["_args", []]];
private "_return";
"_return = (_args call _code); false" configClasses (missionConfigFile >> "PRA3" >> "dummy");
if !(isNil "_return") then {_return};
