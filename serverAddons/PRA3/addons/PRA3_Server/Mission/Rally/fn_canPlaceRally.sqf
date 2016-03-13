#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    check if Rally is Placeable

    Parameter(s):
    None

    Returns:
    is Rally Placeable <Bool>
*/
// Check leader
if (leader PRA3_Player != PRA3_Player) exitWith {false};

// Check time
private _waitTime = [QGVAR(Rally_waitTime)] call CFUNC(getSetting);
private _oldRally = (group PRA3_Player) getVariable [QGVAR(rallyPoint), [-_waitTime, [], [], 0]];
if (time - (_oldRally select 0) < _waitTime) exitWith {false};

// Check near players
private _currentSide = side group PRA3_Player;
private _count = {(side group _x) == _currentSide} count (nearestObjects [PRA3_Player, ["CAManBase"], 10]);

//@todo check minDistance

_count >= [QGVAR(Rally_nearPlayerToBuild)] call CFUNC(getSetting)