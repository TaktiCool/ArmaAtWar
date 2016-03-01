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
#define __DRAGANIMSTATE ["amovpercmstpslowwrfldnon_acinpknlmwlkslowwrfldb_2", "amovpercmstpsraswpstdnon_acinpknlmwlksnonwpstdb_2", "amovpercmstpsnonwnondnon_acinpknlmwlksnonwnondb_2", "acinpknlmstpsraswrfldnon", "acinpknlmstpsnonwpstdnon", "acinpknlmstpsnonwnondnon"]
#define __MAXWEIGHT 800

[
    {format ["Drag %1", getText(configFile >> "CfgVehicles" >> typeof cursorObject >> "displayName")]},
    ["StaticWeapon", "ReammoBox_F"],
    3,
    "(isNull assignedGunner _target) && !(_target isKindOf 'Pod_Heli_Transport_04_base_F') && !(_target isKindOf 'Slingload_base_F') && isNull (PRA3_Player getVariable ['PRA3_Logistic_Item', objNull]) && isNull (_target getVariable ['PRA3_Logistic_Player', objNull])",
    {
        private ["_currentWeight", "_gunner", "_attachPoint"];
        params ["_draggedObject"];
        _currentWeight = _draggedObject call JK_Core_fnc_GetWeight;
        if (_currentWeight >= __MAXWEIGHT) exitWith {
            hint format[localize "STR_JK_JK_TOHEAVY", _currentWeight - __MAXWEIGHT];
        };

        if (_draggedObject isKindOf "StaticWeapon") then {
            _gunner = gunner _draggedObject;
            if (!isNull _gunner && alive _gunner) then {
                _gunner setPosASL getPosASL _gunner;
            };
        };
        _attachPoint = [0,0,0];
        PRA3_Player setVariable [QGVAR(Item), _draggedObject, true];
        _draggedObject setVariable [QGVAR(Player), PRA3_Player, true];
        if (_draggedObject isKindOf "StaticWeapon" || _currentWeight >= __MAXWEIGHT /2) then {
            PRA3_Player playActionNow "grabDrag";
            waitUntil {animationState PRA3_Player in __DRAGANIMSTATE};
            _attachPoint = [0, 1.3, ((_draggedObject modelToWorld [0,0,0]) select 2) - ((PRA3_Player modelToWorld [0,0,0]) select 2)];
        } else {
            PRA3_Player action ["WeaponOnBack",PRA3_Player];
            _attachPoint = [0, 1.3, ((_draggedObject modelToWorld [0,0,0]) select 2) - ((PRA3_Player modelToWorld [0,0,0]) select 2) + 0.5];
            PRA3_Player forceWalk true;
        };
        _draggedObject attachTo [PRA3_Player, _attachPoint];

        // TODO replace with PFH
        JK_var_GetInVehiclePFH = addMissionEventHandler ["Draw3D",{
            if (PRA3_Player == vehicle PRA3_Player) exitWith {};
            private ["_draggedObject", "_position"];
            _draggedObject = PRA3_Player getVariable [QGVAR(Item), objNull];
            detach _draggedObject;
            if (isNull _draggedObject) exitWith {};
            PRA3_Player setVariable [QGVAR(Item), objNull, true];
            _draggedObject setVariable [QGVAR(Player), objNull, true];
            detach _draggedObject;
            PRA3_Player forceWalk false;
            _draggedObject setDamage 0;
            _draggedObject enableSimulationGlobal true;
            _position = getPosATL _draggedObject;
            if (_position select 2 < 0) then {
                _position set [2, 0];
                _draggedObject setPosATL _position;
           };
            removeMissionEventHandler ["Draw3D",JK_var_GetInVehiclePFH];
        }];

    }
] call CFUNC(addAction);

/* Not used this is for BIS Medical System
[
    {format [localize "STR_JK_JK_DRAG_MED", (if ((PRA3_Player getVariable ["JK_LastTarget", cursorObject]) isKindOf "Man") then {name (PRA3_Player getVariable ["JK_LastTarget", cursorObject])} else {getText(configFile >> "CfgVehicles" >> typeof (PRA3_Player getVariable ["JK_LastTarget", cursorObject]) >> "displayName")})]},
    ["Man"],
    3,
    "isNull (PRA3_Player getVariable ['PRA3_Logistic_Item', objNull]) && isNull (_target getVariable ['PRA3_Logistic_Player', objNull]) && ([_target in JK_BIS_revive_units, false] select (isNil 'JK_BIS_revive_units') || [_target in BIS_revive_units, false] select (isNil 'BIS_revive_units')) && !(_target isKindOf 'Man')",

    {
        private "_attachPoint";
        params ["_draggedObject"];

        PRA3_Player setVariable [QGVAR(Item), _draggedObject, true];
        _draggedObject setVariable [QGVAR(Player), PRA3_Player, true];

        PRA3_Player playActionNow "grabDrag";
        waitUntil {animationState PRA3_Player in __DRAGANIMSTATE};

        _attachPoint = [0, 1.1, ((getPos _draggedObject) select 2) - ((getPos PRA3_Player) select 2)];
        _draggedObject attachTo [PRA3_Player, _attachPoint];
    }
] call JK_Core_fnc_Interaction_addAction;
*/

