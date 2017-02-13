#include "macros.hpp"
/*
    Arma At War

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

["displayNotification", {
    (_this select 0) call FUNC(displayNotification)
}] call CFUNC(addEventhandler);
