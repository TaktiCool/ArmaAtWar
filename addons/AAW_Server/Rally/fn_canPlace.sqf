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
    [MLOC(NotPlacable), format [MLOC(TimeRequirement), str (1 + floor(_time))]] call CFUNC(displayHint);
    false
};

// TODO make a settings for that
private _enemyCount = {(side group _x) != (side group CLib_Player) && alive _x} count ([CLib_Player, 50] call CFUNC(getNearUnits));
if (_enemyCount != 0) exitWith {
    [MLOC(NotPlacable), MLOC(EnemysClose)] call CFUNC(displayHint);
    false
};

// Check near players
private _nearPlayerToSetup = ([CFGSRP(nearPlayerToSetup), 1] call CFUNC(getSetting));
private _nearPlayerToSetupRadius = [CFGSRP(nearPlayerToSetupRadius), 10] call CFUNC(getSetting);

private _count = {
    (group _x) == (group CLib_Player) &&
    _x call EFUNC(Common,isAlive)
} count ([CLib_Player, _nearPlayerToSetupRadius] call CFUNC(getNearUnits));

if (_count < _nearPlayerToSetup) exitWith {
    [MLOC(NotPlacable), format [MLOC(PlayerRequirement), str (_nearPlayerToSetup - _count)]] call CFUNC(displayHint);
    false
};

true
