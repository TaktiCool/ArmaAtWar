#include "macros.hpp"
/*
    Arma At War - AAW

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
    if (!(CLib_Player getVariable [QGVAR(isUnconscious), false])) then {
        CLib_Player setVariable [QGVAR(isUnconscious), true, true];
        CLib_Player setUnconscious true;
        ["setMimic", [CLib_Player, "dead"]] call CFUNC(globalEvent);
        ["unconsciousnessChanged", [true]] call CFUNC(localEvent);
        if (!isNull objectParent CLib_Player) then {
            [CLib_Player, [CLib_Player] call CFUNC(getDeathAnimation)] call CFUNC(doAnimation);
        };
    };
} else {
    if (CLib_Player getVariable [QGVAR(isUnconscious), false]) then {
        CLib_Player setVariable [QGVAR(isUnconscious), false, true];
        CLib_Player setUnconscious false;
        ["setMimic", [CLib_Player, "neutral"]] call CFUNC(globalEvent);
        ["unconsciousnessChanged", [false]] call CFUNC(localEvent);
    };
};
