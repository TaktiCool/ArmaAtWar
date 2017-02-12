#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy

    Description:
    Performs a respawn after 5 seconds

    Parameter(s):
    0: Old vehicle <Object> (Default: objNull)

    Returns:
    None
*/

params [
    ["_vehicle", objNull, [objNull]]
];

if (isNull _vehicle) exitWith {
    LOG("Tried to perform vehicle respawn on objNull");
};

private _respawnCondition = compile (_vehicle getVariable ["respawnCondition", "true"]); // TODO #336
private _vehicleType = typeOf _vehicle;
private _vehicleVarName = vehicleVarName _vehicle;
private _respawnPosition = _vehicle getVariable [QGVAR(respawnPosition), getPos _vehicle];
private _respawnDirection = _vehicle getVariable [QGVAR(respawnDirection), getDir _vehicle];
private _respawnCounter = _vehicle getVariable [QGVAR(respawnCounter), 0];

deleteVehicle _vehicle;

[{
    params ["_respawnCondition", "_respawnArgs"];

    [{
        params ["_vehicleType", "_vehicleVarName", "_respawnPosition", "_respawnDirection", "_respawnCounter"];

        _respawnPosition = [_respawnPosition, 10, 0, _vehicleType] call CFUNC(findSavePosition);

        private _vehicle = _vehicleType createVehicle _respawnPosition;

        ["setVehicleVarName", [_vehicle, _vehicleVarName]] call CFUNC(globalEvent);
        missionNamespace setVariable [_vehicleVarName, _vehicle, true];
        _vehicle setVariable [QGVAR(vehicleVarName), _vehicleVarName, true];

        _vehicle setDir _respawnDirection;
        _vehicle setVariable [QGVAR(respawnCounter), _respawnCounter + 1];

        clearItemCargoGlobal _vehicle;
        clearMagazineCargoGlobal _vehicle;
        clearWeaponCargoGlobal _vehicle;
        clearBackpackCargoGlobal _vehicle;

        _vehicle disableTIEquipment true; // TODO make this configurable
    }, _respawnCondition, _respawnArgs] call CFUNC(waitUntil);
}, 3, [_respawnCondition, [_vehicleType, _vehicleVarName, _respawnPosition, _respawnDirection, _respawnCounter]]] call CFUNC(wait);
