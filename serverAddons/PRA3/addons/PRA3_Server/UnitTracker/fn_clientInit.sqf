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
GVAR(currentIcons) = [];
GVAR(blockUpdate) = false;
GVAR(currentHoverGroup) = grpNull;
GVAR(groupInfoPFH) = -1;

DFUNC(updateIcons) = {
    if (GVAR(blockUpdate)) exitWith {};
    GVAR(blockUpdate) = true;
    [{
        {
            [_x] call CFUNC(removeMapIcon);
            nil
        } count GVAR(currentIcons);
        {
            if !(_x getVariable [QCGVAR(tempUnit), false]) then { // dont Draw Temp Units
                [_x, _x] call FUNC(addUnitToTracker);
            };
            nil
        } count allPlayers;
        GVAR(blockUpdate) = false;
    }, 1] call CFUNC(wait);
};

{
    [_x, {
        call FUNC(updateIcons);
    }] call CFUNC(addEventHandler);
    nil
} count ["missionStarted", QGVAR(updateIconsEvent), "visibleMapChanged", UIVAR(RespawnScreen_onLoad)];

{
    [_x, {
        QGVAR(updateIconsEvent) call CFUNC(globalEvent);
    }] call CFUNC(addEventHandler);
    nil
} count ["leaderChanged", "sideChanged", "groupChanged", "playerChanged"];