[
    "Drop",
    PRA3_Player,
    0,
    "!(isNull (PRA3_Player getVariable ['PRA3_Logistic_Item', objNull]))",
    {
        private ["_draggedObject", "_position"];
        _draggedObject = PRA3_Player getVariable [QGVAR(Item), objNull];

        PRA3_Player playAction "released";

        if (isNull _draggedObject) exitWith {};

        PRA3_Player setVariable [QGVAR(Item), objNull, true];
        _draggedObject setVariable [QGVAR(Player), objNull, true];

        detach _draggedObject;
        PRA3_Player forceWalk false;
        _draggedObject setDamage 0;
        _draggedObject enableSimulationGlobal true;
        _position = getPosATL _draggedObject;
        if (_position select 2 < 0) then {
            _position set [2, 0];
            _draggedObject setPosATL _position;
        };
    }
] call JK_Core_fnc_Interaction_addAction;

[
    {format["Load Item in %1", getText(configFile >> "CfgVehicles" >> typeof cursorObject >> "displayName")]},
    ["Car","Helicopter_Base_H","I_Heli_light_03_base_F ","Ship"],
    10,
    "!(isNull (PRA3_Player getVariable ['PRA3_Logistic_Item', objNull]))",
    {
        private ["_draggedObject", "_ItemArray"];
        params ["_vehicle"];
        _draggedObject = PRA3_Player getVariable [QGVAR(Item), objNull];
        PRA3_Player playAction "released";
        _draggedObject enableSimulationGlobal false;
        _draggedObject allowDamage false;
        _draggedObject setDamage 0;
        detach _draggedObject;
        [[_draggedObject, true], "hideObjectGlobal", false, false, true] call BIS_fnc_MP;
        _draggedObject setPos [-10000,-10000,100000];
        _ItemArray = _vehicle getVariable [QGVAR(CargoItems), []];
        _ItemArray pushBack _draggedObject;
        _vehicle setVariable [QGVAR(CargoItems), _ItemArray];
        PRA3_Player setVariable ["PRA3_Logistic_Item",objNull];
    }
] call CFUNC(addAction);

[
    {format["Unload %1 out %2",getText(configFile >> "CfgVehicles" >> typeOf (cursorObject getVariable [QGVAR(CargoItems),[ObjNull]] select 0) >> "displayName"), getText(configFile >> "CfgVehicles" >> typeof cursorObject >> "displayName")]},
    ["AllVehicles"],
    10,
    "isNull (PRA3_Player getVariable ['PRA3_Logistic_Item', objNull]) && !((_target getVariable ['PRA3_Logistic_CargoItems', []]) isEqualTo [])",
    {
        private ["_draggedObjectArray", "_draggedObject", "_attachPoint", "_item"];
        params ["_vehicle"];
        _draggedObjectArray = _vehicle getVariable [QGVAR(CargoItems),[ObjNull]];
        _draggedObject = _draggedObjectArray deleteAt 0;
        _currentWeight = _draggedObject call JK_Core_fnc_GetWeight;
        _vehicle setVariable [QGVAR(CargoItems),_draggedObjectArray,true];
        PRA3_Player setVariable [QGVAR(Item), _draggedObject, true];
        _draggedObject setVariable [QGVAR(Player), PRA3_Player, true];
        _attachPoint = [0, 1.3, 0.5];
        PRA3_Player forceWalk true;
        removeMissionEventHandler ["Draw3D",JK_var_GetInVehiclePFH];
        [[_draggedObject, true], "hideObjectGlobal", false, false, true] call BIS_fnc_MP;
        if (_draggedObject isKindOf "StaticWeapon" || _currentWeight >= __MAXWEIGHT /2) then {
            PRA3_Player playActionNow "grabDrag";
            waitUntil {animationState PRA3_Player in __DRAGANIMSTATE};
        } else {
            PRA3_Player action ["WeaponOnBack",PRA3_Player];
        };
        _draggedObject attachTo [PRA3_Player, _attachPoint];
        _draggedObject enableSimulationGlobal true;
        _draggedObject allowDamage true;
        _draggedObject setDamage 0;
    }
] call CFUNC(addAction);
