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

DFUNC(VehicleRespawn_VehicleInit) = {
    params ["_vehicle","_respawnTime"];
    _vehicle setVariable [QGVAR(RespawnPosition), getPos _vehicle];
    _vehicle setVariable [QGVAR(RespawnDirection), getDir _vehicle];
    _vehicle setVariable [QGVAR(RespawnTime), _respawnTime];

    GVAR(VehicleRespawnAllVehicles) pushBack _vehicle;
};

{
    private _vehicle = missionNamespace getVariable [configName _x, objNull];
    if (!isNull _vehicle) then {
        [_vehicle, getNumber (_x >> "respawnTime")] call DFUNC(VehicleRespawn_VehicleInit);
    };
    nil
} count ("configName _x != ""default""" configClasses (missionConfigFile >> "PRA3" >> "CfgVehicleRespawn"));

private _id = addMissionEventHandler ["EntityKilled",{
    params["_killedEntity","_killer"];
    if (_killedEntity in GVAR(VehicleRespawnAllVehicles)) then {
        hint "Respawn Vehicle Killed";

        private _pos = _killedEntity getVariable [QGVAR(RespawnPosition), getPos _killedEntity];
        private _dir = _killedEntity getVariable [QGVAR(RespawnDirection), getDir _killedEntity];
        private _type = typeOf _killedEntity;
        private _respawnTime = _killedEntity getVariable [QGVAR(RespawnTime), 10];

        GVAR(VehicleRespawnAllVehicles) deleteAt (GVAR(VehicleRespawnAllVehicles) find _killedEntity);

        [{
            params ["_vehicle", "_type", "_pos", "_dir", "_respawnTime"];

            if (!isNull _vehicle) then {
                deleteVehicle _vehicle;
            };

            hint "Vehicle Deleted";

            [{
                params ["_type", "_pos", "_dir", "_respawnTime"];
                hint "Vehicle Respawned";
                private _vehicle = _type createVehicle _pos;
                _vehicle setDir _dir;

                [_vehicle, _respawnTime] call DFUNC(VehicleRespawn_VehicleInit);

            }, 5, [_type, _pos, _dir, _respawnTime]] call CFUNC(wait);

        }, _respawnTime, [_killedEntity, _type, _pos, _dir, _respawnTime-5]] call CFUNC(wait);
    };
}];
