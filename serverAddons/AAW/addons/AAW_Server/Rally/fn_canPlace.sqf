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
    ["RALLY POINT NOT PLACABLE", format ["You need to wait %1 sec to place your next rally", floor ((_lastRallyPlaced + _waitTime) - serverTime)]] call EFUNC(Common,displayHint);
    false
};

// TODO make a settings for that
private _enemyCount = {
    (side group _x) != (side group CLib_Player)
     && _x call EFUNC(Common,isAlive)
} count ([CLib_Player, 50] call CFUNC(getNearUnits));

if (_enemyCount != 0) exitWith {
    ["RALLY POINT NOT PLACABLE", "Enemies are to close to your current position"] call EFUNC(Common,displayHint);
    false
};

// Check near players
private _nearPlayerToBuild = [QGVAR(Rally_nearPlayerToBuild), 1] call CFUNC(getSetting);
private _nearPlayerToBuildRadius = [QGVAR(Rally_nearPlayerToBuildRadius), 10] call CFUNC(getSetting);
private _count = {
    (group _x) == (group CLib_Player) &&
    _x call EFUNC(Common,isAlive)
} count ([CLib_Player, _nearPlayerToBuildRadius] call CFUNC(getNearUnits));
_count = _count + 1; // Player is not in getNearUnits
if (_count =< _nearPlayerToBuild) exitWith {
    ["RALLY POINT NOT PLACABLE", format ["You need %1 more player to build a rally", _nearPlayerToBuild - _count]] call EFUNC(Common,displayHint);
    false
};

true
