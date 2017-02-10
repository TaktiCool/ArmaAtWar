#include "macros.hpp"
/*
    Arma At War

    Author: NetFusion

    Description:
    Move the player to new unit of another side

    Parameter(s):
    0: Spawn position <Position3D>
    1: Target side <Side>

    Returns:
    None
*/
params ["_targetPosition", "_targetSide"];

// Create new body
private _className = getText (missionConfigFile >> QPREFIX >> "Sides" >> (str _targetSide) >> "playerClass");
if (_className == "") then {
    _className = "O_Soldier_F";
};

// We need to create a new group otherwise the new unit may not be local (looks like its sometimes local to the group owner).
private _tempGroup = createGroup _targetSide;
private _newUnit = _tempGroup createUnit [_className, [-10000, -10000, 50], [], 0, "NONE"];

// Reattach all triggers
{
    if (triggerAttachedVehicle _x == CLib_Player) then {
        _x triggerAttachVehicle [_newUnit];
    };
    nil
} count (allMissionObjects "EmptyDetector");

// Copy all variables to the new object
{
    if (!(_x in CGVAR(ignoreVariables))) then {
        private _var = CLib_Player getVariable _x;
        if (!isNil "_var") then {
            _newUnit setVariable [_x, _var];
        };
    };
    nil
} count (allVariables CLib_Player);

// This unit is temporary (will be removed if we call this function again)
_newUnit setVariable [QGVAR(tempUnit), true];
["enableSimulation", [_newUnit, false]] call CFUNC(serverEvent);
["hideObject", [_newUnit, true]] call CFUNC(serverEvent);

private _oldUnit = CLib_Player;

// Move the player to the unit before changing anything
selectPlayer _newUnit;

// Handle the vehicleVarName
private _oldVarName = vehicleVarName _oldUnit;
["setVehicleVarName", [_oldUnit, ""]] call CFUNC(globalEvent);
["setVehicleVarName", [_newUnit, _oldVarName]] call CFUNC(globalEvent);

// Copy event handlers
// This should be done by our awesome event system in core on playerChanged event

// Handle position
CLib_Player setDir (random 360);
CLib_Player setPosASL ([_targetPosition, 5, 0, _className] call CFUNC(findSavePosition));

// Broadcast the change after everything is changed
["playerChanged", [_newUnit, _oldUnit]] call CFUNC(localEvent);
CLib_Player = _newUnit;

// Trigger respawn event
["Respawn", [CLib_Player, _oldUnit]] call CFUNC(localEvent);
["MPRespawn", [CLib_Player, _oldUnit]] call CFUNC(globalEvent);

// Remove the old unit if it was a temp unit
if (_oldUnit getVariable [QGVAR(tempUnit), false]) then {
    _tempGroup = group _oldUnit;
    deleteVehicle _oldUnit;
    ["deleteGroup", _tempGroup] call CFUNC(serverEvent);
} else {
    _oldUnit setDamage 1;
};
