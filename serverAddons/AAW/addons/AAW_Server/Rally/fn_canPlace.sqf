#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas, NetFusion

    Description:
    Checks if rally is placeable

    Parameter(s):
    None

    Returns:
    is Rally Placeable <Bool>
*/

// Check time
private _waitTime = [QGVAR(Rally_waitTime), 10] call CFUNC(getSetting);
private _lastRallyPlaced = (group CLib_Player) getVariable [QGVAR(lastRallyPlaced), -_waitTime];
if ((_lastRallyPlaced + _waitTime) >= serverTime) exitWith {
    ["RALLY POINT NOT PLACABLE", format ["You need to wait %1 sec to place your next Rally", floor ((_lastRallyPlaced + _waitTime) - serverTime)]] call EFUNC(Common,displayHint);
    false
};

// TODO make a settings for that
private _enemyCount = {(side group _x) != (side group CLib_Player)} count (nearestObjects [CLib_Player, ["CAManBase"], 50]);
if (_enemyCount != 0) exitWith {
    ["RALLY POINT NOT PLACABLE", "Enemies are to close to your current Position"] call EFUNC(Common,displayHint);
    false
};

// Check near players
private _nearPlayerToBuild = [QGVAR(Rally_nearPlayerToBuild), 1] call CFUNC(getSetting);
private _nearPlayerToBuildRadius = [QGVAR(Rally_nearPlayerToBuildRadius), 10] call CFUNC(getSetting);
private _count = {(group _x) == (group CLib_Player)} count (nearestObjects [CLib_Player, ["CAManBase"], _nearPlayerToBuildRadius]);
if (_count < _nearPlayerToBuild) exitWith {
    ["RALLY POINT NOT PLACABLE", format ["You Need %1 more player to Build a Rally", _nearPlayerToBuild - _count]] call EFUNC(Common,displayHint);
    false
};

true
