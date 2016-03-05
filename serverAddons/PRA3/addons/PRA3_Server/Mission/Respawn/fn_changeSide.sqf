#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    -

    Returns:
    -
*/

private _currentSide = side group PRA3_Player;
private _otherSide = call compile ((GVAR(competingSides) select { _x != str _currentSide }) select 0);

private _baseGroupCurrentSide = missionNamespace getVariable (format [QGVAR(baseGroup%1), _currentSide]);
private _baseGroupOtherSide = missionNamespace getVariable (format [QGVAR(baseGroup%1), _otherSide]);

if (group PRA3_Player != _baseGroupCurrentSide) then {
    [QGVAR(groupLeave), group PRA3_Player] call CFUNC(globalEvent);
};

[PRA3_Player] join _baseGroupOtherSide;
[QGVAR(changeSide), _otherSide] call CFUNC(localEvent);
