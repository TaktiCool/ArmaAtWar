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

{
    if (getNumber (_x >> "scope") > 0) then {
        private _vehicle = missionNamespace getVariable [configName _x, objNull];
        if (!isNull _vehicle) then {
            {
                if (isNumber _x) then {
                    _vehicle setVariable [format [QGVAR(%1), configName _x], getNumber (_x)];
                };

                if (isText _x) then {
                    _vehicle setVariable [format [QGVAR(%1), configName _x], getText (_x)];
                };

                if (isArray _x) then {
                    _vehicle setVariable [format [QGVAR(%1), configName _x], getArray (_x)];
                };
                nil;
            } count configProperties [_x];


            if (getNumber (_x >> "respawnTime") >= 0) then {

                _vehicle setVariable [QGVAR(respawnPosition), getPos _vehicle];
                _vehicle setVariable [QGVAR(respawnDirection), getDir _vehicle];



                private _varNames = [];
                private _varValues = [];
                {
                    if !(_x in CGVAR(ignoreVariables)) then {
                        if ((_x find "pra3") == 0) then {
                            private _var = (_vehicle getVariable _x);
                            if !(isNil "_var") then {
                                _varNames pushBack _x;
                                _varValues pushBack _var;
                            };
                        };
                    };
                    nil
                } count allVariables _vehicle;

                [_vehicle, typeOf _vehicle, _varNames, _varValues] call FUNC(performVehicleRespawn);
            };
        };
    };
    nil
} count ("true" configClasses (missionConfigFile >> "PRA3" >> "CfgEntities"));

addMissionEventHandler ["EntityKilled", {
    params ["_killedEntity","_killer"];
    if (_killedEntity in GVAR(VehicleRespawnAllVehicles)) then {
        private _type = typeOf _killedEntity;
        private _respawnTime = _killedEntity getVariable [QGVAR(RespawnTime), 0];

        private _varNames = [];
        private _varValues = [];
        {
            if ((_x find "pra3") == 0) then {
                _varNames pushBack _x;
                _varValues pushBack (_killedEntity getVariable _x);
            };
            nil;
        } count allVariables _killedEntity;

        GVAR(VehicleRespawnAllVehicles) deleteAt (GVAR(VehicleRespawnAllVehicles) find _killedEntity);

        [FUNC(performVehicleRespawn), _respawnTime, [_killedEntity, _type, _varNames, _varValues]] call CFUNC(wait);
    };
}];
