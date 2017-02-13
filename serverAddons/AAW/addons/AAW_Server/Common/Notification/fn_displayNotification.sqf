#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy, joko // Jonas

    Description:
    Displays a Notification

    Parameter(s):
    0: Text <String, Array> (Default: "Error No Notification Text")
    1: Color <Array> (Default: [0.2, 0.2, 0.2, 0.8])
    2: Time in seconds <Number> (Default: 6)
    3: Priority <Number> (Default: 0)
    4: Condition <Code> (Default: {true})

    Returns:
    None
*/

params [
    ["_text", "Error No Notification Text", ["", []], []],
    ["_color", [0.2, 0.2, 0.2, 0.8], [[]], 4],
    ["_time", 6, [0]],
    ["_priority", 0, [0]],
    ["_condition", {true}, [{}]]
];

if (_text isEqualType []) then {
    {
        if (_x call CFUNC(isLocalised)) then {
            _text set [_forEachIndex, LOC(_x)];
        };
    } forEach _text;
    _text = format _text;
} else {
    if (_text call CFUNC(isLocalised)) then {
        _text = LOC(_text);
    };
};

GVAR(NotificationQueue) pushBack [_priority, time, _text, _color, _time, _condition];
GVAR(NotificationQueue) sort true;
if (isNull (uiNamespace getVariable [UIVAR(Notification), displayNull])) then {
    call FUNC(handleNotificationQueue);
};
