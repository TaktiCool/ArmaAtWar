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

DFUNC(VehicleRespawn_PerformRespawn) = {
    params ["_vehicle", "_type", "_pos", "_dir", "_respawnTime","_respawnCondition", "_side"];

    if (!isNull _vehicle) then {
        deleteVehicle _vehicle;
    };

    [ {
        [{
            params ["_type", "_pos", "_dir", "_respawnTime","_respawnCondition","_side"];
            hint format ["Vehicle Respawned: %1",_side];
            private _vehicle = _type createVehicle _pos;
            _vehicle setDir _dir;
            _vehicle setVariable [QGVAR(RespawnPosition), _pos];
            _vehicle setVariable [QGVAR(RespawnDirection), _dir];
            _vehicle setVariable [QGVAR(RespawnTime), _respawnTime];
            _vehicle setVariable [QGVAR(RespawnCondition), _respawnCondition];
            _vehicle setVariable [QGVAR(RespawnSide), _side];

            GVAR(VehicleRespawnAllVehicles) pushBack _vehicle;

            [QGVAR(vehicleRespawnAvailable), _side, _vehicle] call CFUNC(targetEvent);

        }, _this select 4, _this] call CFUNC(waitUntil);
    }, 5, [_type, _pos, _dir, 2, _respawnCondition, _side]] call CFUNC(wait);
};

{
    private _vehicle = missionNamespace getVariable [configName _x, objNull];
    if (!isNull _vehicle) then {
        [_vehicle, typeOf _vehicle, getPos _vehicle, getDir _vehicle, getNumber (_x >> "respawnTime"), compile getText (_x >> "condition"), toUpper getText (_x >> "side")] call DFUNC(VehicleRespawn_PerformRespawn);
    };
    nil
} count ("configName _x != ""default""" configClasses (missionConfigFile >> "PRA3" >> "CfgVehicleRespawn"));

addMissionEventHandler ["EntityKilled",{
    params["_killedEntity","_killer"];
    if (_killedEntity in GVAR(VehicleRespawnAllVehicles)) then {
        private _type = typeOf _killedEntity;
        private _pos = _killedEntity getVariable [QGVAR(RespawnPosition), getPos _killedEntity];
        private _dir = _killedEntity getVariable [QGVAR(RespawnDirection), getDir _killedEntity];
        private _respawnTime = _killedEntity getVariable [QGVAR(RespawnTime), 10];
        private _respawnCondition = _killedEntity getVariable [QGVAR(RespawnCondition), {true}];
        private _side = _killedEntity getVariable [QGVAR(RespawnSide), str sideUnknown];

        GVAR(VehicleRespawnAllVehicles) deleteAt (GVAR(VehicleRespawnAllVehicles) find _killedEntity);

        [DFUNC(VehicleRespawn_PerformRespawn), _respawnTime, [_killedEntity, _type, _pos, _dir, _respawnTime-2, _respawnCondition, _side]] call CFUNC(wait);
    };
}];

[QGVAR(vehicleRespawnAvailable), {
    params ["_args"];
    _args params ["_vehicle"];
    // Dont use playerSide the player side dont change if chaning the side
    private _vehicleConfig = configFile >> "CfgVehicles" >> typeOf _vehicle;
    ["PRA3_VehicleRespawnAvailable", [ getText (_vehicleConfig >> "displayName"), getText (_vehicleConfig >> "picture") ]] call BIS_fnc_showNotification;

}] call CFUNC(addEventHandler);
