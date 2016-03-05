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
    {format ["Drag %1", getText(configFile >> "CfgVehicles" >> typeof cursorObject >> "displayName")]},
    ["StaticWeapon", "ReammoBox_F"],
    3,
    "(isNull assignedGunner _target) && !(_target isKindOf 'Pod_Heli_Transport_04_base_F') && !(_target isKindOf 'Slingload_base_F') && isNull (PRA3_Player getVariable ['PRA3_Logistic_Item', objNull]) && isNull (_target getVariable ['PRA3_Logistic_Player', objNull])",
    {
        params ["_draggedObject"];
        [_draggedObject, PRA3_Player] call FUNC(dragObject);
    }
] call CFUNC(addAction);

[
    "Drop",
    PRA3_Player,
    0,
    "!(isNull (PRA3_Player getVariable ['PRA3_Logistic_Item', objNull]))",
    {
        private _draggedObject = PRA3_Player getVariable [QGVAR(Item), objNull];

        PRA3_Player playAction "released";

        if (isNull _draggedObject) exitWith {};

        PRA3_Player setVariable [QGVAR(Item), objNull, true];
        _draggedObject setVariable [QGVAR(Player), objNull, true];

        detach _draggedObject;
        PRA3_Player forceWalk false;
        _draggedObject setDamage 0;
        ["enableSimulation", [_draggedObject, true]] call CFUNC(serverEvent);
        private _position = getPosATL _draggedObject;
        if (_position select 2 < 0) then {
            _position set [2, 0];
            _draggedObject setPosATL _position;
        };
    }
] call CFUNC(addAction);

[
    {format["Load Item in %1", getText(configFile >> "CfgVehicles" >> typeof cursorObject >> "displayName")]},
    ["Car","Helicopter_Base_H","I_Heli_light_03_base_F ","Ship"],
    10,
    "!(isNull (PRA3_Player getVariable ['PRA3_Logistic_Item', objNull]))",
    {
        params ["_vehicle"];
        private _draggedObject = PRA3_Player getVariable [QGVAR(Item), objNull];
        PRA3_Player playAction "released";
        _draggedObject allowDamage false;
        _draggedObject setDamage 0;
        detach _draggedObject;
        ["hideObject", [_draggedObject, true]] call CFUNC(serverEvent);
        ["enableSimulation", [_draggedObject, false]] call CFUNC(serverEvent);
        _draggedObject setPos [-10000,-10000,100000];
        private _ItemArray = _vehicle getVariable [QGVAR(CargoItems), []];
        _ItemArray pushBack _draggedObject;
        _vehicle setVariable [QGVAR(CargoItems), _ItemArray, true];
        PRA3_Player setVariable ["PRA3_Logistic_Item",objNull, true];
    }
] call CFUNC(addAction);

[
    {format["Unload %1 out %2",getText(configFile >> "CfgVehicles" >> typeOf (cursorObject getVariable [QGVAR(CargoItems),[ObjNull]] select 0) >> "displayName"), getText(configFile >> "CfgVehicles" >> typeof cursorObject >> "displayName")]},
    ["AllVehicles"],
    10,
    "isNull (PRA3_Player getVariable ['PRA3_Logistic_Item', objNull]) && !((_target getVariable ['PRA3_Logistic_CargoItems', []]) isEqualTo [])",
    {
        params ["_vehicle"];
        private _draggedObjectArray = _vehicle getVariable [QGVAR(CargoItems),[ObjNull]];
        private _draggedObject = _draggedObjectArray deleteAt 0;
        ["hideObject", [_draggedObject, false]] call CFUNC(serverEvent);
        ["enableSimulation", [_draggedObject, true]] call CFUNC(serverEvent);
        [_draggedObject, PRA3_Player] call FUNC(dragObject);
    }
] call CFUNC(addAction);
