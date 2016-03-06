#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Init for Notifications

    Parameter(s):
    None

    Returns:
    None
*/
["displayNotification",{
    (_this select 0) params ["_text", "_color", "_time"];
    hint _text;
}] call FUNC(addEventhandler);
