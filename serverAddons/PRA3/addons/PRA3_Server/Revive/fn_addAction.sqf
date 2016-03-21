#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Adds a medical Action to the SPACE Action

    Parameter(s):
    0: Condition <Code>
    1: Code <Code>
    2: Arguments <Any>

    Returns:
    None
*/
params [["_condition", {true}], ["_code", {}], ["_args", []]];
if (isNull GVAR(actions)) then {
    GVAR(actions) = [];
};
GVAR(actions) pushBack [_condition, _code, _args];
