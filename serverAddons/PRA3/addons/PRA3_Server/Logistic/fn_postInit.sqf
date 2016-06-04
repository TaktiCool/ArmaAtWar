#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, BadGuy

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


["missionStarted", {
    {
        private _side = _x;
        private _cfg = (missionConfigFile >> "PRA3" >> "Sides" >> _side >> "cfgLogistic");
        private _objects = getArray (_cfg >> "objectToSpawn");

        _objects = _objects apply {
            private _obj = missionNamespace getVariable [_x, objNull];
            // dont allow Loading in the Create Crate Objects
            _obj setVariable ["cargoCapacity", 0];
            _obj
        };

        {
            private _content = getArray (_x >> "content");
            private _className = getText (_x >> "classname");
            private _displayName = getText (_x >> "displayName");
            [
                _displayName,
                _objects,
                3,
                compile format ["playerside isEqualTo %1", _side],
                {
                    params ["_targetPos", "", "", "_args"];
                    ["spawnCrate", [_args, getPos _targetPos]] call CFUNC(serverEvent);
                }, [_className, _content]
            ] call CFUNC(addAction);

            nil
        } count (configProperties [_cfg, "isClass _x"]);
        nil
    } count EGVAR(mission,competingSides);
}] call CFUNC(addEventHandler);

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
    {format["Load item in %1", getText(configFile >> "CfgVehicles" >> typeof cursorTarget >> "displayName")]},
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

            _draggedObject setPos [0,0,0];

            _ItemArray pushBack _draggedObject;
            _vehicle setVariable [QGVAR(CargoItems), _ItemArray, true];

            PRA3_Player setVariable [QGVAR(Item), objNull, true];
            _draggedObject setVariable [QGVAR(Player), objNull, true];

            ["forceWalk","Logistic",false] call PRA3_Core_fnc_setStatusEffect;

            PRA3_Player action ["SwitchWeapon", PRA3_Player, PRA3_Player, 0];
        }, _vehicle] call CFUNC(mutex);
    }
] call CFUNC(addAction);

