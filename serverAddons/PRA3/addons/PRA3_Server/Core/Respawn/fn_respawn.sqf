#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Simulate a "normal" respawn

    Parameter(s):
    0: Spawn position <Position3D>

    Returns:
    None
*/
params ["_targetPosition", ["_tempUnit", false]];

// Remove tempUnit status
if (PRA3_Player getVariable [QGVAR(tempUnit), false]) then {
    PRA3_Player setVariable [QGVAR(tempUnit), false];
    ["enableSimulation", [PRA3_Player, true]] call CFUNC(serverEvent);
    ["hideObject", [PRA3_Player, false]] call CFUNC(serverEvent);
};

if (!alive PRA3_Player) then {
    // This will cause one frame delay until new unit is available
    setPlayerRespawnTime 0;

    [{
        params ["_targetPosition", "_tempUnit", "_oldPlayer"];

        setPlayerRespawnTime 10e10;

        if (_tempUnit) then {
            PRA3_Player setVariable [QGVAR(tempUnit), true];
            ["enableSimulation", [PRA3_Player, false]] call CFUNC(serverEvent);
            ["hideObject", [PRA3_Player, true]] call CFUNC(serverEvent);
        };

        PRA3_Player setDir (random 360);
        PRA3_Player setPosASL _targetPosition;

        // Respawn event is triggered by engine
        ["MPRespawn", [PRA3_Player, _oldPlayer]] call CFUNC(globalEvent);
    }, [_targetPosition, _tempUnit, PRA3_Player]] call CFUNC(execNextFrame);
} else {
    PRA3_Player setDir (random 360);
    PRA3_Player setPosASL _targetPosition;

    // This is instant cause we reuse the old unit
    ["Respawn", [PRA3_Player, PRA3_Player]] call CFUNC(localEvent);
    ["MPRespawn", [PRA3_Player, PRA3_Player]] call CFUNC(globalEvent);
};
