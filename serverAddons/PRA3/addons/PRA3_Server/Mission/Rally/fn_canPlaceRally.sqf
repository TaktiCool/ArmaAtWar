#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    check if Rally is Placeable

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
private _oldRally = (group PRA3_Player) getVariable [QGVAR(rallyPoint), [-_waitTime, [], [], 0]];
if (time - (_oldRally select 0) < _waitTime) exitWith {false};

// Check near players
private _nearPlayerToBuild = [QGVAR(Rally_nearPlayerToBuild)] call CFUNC(getSetting);
private _count = {(side group _x) == playerSide} count (nearestObjects [PRA3_Player, ["CAManBase"], 10]);
if (_count < _nearPlayerToBuild) exitWith {false};

// Check near rallies
private _minDistance = [QGVAR(Rally_minDistance)] call CFUNC(getSetting);
private _rallyNearPlayer = false;
{
    private _rally = _x getVariable QGVAR(rallyPoint);
    if (!isNil "_rally") then {
        private _rallyPosition = _rally select 1;
        if (!(_rallyPosition isEqualTo [])) then {
            if ((PRA3_Player distance _rallyPosition) < _minDistance) exitWith {
                _rallyNearPlayer = true;
            };
        };
    };
    nil
} count allGroups;
if (_rallyNearPlayer) exitWith {false};

true