[
    {getText (configFile >> "CfgActions" >> "Gear" >> "text")},
    GVAR(CargoClasses),
    5,
    {!(_target getVariable ["hasInventory", true])},
    {
        params ["_vehicle"];
        PRA3_Player action ["Gear", _vehicle];
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

["InventoryOpened", {
    (_this select 0) params ["_unit", "_container"];

    if ((typeOf _container) == "GroundWeaponHolder") then {
        private _cursorTarget = cursorTarget;
        if (!(_cursorTarget getVariable ["hasInventory", true]) && ((PRA3_Player distance _cursorTarget) < 5)) then {
            _container = _cursorTarget;
        };
    };

    if (_container getVariable ["cargoCapacity",0] == 0) exitWith {};
    GVAR(currentContainer) = _container;
    [{
        params ["_unit", "_container"];



        disableSerialization;
        private _display = (findDisplay 602);
        private _gY = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
        private _gX = (((safezoneW / safezoneH) min 1.2) / 40);

        private _xOffset = [1, -5.25] select (_container getVariable ["hasInventory",true]);

        if (_container getVariable ["hasInventory",true]) then {
            {
                private _pos = ctrlPosition _x;

                _x ctrlSetPosition [
                    (_pos select 0) + 6.25 * _gX,
                    (_pos select 1)
                ];
                _x ctrlCommit 0;
                nil
            } count allControls _display;
        } else {
            {
                (_display displayCtrl _x) ctrlSetFade 1;
                (_display displayCtrl _x) ctrlCommit 0;
                nil
            } count [1001, 632, 6554, 6307, 6385, 6321];
        };

        private _group = _display ctrlCreate ["RscControlsGroupNoScrollbars",-1];
        _group ctrlSetPosition [_xOffset*_gX+(safezoneX +(safezoneW -((safezoneW / safezoneH) min 1.2))/2),_gY+(safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2),12*_gX, 25*_gY];
        _group ctrlCommit 0;

        private _bg = _display ctrlCreate ["RscBackground", -1, _group];
        _bg ctrlSetPosition [0, 0, 12*_gX, 23*_gY];
        _bg ctrlSetBackgroundColor [0.05,0.05,0.05,0.7];
        _bg ctrlCommit 0;

        private _header = _display ctrlCreate ["RscText", -1, _group];
        _header ctrlSetPosition [0.5*_gX, 0.5*_gY, 11*_gX, 1.1*_gY];
        _header ctrlSetBackgroundColor [0,0,0,1];
        _header ctrlSetText "Cargo";
        _header ctrlCommit 0;

        with uiNamespace do {
            GVAR(CargoListBox) = _display ctrlCreate ["RscListBox", -1, _group];
            GVAR(CargoListBox) ctrlSetPosition [0.5*_gX, 1.7*_gY, 11*_gX, 17.8*_gY];
            GVAR(CargoListBox) ctrlSetBackgroundColor [0,0,0,0];
            GVAR(CargoListBox) ctrlCommit 0;
        };

        private _unloadBtn = _display ctrlCreate ["RscButton", -1, _group];
        _unloadBtn ctrlSetPosition [0.5*_gX, 20*_gY, 5.5*_gX, 1*_gY];
        _unloadBtn ctrlSetText "UNLOAD";
        _unloadBtn ctrlAddEventHandler ["ButtonClick", {
            [{
                disableSerialization;
                params ["_vehicle"];
                private _index = lbCurSel (uiNamespace getVariable QGVAR(CargoListBox));
                if (_index == -1) exitWith {};


                closeDialog 602;
                private _draggedObjectArray = _vehicle getVariable [QGVAR(CargoItems),[ObjNull]];
                private _draggedObject = _draggedObjectArray deleteAt _index;
                ["blockDamage", _draggedObject, [_draggedObject, false]] call CFUNC(targetEvent);
                ["hideObject", [_draggedObject, false]] call CFUNC(serverEvent);
                ["enableSimulation", [_draggedObject, true]] call CFUNC(serverEvent);
                [_draggedObject, PRA3_Player] call FUNC(dragObject);
                _vehicle setVariable [QGVAR(CargoItems), _draggedObjectArray, true];
            }, GVAR(currentContainer)] call CFUNC(mutex);
        }];
        _unloadBtn ctrlCommit 0;

        private _loadBarFrame = _display ctrlCreate ["RscFrame", -1, _group];
        _loadBarFrame ctrlSetPosition [0.5*_gX, 21.5*_gY, 11*_gX, 1*_gY];
        _loadBarFrame ctrlSetTextColor [0.9, 0.9, 0.9, 0.5];
        _loadBarFrame ctrlCommit 0;

        with uiNamespace do {
            GVAR(CargoLoadBar) = _display ctrlCreate ["RscProgress", -1, _group];
            GVAR(CargoLoadBar) ctrlSetPosition [0.5*_gX, 21.5*_gY, 11*_gX, 1*_gY];
            GVAR(CargoLoadBar) ctrlSetTextColor [0.9, 0.9, 0.9, 0.9];
            GVAR(CargoLoadBar) progressSetPosition 0;
            GVAR(CargoLoadBar) ctrlCommit 0;
        };



        // UPDATE LOOP
        [{
            disableSerialization;
            params ["_args", "_id"];

            if (isNull (findDisplay 602)) exitWith {
                [_id] call CFUNC(removePerFrameHandler);
            };

            _args params ["_container"];
            private _cargoItems = _container getVariable [QGVAR(CargoItems), []];
            with uiNamespace do {
                lbClear GVAR(CargoListBox);

                {
                    GVAR(CargoListBox) lbAdd getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
                    nil
                } count _cargoItems;
            };

            private _cargoCapacity = _container getVariable ["cargoCapacity", 0];
            private _usedCargoCapacity = 0;
            {
                _usedCargoCapacity = _usedCargoCapacity + (_x getVariable ["cargoSize", 0]);
            } count _cargoItems;

            with uiNamespace do {
                GVAR(CargoLoadBar) progressSetPosition (_usedCargoCapacity/_cargoCapacity);
            };



        }, 1,[_container]] call CFUNC(addPerFrameHandler);


    }, {!isNull (findDisplay 602)}, [_unit, _container]] call CFUNC(waitUntil);
}] call CFUNC(addEventHandler);
