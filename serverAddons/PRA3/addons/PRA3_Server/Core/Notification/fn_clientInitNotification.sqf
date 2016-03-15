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

disableSerialization;

GVAR(NotificationQueue) = [];
GVAR(LastNotification) = -1;
GVAR(NextNotification) = -1;

["displayNotification", {
    (_this select 0) call CFUNC(displayNotification)
}] call FUNC(addEventhandler);

// !dont call this by hand
["handleNotificationQueue", {
    disableSerialization;
    if (GVAR(NotificationQueue) isEqualTo []) exitWith {};
    (GVAR(NotificationQueue) deleteAt 0) params ["_priority", "_timeAdded", "_text", "_color", "_time"];

    ([UIVAR(Notification)] call BIS_fnc_rscLayer) cutRsc [UIVAR(Notification),"PLAIN",0.2];
    private _display = uiNamespace getVariable [UIVAR(Notification),displayNull];

    private _groupPos = ctrlPosition (_display displayCtrl 4000);
    private _oldGroupPos = +_groupPos;
    _groupPos set [0, 0.5];
    _groupPos set [2, 0];
    (_display displayCtrl 4000) ctrlSetPosition _groupPos;


    private _bgPos = ctrlPosition (_display displayCtrl 4001);
    _bgPos set [0, -(_bgPos select 2)/2];
    (_display displayCtrl 4001) ctrlSetPosition _bgPos;
    _bgPos set [0, 0];

    private _txtPos = ctrlPosition (_display displayCtrl 4002);
    _txtPos set [0, -(_txtPos select 2)/2];
    (_display displayCtrl 4002) ctrlSetPosition _txtPos;
    _txtPos set [0, 0];
    (_display displayCtrl 4001) ctrlSetTextColor _color;

    (_display displayCtrl 4002) ctrlSetStructuredText parseText format ["%1",_text];
    (_display displayCtrl 4000) ctrlCommit 0;
    (_display displayCtrl 4001) ctrlCommit 0;
    (_display displayCtrl 4002) ctrlCommit 0;

    (_display displayCtrl 4000) ctrlSetPosition _oldGroupPos;
    (_display displayCtrl 4001) ctrlSetPosition _bgPos;
    (_display displayCtrl 4002) ctrlSetPosition _txtPos;
    (_display displayCtrl 4000) ctrlCommit 0.2;
    (_display displayCtrl 4001) ctrlCommit 0.2;
    (_display displayCtrl 4002) ctrlCommit 0.2;


    GVAR(LastNotification) = time;
    GVAR(NextNotification) = time + _time;

    [{
        disableSerialization;
        [{
            if (GVAR(NotificationQueue) isEqualTo []) exitWith {};
            ["handleNotificationQueue"] call CFUNC(localEvent);
        }, {isNull (uiNamespace getVariable [UIVAR(Notification),displayNull])},[]] call CFUNC(waitUntil);

        ([UIVAR(Notification)] call BIS_fnc_rscLayer) cutFadeOut 0.3;

    }, {GVAR(NextNotification)<=time || (!(GVAR(NotificationQueue) isEqualTo []) && (GVAR(LastNotification)+2)<=time )},[]] call CFUNC(waitUntil);
}] call FUNC(addEventhandler);
