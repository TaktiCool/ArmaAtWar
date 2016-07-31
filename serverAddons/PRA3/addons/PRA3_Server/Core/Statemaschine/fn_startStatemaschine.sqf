#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Start a Statemaschine.

    Parameter(s):
    0: Statemaschine Object <Location>
    1: First State <String> (default: "init")
    2: Tick Time <Number> (default: 0)

    Returns:
    Index of the Statemaschine PFH <Number>
*/
params ["_stateMaschine", "_firstState", ["_tickeTime", 0]];
if !(isNil "_firstState") then {
    _stateMaschine setVariable [SMVAR(nextStateData), _firstState];
};
[FUNC(loopStatemaschine), _tickeTime, _stateMaschine] call CFUNC(addPerFrameHandler);
