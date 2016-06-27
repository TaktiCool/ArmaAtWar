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
params ["_targetPosition", "_findSavePos", "_targetSide"];

private _newUnit = PRA3_Player;
private _oldUnit = PRA3_Player;
private _className = typeOf PRA3_Player;

if (!(isNil "_targetSide")) then {
    // Create new body
    _className = getText (missionConfigFile >> "PRA3" >> "Sides" >> (str _targetSide) >> "playerClass");
    if (_className == "") then {
        _className = "O_Soldier_F";
    };

    // We need to create a new group otherwise the unit may not be local (looks like its sometimes local to the group owner).
    private _tempGroup = createGroup _targetSide;
    _newUnit = _tempGroup createUnit [_className, [-10000, -10000, 50], [], 0, "NONE"];
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

    _newUnit setVariable [QGVAR(tempUnit), true];
    ["enableSimulation", [_newUnit, false]] call CFUNC(serverEvent);
    ["hideObject", [_newUnit, true]] call CFUNC(serverEvent);

    private _oldUnit = PRA3_Player;

    // Move the player to the unit before changing anything
    selectPlayer _newUnit;

    // Handle the vehicleVarName
    private _oldVarName = vehicleVarName _oldUnit;
    _oldUnit setVehicleVarName "";
    _newUnit setVehicleVarName _oldVarName;

    // Copy event handlers
    // This should be done by our awesome event system in core on playerChanged event

    detach _newUnit;

    // Broadcast the change after everything is changed
    ["playerChanged", [_newUnit, _oldUnit]] call CFUNC(localEvent);
    PRA3_Player = _newUnit;

    // Trigger respawn event
    ["Respawn", [_newUnit, _oldUnit]] call CFUNC(localEvent);

    if (_oldUnit getVariable [QGVAR(tempUnit), false]) then {
        _tempGroup = group _oldUnit;
        deleteVehicle _oldUnit;
        ["deleteGroup", _tempGroup] call CFUNC(serverEvent);
    };
} else {
    if (!alive PRA3_Player) then {
        setPlayerRespawnTime 0;
    } else {
        if (PRA3_Player getVariable [QGVAR(tempUnit), false]) then {
            PRA3_Player setVariable [QGVAR(tempUnit), false];
            ["enableSimulation", [PRA3_Player, true]] call CFUNC(serverEvent);
            ["hideObject", [PRA3_Player, false]] call CFUNC(serverEvent);
        };

        // Trigger respawn event
        [{
            ["Respawn", [PRA3_Player, PRA3_Player]] call CFUNC(localEvent);
        }] call CFUNC(execNextFrame);
    };
};

// Handle position
if (_findSavePos) then {
    _targetPosition = ([_targetPosition, 5, typeOf PRA3_Player] call CFUNC(findSavePosition));
};

[{
    params ["_oldUnit", "_targetPosition"];

    setPlayerRespawnTime 10e10;

    PRA3_Player setDir (random 360);
    PRA3_Player setPosASL _targetPosition;

    // Trigger MP respawn event
    ["MPRespawn", [PRA3_Player, _oldUnit]] call CFUNC(globalEvent);
}, [_oldUnit, _targetPosition]] call CFUNC(execNextFrame);


