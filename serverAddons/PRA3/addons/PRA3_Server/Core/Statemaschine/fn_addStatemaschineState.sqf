#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Add State to statemaschine.

    Reminder:
    Every State should return the Next State that should be executed.

    Parameter(s):
    0: Statemaschine Object <Location>
    1: Statename <String>
    2: StateCode <Code, String>
    3: Arguments <Any> (default: [])

    Returns:
    None
*/
params [["_stateMaschine", locationNull, [locationNull]], ["_stateName", "", [""]], ["_stateCode", {}, [{}, ""]], ["_args", []]];

_stateMaschine setVariable [_stateName, [_stateCode, _args]];
