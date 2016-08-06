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
GVAR(processedUnits) = [];
GVAR(processedGroups) = [];

DFUNC(updateIcons) = {

    _processedUnits = [];
    _processedGroups = [];

    {
        if (side _x == playerSide) then {
            private _element = [_x, side _x, group _x, (leader group _x == _x), _x getVariable [QGVAR(playerIconId), ""]];
            if (!(_element in GVAR(processedUnits)) || (_element select 4 == "")) then {
                private _id = [_x] call FUNC(addUnitToTracker);
                _element set [4, _id];
            };
            _processedUnits pushBack _element;
            if (leader _x == _x) then {
                private _element = [group _x, leader _x, format [QGVAR(Group_%1), groupId group _x]];
                if !(_element in GVAR(processedGroups) || (_element select 2 == "")) then {
                    private _id = [_element select 0] call FUNC(addGroupToTracker);
                    _element set [2, _id];
                };
                _processedGroups pushBack _element;
            };
        };
        nil
    } count allUnits;

    {
        [_x select 4] call CFUNC(removeMapGraphicsGroup);
        #ifdef isDev
            DUMP("Unit Icon removed: " + (_x select 4))
        #endif
        nil
    } count (GVAR(processedUnits) - _processedUnits);
    GVAR(processedUnits) = +_processedUnits;

    {
        [_x select 2] call CFUNC(removeMapGraphicsGroup);
        [_x select 2, "hoverin"] call CFUNC(removeMapGraphicsEventHandler);
        [_x select 2, "hoverout"] call CFUNC(removeMapGraphicsEventHandler);
        #ifdef isDev
            DUMP("Group Icon removed: " + (_x select 2))
        #endif
        nil
    } count (GVAR(processedGroups) - _processedGroups);
    GVAR(processedGroups) = +_processedGroups;

};

[FUNC(updateIcons), 2] call CFUNC(addPerFrameHandler);
/*
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

*/
