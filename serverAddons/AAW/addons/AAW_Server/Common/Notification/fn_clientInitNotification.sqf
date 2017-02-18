#include "macros.hpp"
/*
    Comunity Lib - CLib

    Author: joko // Jonas

    Description:
    Init for Notifications

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(NotificationQueue) = [];
GVAR(LastNotification) = -1;
GVAR(NextNotification) = -1;

GVAR(AllNotifications) = [];
GVAR(NotificationDisplays) = [];

["displayNotificationOld", {
    (_this select 0) call FUNC(displayNotificationOld)
}] call CFUNC(addEventhandler);

["displayNotification", {
    (_this select 0) call FUNC(displayNotification)
}] call CFUNC(addEventhandler);

["missionStarted", {
    [findDisplay 46] call FUNC(registerDisplayNotification)
}] call CFUNC(addEventhandler);
