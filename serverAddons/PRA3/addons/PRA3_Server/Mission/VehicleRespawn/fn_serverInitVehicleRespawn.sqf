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
    params["_vehicle","_respawnTime"];
    _vehicle setVariable [QGVAR(RespawnPosition), getPos _vehicle];
    _vehicle setVariable [QGVAR(RespawnDirection), getDir _vehicle];
    _vehicle setVariable [QGVAR(RespawnTime), getNumber (_x >> "respawnTime"))];

    GVAR(VehicleRespawnAllVehicles) pushBack _vehicle;
};

{
    private _vehicle = missionNamespace getVariable [configName _x, objNull];
    if (!isNull _vehicle) then {
        [_vehicle, getNumber (_x >> "respawnTime")] call DFUNC(VehicleRespawn_VehicleInit);
    };

} count ("configName _x != ""default""" configClasses (missionConfigFile >> "PRA3" >> "CfgVehicleRespawn"));

private _id = addMissionEventHandler ["EntityKilled",{
    params["_killedEntity","_killer"];
    if (_killedEntity in GVAR(VehicleRespawnAllVehicles)) then {
        hint "Respawn Vehicle Killed";

        private _pos = _vehicle setVariable [QGVAR(RespawnPosition), getPos _vehicle];
        private _dir = _vehicle setVariable [QGVAR(RespawnDirection), getDir _vehicle];
        private _type = typeOf _vehicle;
        private _respawnTime = _vehicle setVariable [QGVAR(RespawnTime), getNumber (_x >> "respawnTime"))];

        [{
            params ["_vehicle", "_type", "_pos", "_dir", "_respawnTime"];

            if (!isNull _vehicle) then {
                deleteVehicle _vehicle;
            };

            _vehicle = _type createVehicle _pos;
            _vehicle setDir _dir;

            [_vehicle, _respawnTime] call DFUNC(VehicleRespawn_VehicleInit);

        }, _respawnTime, [_vehicle, _type, _pos, _dir, _respawnTime]] call CFUNC(wait);
    };
}];
