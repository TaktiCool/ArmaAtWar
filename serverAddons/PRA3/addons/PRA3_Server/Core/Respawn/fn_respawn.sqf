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

if (_className == "") then {
    _className = "O_Soldier_F";
};
// We need to create a new group otherwise the unit may not be local (looks like its sometimes local to the group owner).
private _newUnit = (createGroup _targetSide) createUnit [_className, [-10000, -10000, 50], [], 0, "NONE"];
_newUnit attachTo [GVAR(attachPoint)];

// Reattach all triggers
{
    if (triggerAttachedVehicle _x == PRA3_Player) then {
        _x triggerAttachVehicle [_newUnit];
    };
    nil
} count (allMissionObjects "EmptyDetector");

// Copy all variables to the new object
{
    if !(_x in CGVAR(ignoreVariables)) then {
        private _var = PRA3_Player getVariable _x;
        if !(isNil "_var") then {
            _newUnit setVariable [_x, _var];
        };
    };
    nil
} count (allVariables PRA3_Player);

// Mark as temporary if necessary
if (_isTemporaryUnit) then {
    _newUnit setVariable [QGVAR(tempUnit), true];
    ["enableSimulation", [_newUnit, false]] call CFUNC(serverEvent);
    ["hideObject", [_newUnit, true]] call CFUNC(serverEvent);
};

// Save old leader status
private _wasLeader = (PRA3_Player == leader PRA3_Player);

private _oldUnit = PRA3_Player;

// Move the player to the unit before changing anything
selectPlayer _newUnit;

// Now we move the new unit to the correct group. This has to be done before the player leaves the group to ensure there is always at least one unit in the group.
[_newUnit] joinSilent _targetGroup;

// Handle the vehicleVarName
private _oldVarName = vehicleVarName _oldUnit;
_oldUnit setVehicleVarName "";
_newUnit setVehicleVarName _oldVarName;
missionNamespace setVariable [_oldVarName, _newUnit];

// Make the exact group slot available
private _positionId = parseNumber ((str _oldUnit) select [((str _oldUnit) find ":") + 1]);
[_oldUnit] join grpNull;
_newUnit joinAsSilent [_targetGroup, _positionId];

// Restore old leader status
if (_wasLeader) then {
    [{
        ["selectLeader", [group PRA3_Player, PRA3_Player]] call CFUNC(serverEvent);
    }] call CFUNC(execNextFrame);
};

// Copy event handlers
// This should be done by our awesome event system in core on playerChanged event

detach _newUnit;

// Handle position
_newUnit setDir (random 360);
_newUnit setPos ([_targetPosition, 5, _className] call CFUNC(findSavePosition));

// Broadcast the change after everything is changed
["playerChanged", [_newUnit, _oldUnit]] call CFUNC(localEvent);
PRA3_Player = _newUnit;

// Trigger respawn event
["Respawn", [_newUnit, _oldUnit]] call CFUNC(localEvent);
["MPRespawn", [_newUnit, _oldUnit]] call CFUNC(globalEvent);

if (_oldUnit getVariable [QGVAR(tempUnit), false]) then {
    deleteVehicle _oldUnit;
} else {
    _oldUnit setDamage 1;
};
