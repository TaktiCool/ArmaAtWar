#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Init for Vehicle Respawn System

    Parameter(s):
    None

    Returns:
    None
*/
GVAR(VehicleRespawnAllVehicles) = [];

["entityCreated", {
    (_this select 0) params ["_entity"];
    [{
        params ["_entity"];
        private _respawnTime = _entity getVariable ["respawnTime", -1];

        if (_respawnTime >= 0) then {

            _entity setVariable [QGVAR(respawnPosition), getPos _entity];
            _entity setVariable [QGVAR(respawnDirection), getDir _entity];

            private _side = _entity getVariable ["side", sideUnknown];
            [QGVAR(vehicleRespawnAvailable), _side, _entity] call CFUNC(targetEvent);

            private _respawnCounter = _entity getVariable [QGVAR(RespawnCounter), 0];

            if (_respawnCounter == 0) then {
                private _respawnCondition = _entity getVariable ["respawnCondition", "true"];
                [_entity, typeOf _entity, vehicleVarName _entity, getPos _entity, getDir _entity, _respawnCondition] call FUNC(performVehicleRespawn);
            };
        };
    }, [_entity]] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);


addMissionEventHandler ["EntityKilled", {
    params ["_killedEntity","_killer"];
    if (_killedEntity in GVAR(VehicleRespawnAllVehicles)) then {
        private _type = typeOf _killedEntity;
        private _respawnTime = _killedEntity getVariable ["respawnTime", 0];
        private _respawnCondition = _killedEntity getVariable ["respawnCondition", "true"];
        private _respawnCounter = _killedEntity getVariable [QGVAR(RespawnCounter), 0];
        private _respawnPosition = _entity getVariable [QGVAR(respawnPosition), getPos _killedEntity];
        private _respawnDirection = _entity getVariable [QGVAR(respawnDirection), getDir _killedEntity];

        _respawnCounter = _respawnCounter + 1;

        GVAR(VehicleRespawnAllVehicles) deleteAt (GVAR(VehicleRespawnAllVehicles) find _killedEntity);

        [FUNC(performVehicleRespawn), _respawnTime, [_killedEntity, _type, vehicleVarName _killedEntity, _respawnPosition, _respawnDirection, _respawnCondition, _respawnCounter]] call CFUNC(wait);
    };
}];
