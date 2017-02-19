#include "macros.hpp"
/*
    Comunity Lib - CLib

    Author: BadGuy, joko

    Description:
    Displays a Notification

    Parameter(s):
    0: Header text <String|Array>
    1: Description text <String|Array>
    2: Icon stack <Array of <Icon>>

    Returns:
    None

    Remarks:
    <Icon>
        0: icon path <String>
        1: size <Number>
        2: color <Array>
*/
params [["_header", "", ["", []]],
    ["_description", "",    ["", []]],
    ["_icons", []]];

if (_header isEqualType []) then {
    {
        if (_x call CFUNC(isLocalised)) then {
            _header set [_forEachIndex, LOC(_x)];
        };
    } forEach _header;
    _header = format _header;
} else {
    if (_header call CFUNC(isLocalised)) then {
        _header = LOC(_header);
    };
};

if (_description isEqualType []) then {
    {
        if (_x call CFUNC(isLocalised)) then {
            _description set [_forEachIndex, LOC(_x)];
        };
    } forEach _description;
    _description = format _header;
} else {
    if (_description call CFUNC(isLocalised)) then {
        _description = LOC(_description);
    };
};


{
    if (!isNull _x) then {
        _x ctrlSetFade 1;
        _x ctrlCommit 0.3;
    };
    nil;
} count GVAR(CurrentHint);
[{
    {
        if (!isNull _x) then {
            ctrlDelete _x;
        };
        nil;
    } count _this;
}, 0.5, GVAR(CurrentHint)] call CFUNC(wait);

private _controlGroups = [];
private _deletableDisplays = [];
GVAR(CurrentHint) = [];

{
    _x params ["_display", "_offset","_offsetHint"];
    if (!isNull _display) then {
        private _ctrlGrp = [_header, _description, _icons, _display, 0, _offsetHint] call FUNC(drawHint);
        GVAR(CurrentHint) pushBack _ctrlGrp;
    } else {
        _deletableDisplays pushBack _this;
    };

    nil
} count GVAR(NotificationDisplays);

GVAR(NotificationDisplays) =  GVAR(NotificationDisplays) - _deletableDisplays;

[{
    {
        if (!isNull _x) then {
            _x ctrlSetFade 1;
            _x ctrlCommit 3;
        };
        nil;
    } count _this;
    [{
        {
            if (!isNull _x) then {
                ctrlDelete _x;
            };
            nil;
        } count _this;
        if (_this isEqualTo GVAR(CurrentHint)) then {
            GVAR(CurrentHint) = [];
        };
    }, 3.5, _this] call CFUNC(wait);
}, 6, GVAR(CurrentHint)] call CFUNC(wait);
