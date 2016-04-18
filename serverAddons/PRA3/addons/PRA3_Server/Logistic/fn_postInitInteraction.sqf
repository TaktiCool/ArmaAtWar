#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Logistic system

    Parameter(s):
    None

    Returns:
    None
*/


if (isDedicated || !hasInterface) exitWith {};

[
    {format ["Drag %1", getText(configFile >> "CfgVehicles" >> typeof cursorTarget >> "displayName")]},
    ["StaticWeapon", "ReammoBox_F"],
    3,
    {
        (isNull assignedGunner _target) &&
        !(_target isKindOf 'Pod_Heli_Transport_04_base_F') &&
        !(_target isKindOf 'Slingload_base_F') &&
        isNull (PRA3_Player getVariable [QGVAR(Item), objNull]) &&
        isNull (_target getVariable [QGVAR(Player), objNull])
    },
    {
        params ["_draggedObject"];
        [_draggedObject, PRA3_Player] call FUNC(dragObject);
    }
] call CFUNC(addAction);

[
    "Drop",
    PRA3_Player,
    0,
    {!(isNull (PRA3_Player getVariable [QGVAR(Item), objNull]))},
    {
        private _draggedObject = PRA3_Player getVariable [QGVAR(Item), objNull];

        PRA3_Player playAction "released";

        if (isNull _draggedObject) exitWith {};

        PRA3_Player setVariable [QGVAR(Item), objNull, true];
        _draggedObject setVariable [QGVAR(Player), objNull, true];

        detach _draggedObject;
        ["forceWalk", [PRA3_Player, false]] call CFUNC(localEvent);
        ["enableSimulation", [_draggedObject, true]] call CFUNC(serverEvent);
        private _position = getPosATL _draggedObject;
        if (_position select 2 < 0) then {
            _position set [2, 0];
            _draggedObject setPosATL _position;
        };
        ["fixFloating", _draggedObject, _draggedObject] call CFUNC(targetEvent);
        PRA3_Player action ["SwitchWeapon", PRA3_Player, PRA3_Player, 0];
    }
] call CFUNC(addAction);

[
    {format["Load Item in %1", getText(configFile >> "CfgVehicles" >> typeof cursorTarget >> "displayName")]},
    ["Car","Helicopter_Base_H","I_Heli_light_03_base_F ","Ship", "Land_CargoBox_V1_F", "B_Slingload_01_Cargo_F"],
    10,
    {!(isNull (PRA3_Player getVariable [QGVAR(Item), objNull]))},
    {
        params ["_vehicle"];
        private _draggedObject = PRA3_Player getVariable [QGVAR(Item), objNull];
        PRA3_Player playAction "released";
        detach _draggedObject;
        ["blockDamage", _draggedObject, [_draggedObject, true]] call CFUNC(targetEvent);
        ["forceWalk", [PRA3_Player, false]] call CFUNC(localEvent);
        ["hideObject", [_draggedObject, true]] call CFUNC(serverEvent);
        ["enableSimulation", [_draggedObject, false]] call CFUNC(serverEvent);
        _draggedObject setPos [-10000,-10000,100000];
        private _ItemArray = _vehicle getVariable [QGVAR(CargoItems), []];
        _ItemArray pushBack _draggedObject;
        _vehicle setVariable [QGVAR(CargoItems), _ItemArray, true];
        PRA3_Player setVariable [QGVAR(Item),objNull, true];
        PRA3_Player action ["SwitchWeapon", PRA3_Player, PRA3_Player, 0];
    }
] call CFUNC(addAction);

[
    {format["Unload %1 out %2",getText(configFile >> "CfgVehicles" >> typeOf (cursorTarget getVariable [QGVAR(CargoItems),[ObjNull]] select 0) >> "displayName"), getText(configFile >> "CfgVehicles" >> typeof cursorTarget >> "displayName")]},
    ["AllVehicles", "Land_CargoBox_V1_F", "B_Slingload_01_Cargo_F"],
    10,
    {isNull (PRA3_Player getVariable [QGVAR(Item), objNull]) && !((_target getVariable [QGVAR(CargoItems), []]) isEqualTo [])},
    {
        params ["_vehicle"];
        private _draggedObjectArray = _vehicle getVariable [QGVAR(CargoItems),[ObjNull]];
        private _draggedObject = _draggedObjectArray deleteAt 0;
        ["blockDamage", _draggedObject, [_draggedObject, false]] call CFUNC(targetEvent);
        ["hideObject", [_draggedObject, false]] call CFUNC(serverEvent);
        ["enableSimulation", [_draggedObject, true]] call CFUNC(serverEvent);
        [_draggedObject, PRA3_Player] call FUNC(dragObject);
    }
] call CFUNC(addAction);
