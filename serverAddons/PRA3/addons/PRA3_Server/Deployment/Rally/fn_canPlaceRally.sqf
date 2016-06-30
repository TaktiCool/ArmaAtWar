#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Checks if rally is placeable

    Parameter(s):
    None

    Returns:
    is Rally Placeable <Bool>
*/
// Check leader
if (leader PRA3_Player != PRA3_Player) exitWith {false};

// Check vehicle
if (vehicle PRA3_Player != PRA3_Player) exitWith {false};

// Check time
private _waitTime = [QGVAR(Rally_waitTime)] call CFUNC(getSetting);
private _lastRallyPlaced = (group PRA3_Player) getVariable [QGVAR(lastRallyPlaced), -_waitTime];
if (serverTime - _lastRallyPlaced < _waitTime) exitWith {false};

// Check near players
private _nearPlayerToBuild = [QGVAR(Rally_nearPlayerToBuild), 1] call CFUNC(getSetting);
private _nearPlayerToBuildRadius = [QGVAR(Rally_nearPlayerToBuildRadius), 10] call CFUNC(getSetting);
private _count = {(group _x) == (group PRA3_Player)} count (nearestObjects [PRA3_Player, ["CAManBase"], _nearPlayerToBuildRadius]);
if (_count < _nearPlayerToBuild) exitWith {false};

// Check near DPs
private _minDistance = [QGVAR(Rally_minDistance), 100] call CFUNC(getSetting);
private _rallyNearPlayer = false;
{
    private _pointDetails = GVAR(pointStorage) getVariable _x;
    if (!(isNil "_pointDetails")) then {
        private _pointPosition = _pointDetails select 1;
        if ((PRA3_Player distance _pointPosition) < _minDistance) exitWith {
            _rallyNearPlayer = true;
        };
    };
    nil
} count (allVariables GVAR(pointStorage));
if (_rallyNearPlayer) exitWith {false};

true