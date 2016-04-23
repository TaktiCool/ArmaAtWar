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

GVAR(DragableClasses) = [];
{
    GVAR(DragableClasses) pushBack configName _x;
    nil
} count ("getNumber (_x >> ""isDragable"") == 1" configClasses (missionConfigFile >> "PRA3" >> "CfgEntities"));

GVAR(CargoClasses) = [];
{
    GVAR(CargoClasses) pushBack configName _x;
    nil
} count ("getNumber (_x >> ""cargoCapacity"") > 0" configClasses (missionConfigFile >> "PRA3" >> "CfgEntities"));

[
    {format ["Drag %1", getText(configFile >> "CfgVehicles" >> typeof cursorTarget >> "displayName")]},
    GVAR(DragableClasses),
    3,
    {
        (isNull assignedGunner _target) &&
        isNull (PRA3_Player getVariable [QGVAR(Item), objNull]) &&
        isNull (_target getVariable [QGVAR(Player), objNull])
    },
    {
        params ["_draggedObject"];
        [FUNC(dragObject), [_draggedObject, PRA3_Player]] call CFUNC(mutex);
    }
] call CFUNC(addAction);

[
    "Drop",
    PRA3_Player,
    0,
    {!(isNull (PRA3_Player getVariable [QGVAR(Item), objNull]))},
    {
        [PRA3_Player] call FUNC(dropObject);
    }
] call CFUNC(addAction);

[
    {format["Load Item in %1", getText(configFile >> "CfgVehicles" >> typeof cursorTarget >> "displayName")]},
    GVAR(CargoClasses),
    10,
    {!(isNull (PRA3_Player getVariable [QGVAR(Item), objNull])) && !((PRA3_Player getVariable [QGVAR(Item), objNull]) isEqualTo _target) },
    {
        params ["_vehicle"];
        [{
            params ["_vehicle"];
            private _draggedObject = PRA3_Player getVariable [QGVAR(Item), objNull];

            private _cargoSize = _draggedObject getVariable ["cargoSize", 0];
            private _ItemArray = _vehicle getVariable [QGVAR(CargoItems), []];
            private _cargoCapacity = _vehicle getVariable ["cargoCapacity", 0];
            {
                _cargoCapacity = _cargoCapacity - (_x getVariable ["cargoSize", 0]);
            } count _ItemArray;

            if (_cargoCapacity < _cargoSize) exitWith {
                ["No Cargo Space available"] call CFUNC(displayNotification);
            };


            detach _draggedObject;
            PRA3_Player playAction "released";

            ["blockDamage", _draggedObject, [_draggedObject, true]] call CFUNC(targetEvent);
            ["hideObject", [_draggedObject, true]] call CFUNC(serverEvent);
            ["enableSimulation", [_draggedObject, false]] call CFUNC(serverEvent);

            _draggedObject setPos [-10000,-10000,100000];

            _ItemArray pushBack _draggedObject;
            _vehicle setVariable [QGVAR(CargoItems), _ItemArray, true];

            PRA3_Player setVariable [QGVAR(Item), objNull, true];
            _draggedObject setVariable [QGVAR(Player), objNull, true];

            ["forceWalk", [PRA3_Player, false]] call CFUNC(localEvent);

            PRA3_Player action ["SwitchWeapon", PRA3_Player, PRA3_Player, 0];
        }, _vehicle] call CFUNC(mutex);
    }
] call CFUNC(addAction);

[
    {format["Unload Object out %2",getText(configFile >> "CfgVehicles" >> typeOf (cursorTarget getVariable [QGVAR(CargoItems),[ObjNull]] select 0) >> "displayName"), getText(configFile >> "CfgVehicles" >> typeof cursorTarget >> "displayName")]},
    GVAR(CargoClasses),
    10,
    {
        // @TODO we need to find a Idea how to change this action name
        // _target setUserActionText [_id, format["Unload %1 out %2",getText(configFile >> "CfgVehicles" >> typeOf (cursorTarget getVariable [QGVAR(CargoItems),[ObjNull]] select 0) >> "displayName"), getText(configFile >> "CfgVehicles" >> typeof cursorTarget >> "displayName")]];
        isNull (PRA3_Player getVariable [QGVAR(Item), objNull]) && !((_target getVariable [QGVAR(CargoItems), []]) isEqualTo [])
    },
    {
        params ["_vehicle"];
        [{
            params ["_vehicle"];
            private _draggedObjectArray = _vehicle getVariable [QGVAR(CargoItems),[ObjNull]];
            private _draggedObject = _draggedObjectArray deleteAt 0;
            ["blockDamage", _draggedObject, [_draggedObject, false]] call CFUNC(targetEvent);
            ["hideObject", [_draggedObject, false]] call CFUNC(serverEvent);
            ["enableSimulation", [_draggedObject, true]] call CFUNC(serverEvent);
            [_draggedObject, PRA3_Player] call FUNC(dragObject);
            _vehicle setVariable [QGVAR(CargoItems), _draggedObjectArray, true];
        }, _vehicle] call CFUNC(mutex);
    }
] call CFUNC(addAction);
