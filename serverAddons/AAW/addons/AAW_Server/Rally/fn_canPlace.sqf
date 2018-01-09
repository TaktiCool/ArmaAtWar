#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, NetFusion

    Description:
    Checks if rally is placeable

    Parameter(s):
    None

    Returns:
    is Rally Placeable <Bool>
*/

// Check time
private _waitTime = [CFGSRP(waitTime), 10] call CFUNC(getSetting);
private _lastRallyPlaced = (group CLib_Player) getVariable [QGVAR(lastRallyPlaced), -_waitTime];
private _time = ((_lastRallyPlaced + _waitTime) - serverTime);
if (_time >= 0) exitWith {
    // add 1 not show 0 secs.
    ["RALLY POINT NOT PLACABLE", format ["You need to wait %1 sec to place your next rally", 1 + floor(_time)]] call MFUNC(displayHint);
    false
};

// TODO make a settings for that
private _enemyCount = {(side group _x) != (side group CLib_Player) && alive _x} count ([CLib_Player, 50] call CFUNC(getNearUnits));
if (_enemyCount != 0) exitWith {
    ["RALLY POINT NOT PLACABLE", "Enemies are to close to your current position"] call MFUNC(displayHint);
    false
};

// Check near players
private _nearPlayerToBuild = ([CFGSRP(nearPlayerToBuild), 1] call CFUNC(getSetting));
private _nearPlayerToBuildRadius = [CFGSRP(nearPlayerToBuildRadius), 10] call CFUNC(getSetting);

private _count = {
    (group _x) == (group CLib_Player) &&
    _x call MFUNC(isAlive)
} count ([CLib_Player, _nearPlayerToBuildRadius] call CFUNC(getNearUnits));

if (_count < _nearPlayerToBuild) exitWith {
    ["RALLY POINT NOT PLACABLE", format ["You need %1 more player to build a rally", _nearPlayerToBuild - _count]] call MFUNC(displayHint);
    false
};

true
