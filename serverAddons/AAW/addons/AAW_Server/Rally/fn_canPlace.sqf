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
// Check leader
if (leader CLib_Player != CLib_Player) exitWith {false};

// Check vehicle
if (!isNull objectParent CLib_Player) exitWith {false};

// Check time
private _waitTime = [QGVAR(Rally_waitTime), 10] call CFUNC(getSetting);
private _lastRallyPlaced = (group CLib_Player) getVariable [QGVAR(lastRallyPlaced), -_waitTime];
if (serverTime - _lastRallyPlaced < _waitTime) exitWith {false};


// TODO make a settings for that
private _enemyCount = {(side group _x) != (side group CLib_Player)} count (nearestObjects [CLib_Player, ["CAManBase"], 50]);
if (_enemyCount != 0) exitWith {false};

// Check near players
private _nearPlayerToBuild = [QGVAR(Rally_nearPlayerToBuild), 1] call CFUNC(getSetting);
private _nearPlayerToBuildRadius = [QGVAR(Rally_nearPlayerToBuildRadius), 10] call CFUNC(getSetting);
private _count = {(group _x) == (group CLib_Player)} count (nearestObjects [CLib_Player, ["CAManBase"], _nearPlayerToBuildRadius]);
if (_count < _nearPlayerToBuild) exitWith {false};

true
