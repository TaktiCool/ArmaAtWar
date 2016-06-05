#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Performs a respawn after 5 seconds

    Parameter(s):
    0: Old Vehicle <Object>
    1: Vehicle Type <String>
    2: Vehicle variable name <String>
    3: Vehicle Position <Array>
    4: Vehicle Direction <Array>
    5: Respawn Condition <String>
    6: Respawn Counter <Number>

    Returns:
    None
*/

params ["_vehicle", "_type", "_varName", "_position", "_direction", ["_respawnCondition", "true"], ["_respawnCounter", 0]];

if (!isNull _vehicle) then {
    deleteVehicle _vehicle;
};

[{
    params ["_type", "_varName", "_position", "_direction", ["_respawnCondition", "true"], ["_respawnCounter", 0]];

    private _paramsString = "params [""_respawnCounter""];";

    private _condition = compile (_paramsString + _respawnCondition);

    [{
        (_this select 1) params ["_type", "_varName", "_position", "_direction", ["_respawnCondition", "true"], ["_respawnCounter", 0]];
        _position = [_position, 10, _type] call CFUNC(findSavePosition);
        private _vehicle = _type createVehicle _position;
        _vehicle setVariable [QGVAR(respawnCounter), _respawnCounter + 1, true];
        _vehicle setDir _direction;
        _vehicle setVehicleVarName _varName;
        missionNamespace setVariable [_varName, _vehicle];
        clearItemCargoGlobal _vehicle;
        clearMagazineCargoGlobal _vehicle;
        clearWeaponCargoGlobal _vehicle;
        clearBackpackCargoGlobal _vehicle;
        _vehicle disableTIEquipment true;
    }, _condition, [_respawnCounter, _this]] call CFUNC(waitUntil);
}, 3, [_type, _varName, _position, _direction, _respawnCondition, _respawnCounter]] call CFUNC(wait);
