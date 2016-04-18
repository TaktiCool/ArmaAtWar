#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Mouse Moving EH

    Parameter(s):
    0: Map <Control>
    1: X coordinate <Number>
    2: Y coordinate <Number>

    Remarks:
    None

    Returns:
    None
*/
disableSerialization;
params ["_map", "_button", "_xPos", "_yPos"];

//private _nearestIcon = [QGVAR(nearIcons), {_this call FUNC(getIconAtPos)}, [_xPos, _yPos], 0.1, QGVAR(clearNearIcon)] call CFUNC(cachedCall);
private _nearestIcon = [_map, _xPos, _yPos] call FUNC(getIconAtPos);
{
    private _icon = GVAR(IconNamespace) getVariable _x;
    if ((_icon select 0) == 2 && _nearestIcon != _x) then {
        _icon set [0, 0];
        GVAR(IconNamespace) setVariable [_x, _icon];
        [_nearestIcon, "unselected", _this] call FUNC(triggerMapIconEvent);
    };
    nil;
} count GVAR(MapIconIndex);

if (_nearestIcon == "") exitWith {};

private _icon = GVAR(IconNamespace) getVariable _nearestIcon;

if ((_icon select 0) < 2) then {
    _icon set [0, 2];
    GVAR(IconNamespace) setVariable [_nearestIcon, _icon];
    [_nearestIcon, "selected", _this] call FUNC(triggerMapIconEvent);
};
