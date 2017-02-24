#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas, NetFusion

    Description:
    Checks if FOB is placeable

    Parameter(s):
    None

    Returns:
    is Rally Placeable <Bool>
*/
params ["_target"];

// Check leader
if (leader CLib_Player != CLib_Player) exitWith {false};

// Check vehicle
if (!isNull objectParent CLib_Player) exitWith {false};

// Check near DPs
private _minDistance = [QGVAR(FOB_minDistance), 600] call CFUNC(getSetting);
private _fobNearPlayer = false;
{
    private _pointData = [_x, ["type", "postion"]] call EFUNC(Common,getDeploymentPointData);
    _pointData params ["_type", "_position"];
    // Ignore RPs
    if (_type == "FOB" && (CLib_Player distance _position) < _minDistance) exitWith {
        _fobNearPlayer = true;
    };
    nil
} count (call EFUNC(Common,getAvailableDeploymentPoints));
if (_fobNearPlayer) exitWith {false};

// Check near enemies
private _maxEnemyPlace = [QGVAR(maxEnemyPlace), 5] call CFUNC(getSetting);
private _maxEnemyPlaceRadius = [QGVAR(maxEnemyPlaceRadius), 50] call CFUNC(getSetting);
private _enemyCount = {(side group _x) != side group CLib_Player && alive _x} count ([CLib_Player, _maxEnemyPlaceRadius] call CFUNC(getNearUnits));
if (_enemyCount >= _maxEnemyPlace) exitWith {false};
true
