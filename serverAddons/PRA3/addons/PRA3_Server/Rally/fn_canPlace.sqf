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
if (leader CLib_Player != CLib_Player) exitWith {false};

// Check vehicle
if (vehicle CLib_Player != CLib_Player) exitWith {false};

// Check time
private _waitTime = [QGVAR(Rally_waitTime), 10] call CFUNC(getSetting);
private _lastRallyPlaced = (group CLib_Player) getVariable [QGVAR(lastRallyPlaced), -_waitTime];
if (serverTime - _lastRallyPlaced < _waitTime) exitWith {false};

// Check near players
private _nearPlayerToBuild = [QGVAR(Rally_nearPlayerToBuild), 1] call CFUNC(getSetting);
private _nearPlayerToBuildRadius = [QGVAR(Rally_nearPlayerToBuildRadius), 10] call CFUNC(getSetting);
private _count = {
    if ((group _x) == (group CLib_Player)) then {
        true;
    } else {
        if (side (group _x) != sideUnknown && side (group _x) != side (group CLib_Player)) then {
            false breakOut (_fnc_scriptName + "_Main");
        };
        false;
    };
} count (nearestObjects [CLib_Player, ["CAManBase"], _nearPlayerToBuildRadius]);
if (_count < _nearPlayerToBuild) exitWith {false};
true
