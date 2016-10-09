#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Sets players unconsciousness state

    Parameter(s):
    1: state <Boolean>

    Returns:
    -
*/
params [["_state", true]];

if (_state) then {
    if (!(PRA3_Player getVariable [QGVAR(isUnconscious), false])) then {
        PRA3_Player setVariable [QGVAR(isUnconscious), true, true];
        PRA3_player setUnconscious true;
        ["unconsciousnessChanged", [true]] call CFUNC(localEvent);
    };
} else {
    if (PRA3_Player getVariable [QGVAR(isUnconscious), false]) then {
        PRA3_Player setVariable [QGVAR(isUnconscious), false, true];
        PRA3_player setUnconscious false;
        ["unconsciousnessChanged", [false]] call CFUNC(localEvent);
    };
};
