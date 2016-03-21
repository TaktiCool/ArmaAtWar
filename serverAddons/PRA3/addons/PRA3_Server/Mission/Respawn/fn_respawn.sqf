#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Move the player to new unit

    Parameter(s):
    0: New side <Side>
    1: New group <Group>
    2: Spawn position <Position3D>

    Returns:
    None
*/
params ["_targetSide", "_targetGroup", "_targetPosition", ["_isTemporaryUnit", false]];

// Create new body
private _className = getText (missionConfigFile >> "PRA3" >> "Sides" >> (str _targetSide) >> "playerClass");
private _newUnit = _targetGroup createUnit [_className, [0, 0, 0], [], 0, "NONE"];

// Reattach all triggers
{
    if (triggerAttachedVehicle _x == PRA3_Player) then {
        _x triggerAttachVehicle [_newUnit];
    };
    nil
} count (allMissionObjects "EmptyDetector");

// Copy all variables to the new object
{
    _newUnit setVariable [_x, PRA3_Player getVariable _x, true];
    nil
} count (allVariables PRA3_Player);

// Mark as temporary if necessary
if (_isTemporaryUnit) then {
    _newUnit setVariable [QGVAR(tempUnit), true];
    ["enableSimulation", [_newUnit, false]] call CFUNC(serverEvent);
    ["hideObject", [_newUnit, true]] call CFUNC(serverEvent);
};

private _oldUnit = PRA3_Player;

// Move the player to the unit before changing anything
selectPlayer _newUnit;

// Handle the vehicleVarName
private _oldVarName = vehicleVarName _oldUnit;
_oldUnit setVehicleVarName "";
_newUnit setVehicleVarName _oldVarName;
missionNamespace setVariable [_oldVarName, _newUnit, true];

// Save old leader status
private _wasLeader = (_oldUnit == leader _oldUnit);

// Make the exact group slot available
private _positionId = parseNumber ((str _oldUnit) select [((str _oldUnit) find ":") + 1]);
[_oldUnit] join grpNull;
_newUnit joinAsSilent [group _newUnit, _positionId];

// Restore old leader status
if (_wasLeader) then {
    ["selectLeader", [_targetGroup, _newUnit]] call CFUNC(serverEvent);
};

// Copy event handlers
// This should be done by our awesome event system in core on playerChanged event

// Handle position
_newUnit setDir (random 360);
_newUnit setPos ([_targetPosition, 5, _className] call CFUNC(findSavePosition));

// Broadcast the change after everything is changed
["playerChanged", [_newUnit, _oldUnit]] call CFUNC(localEvent);
PRA3_Player = _newUnit;

// Trigger respawn event
["Respawn", [_newUnit, _oldUnit]] call CFUNC(localEvent);

if (_oldUnit getVariable [QGVAR(tempUnit), false]) then {
    deleteVehicle _oldUnit;
};
