#include "macros.hpp"
/*
    Project Reality ArmA 3

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
if (vehicle CLib_Player != CLib_Player) exitWith {false};

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
private _enemyCount = {(side group _x) != side group CLib_Player} count (_target nearObjects ["CAManBase", _maxEnemyPlaceRadius]);
if (_enemyCount >= _maxEnemyPlace) exitWith {false};
/*
// Check near DPs
private _minDistance = [QGVAR(FOB_minDistance), 600] call CFUNC(getSetting);
private _rallyNearPlayer = false;
{
    private _pointDetails = EGVAR(Common,DeploymentPointStorage) getVariable _x;
    _pointDetails params ["_name", "_position", "_availableFor", "_spawnTickets"];

    // Ignore RPs
    if (_availableFor isEqualType sideUnknown) then {
        if ((CLib_Player distance _position) < _minDistance) exitWith {
            _rallyNearPlayer = true;
        };
    };
    nil
} count (call EFUNC(Common,getAvailableDeploymentPoints));
if (_rallyNearPlayer) exitWith {false};
*/
true
