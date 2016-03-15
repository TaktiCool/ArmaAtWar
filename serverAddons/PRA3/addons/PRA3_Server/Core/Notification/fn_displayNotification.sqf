#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko

    Description:
    Displays a Notification

    Parameter(s):
    0: Text <StructuredText>
    1: Color (optional, default [0.8,0.8,0.8,1]) <Array>
    2: Time in seconds (optional, default 6) <Number>
    3: Priority (optional, default 0) <Number>

    Returns:
    None
*/
params ["_text", ["_color",[0.2,0.2,0.2,0.8]], ["_time",6],["_priority",0]];
disableSerialization;
GVAR(NotificationQueue) pushBack [_priority, time, _text, _color, _time];
GVAR(NotificationQueue) sort true;
if (isNull (uiNamespace getVariable [UIVAR(Notification),displayNull])) then {
    ["handleNotificationQueue"] call CFUNC(localEvent);
};
