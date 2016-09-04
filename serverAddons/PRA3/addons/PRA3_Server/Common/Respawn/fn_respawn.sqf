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
if (Clib_Player getVariable [QGVAR(tempUnit), false]) then {
    Clib_Player setVariable [QGVAR(tempUnit), false];
    ["enableSimulation", [Clib_Player, true]] call CFUNC(serverEvent);
    ["hideObject", [Clib_Player, false]] call CFUNC(serverEvent);
};

if (!alive Clib_Player) then {
    // This will cause one frame delay until new unit is available
    setPlayerRespawnTime 0;

    [{
        params ["_targetPosition", "_tempUnit", "_oldPlayer"];

        setPlayerRespawnTime 10e10;

        if (_tempUnit) then {
            Clib_Player setVariable [QGVAR(tempUnit), true];
            ["enableSimulation", [Clib_Player, false]] call CFUNC(serverEvent);
            ["hideObject", [Clib_Player, true]] call CFUNC(serverEvent);
        };

        Clib_Player setDir (random 360);
        Clib_Player setPosASL _targetPosition;

        // Respawn event is triggered by engine
        ["MPRespawn", [Clib_Player, _oldPlayer]] call CFUNC(globalEvent);
    }, [_targetPosition, _tempUnit, Clib_Player]] call CFUNC(execNextFrame);
} else {
    Clib_Player setDir (random 360);
    Clib_Player setPosASL _targetPosition;

    // This is instant cause we reuse the old unit
    ["Respawn", [Clib_Player, Clib_Player]] call CFUNC(localEvent);
    ["MPRespawn", [Clib_Player, Clib_Player]] call CFUNC(globalEvent);
};
