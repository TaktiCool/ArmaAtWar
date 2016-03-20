#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Adds a medical Action to the SPACE Action

    Parameter(s):
    0: Condition <Code>
    1: Code <String>

    Returns:
    None
*/
params ["_condition", "_code"];
if (isNull GVAR(actions)) then {
    GVAR(actions) = [];
};
GVAR(actions) pushBack _this;
