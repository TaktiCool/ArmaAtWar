#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Initialize the Unit Tracker

    Parameter(s):
    None

    Returns:
    None
*/
GVAR(playerCounter) = 0;

["missionStarted", {
    {
        [_x, _x] call FUNC(addUnitToTracker);
        nil
    } count allPlayers;
}] call CFUNC(addEventHandler);

["MPRespawn", {
    (_this select 0) call FUNC(addUnitToTracker);
}] call CFUNC(addEventHandler);
