#include "macros.hpp"
/*
    Arma At War

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

    private _respawnTime = _entity getVariable ["respawnTime", -1];

    if (_respawnTime >= 0) then {

        _entity setVariable [QGVAR(respawnPosition), getPos _entity];
        _entity setVariable [QGVAR(respawnDirection), getDir _entity];

        private _respawnCounter = _entity getVariable [QGVAR(RespawnCounter), 0];

        if (_respawnCounter == 0) then {
            private _respawnCondition = _entity getVariable ["respawnCondition", "true"];
            [_entity, typeOf _entity, vehicleVarName _entity, getPos _entity, getDir _entity, _respawnCondition] call FUNC(performVehicleRespawn);
        } else {
            GVAR(VehicleRespawnAllVehicles) pushBackUnique _entity;
            private _side = _entity getVariable ["side", sideUnknown];
            [QGVAR(vehicleRespawnAvailable), _side, _entity] call CFUNC(targetEvent);
        };
    };

}] call CFUNC(addEventHandler);


addMissionEventHandler ["EntityKilled", {
    params ["_killedEntity","_killer"];
    private _respawnTime = _killedEntity getVariable ["respawnTime", -1];
    if (_respawnTime >= 0) then {
        private _type = typeOf _killedEntity;

        private _respawnCondition = _killedEntity getVariable ["respawnCondition", "true"];
        private _respawnCounter = _killedEntity getVariable [QGVAR(RespawnCounter), 0];
        private _respawnPosition = _killedEntity getVariable [QGVAR(respawnPosition), getPos _killedEntity];
        private _respawnDirection = _killedEntity getVariable [QGVAR(respawnDirection), getDir _killedEntity];

        GVAR(VehicleRespawnAllVehicles) deleteAt (GVAR(VehicleRespawnAllVehicles) find _killedEntity);

        [FUNC(performVehicleRespawn), _respawnTime, [_killedEntity, _type, vehicleVarName _killedEntity, _respawnPosition, _respawnDirection, _respawnCondition, _respawnCounter]] call CFUNC(wait);
    };
}];

GVAR(AbandonedVehiclesSM) = call CFUNC(createStatemachine);

[GVAR(AbandonedVehiclesSM), "init", {
    private _vehicles = +(GVAR(VehicleRespawnAllVehicles));
    [["checkVehicles", _vehicles], "init"] select (_vehicles isEqualTo []);
}] call CFUNC(addStatemachineState);

[GVAR(AbandonedVehiclesSM), "checkVehicles", {
    params ["_dummy", "_vehicles"];
    private _vehicle = _vehicles deleteAt 0;

    while {isNull _vehicle && {!(_vehicles isEqualTo [])}} do {
        _vehicle = _vehicles deleteAt 0;
    };

    private _defaultState = [["checkVehicles", _vehicles], "init"] select (_vehicles isEqualTo []);

    if (!isNull _vehicle) then {
        private _respawnPosition = _vehicle getVariable [QGVAR(respawnPosition), getPos _vehicle];
        private _abandonedVehicleRadius = _vehicle getVariable ["abandonedVehicleRadius", 100];

        // if vehicle is near its respawn position
        if ((_respawnPosition distance _vehicle) < _abandonedVehicleRadius) exitWith {
            _vehicle setVariable [QGVAR(abandonedSince), -1];
            _defaultState;
        };

        //check if vehicle is empty
        private _nbrCrewUnits = {alive _x} count (crew _vehicle);
        if (_nbrCrewUnits > 0) exitWith {
            _vehicle setVariable [QGVAR(abandonedSince), -1];
            _defaultState;
        };

        //check nearUnits
        private _nbrNearUnits = count ([_vehicle, _abandonedVehicleRadius] call CFUNC(getNearUnits));

        if (_nbrNearUnits > 0) exitWith {
            _vehicle setVariable [QGVAR(abandonedSince), -1];
            _defaultState;
        };

        _abandonedSince = _vehicle getVariable [QGVAR(abandonedSince), -1];

        if (_abandonedSince < 0) then { //was abandoned last time??
            _vehicle setVariable [QGVAR(abandonedSince), diag_tickTime];
        } else {
            private _abandonedVehicleTime = _vehicle getVariable ["abandonedVehicleTime", 600];
            if ((diag_tickTime - _abandonedSince) >= _abandonedVehicleTime) then { //respawn Vehicle
                private _respawnTime = _vehicle getVariable ["respawnTime", -1];
                if (_respawnTime >= 0) then {
                    private _respawnCondition = _vehicle getVariable ["respawnCondition", "true"];
                    private _respawnCounter = _vehicle getVariable [QGVAR(RespawnCounter), 0];
                    private _respawnDirection = _vehicle getVariable [QGVAR(respawnDirection), getDir _vehicle];

                    GVAR(VehicleRespawnAllVehicles) deleteAt (GVAR(VehicleRespawnAllVehicles) find _vehicle);

                    [FUNC(performVehicleRespawn), _respawnTime, [_vehicle, typeOf _vehicle, vehicleVarName _vehicle, _respawnPosition, _respawnDirection, _respawnCondition, _respawnCounter]] call CFUNC(wait);
                };
            };
        };

    };
    _defaultState;
}] call CFUNC(addStatemachineState);

[GVAR(AbandonedVehiclesSM), "init"] call CFUNC(startStateMachine);
