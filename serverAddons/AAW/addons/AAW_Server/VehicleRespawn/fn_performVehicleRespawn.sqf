#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy

    Description:
    Performs a respawn after specified amount of seconds. Minimum is 3 seconds.

    Parameter(s):
    0: Old vehicle <Object> (Default: objNull)
    1: Respawn time <Number> (Default: 0)

    Returns:
    None
*/

params [
    ["_vehicle", objNull, [objNull]],
    ["_respawnTime", 0, [0]]
];

if (isNull _vehicle) exitWith {
    LOG("Tried to perform vehicle respawn on objNull");
};

// Get everything we need before the vehicle is deleted by anyone
private _condition = compile (_vehicle getVariable ["respawnCondition", "true"]); // TODO #336
private _vehicleType = typeOf _vehicle;
private _vehicleVarName = vehicleVarName _vehicle;
private _position = _vehicle getVariable [QGVAR(respawnPosition), getPos _vehicle];
private _direction = _vehicle getVariable [QGVAR(respawnDirection), getDir _vehicle];
private _respawnCounter = _vehicle getVariable [QGVAR(respawnCounter), 0];

// Wait the respawn time until performing the respawn
[{
    params ["_vehicle", "_condition", "_args"];

    // If the old vehicle still exists delete it
    if (!isNull _vehicle) then {
        deleteVehicle _vehicle;
    };

    [{
        params ["_vehicleType", "_vehicleVarName", "_position", "_direction", "_respawnCounter"];

        _position = [_position, 10, 0, _vehicleType] call CFUNC(findSavePosition);

        private _vehicle = _vehicleType createVehicle _position;

        ["setVehicleVarName", [_vehicle, _vehicleVarName]] call CFUNC(globalEvent);
        missionNamespace setVariable [_vehicleVarName, _vehicle, true];
        _vehicle setVariable [QGVAR(vehicleVarName), _vehicleVarName, true];

        _vehicle setDir _direction;
        _vehicle setVariable [QGVAR(respawnCounter), _respawnCounter + 1];

        clearItemCargoGlobal _vehicle;
        clearMagazineCargoGlobal _vehicle;
        clearWeaponCargoGlobal _vehicle;
        clearBackpackCargoGlobal _vehicle;

        _vehicle disableTIEquipment true; // TODO make this configurable
    }, _condition, _args] call CFUNC(waitUntil);
}, _respawnTime max 3, [_vehicle, _condition, [_vehicleType, _vehicleVarName, _position, _direction, _respawnCounter]]] call CFUNC(wait);
