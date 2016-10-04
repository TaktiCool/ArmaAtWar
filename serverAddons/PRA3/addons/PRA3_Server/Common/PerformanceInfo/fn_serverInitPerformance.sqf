#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Server init of performance info.

    Parameter(s):
    None

    Returns:
    None
*/

DFUNC(performanceLoop) = {
    ["performanceCheck", diag_fps] call CFUNC(globalEvent);
    [FUNC(performanceLoop), 20] call CFUNC(wait);
};

["missionStarted", {
    [FUNC(performanceLoop), 1] call CFUNC(wait);
}] call CFUNC(addEventHandler);