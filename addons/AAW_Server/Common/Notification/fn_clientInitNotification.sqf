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
GVAR(AllNotifications) = [];
GVAR(NotificationDisplays) = [];
GVAR(CurrentHint) = [];

["displayNotification", {
    (_this select 0) call FUNC(displayNotification)
}] call CFUNC(addEventhandler);

["missionStarted", {
    [findDisplay 46] call FUNC(registerDisplayNotification)
}] call CFUNC(addEventhandler);
