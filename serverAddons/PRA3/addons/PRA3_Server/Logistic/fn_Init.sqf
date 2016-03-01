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
    {format [localize "STR_JK_JK_DRAG", getText(configFile >> "CfgVehicles" >> typeof cursorTarget >> "displayName")]},
    ["StaticWeapon", "ReammoBox_F"],
    3,
    "(isNull assignedGunner _target) && !(_target in JK_var_ChooseLoadout_Boxes) && !(_target isKindOf 'Pod_Heli_Transport_04_base_F') && !(_target isKindOf 'Slingload_base_F') && isNull (player getVariable ['JK_DragDrop_Item', objNull]) && isNull (_target getVariable ['JK_DragDrop_Player', objNull])",
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
        player setVariable ["JK_DragDrop_Item", _draggedObject, true];
        _draggedObject setVariable ["JK_DragDrop_Player", player, true];
        if (_draggedObject isKindOf "StaticWeapon" || _currentWeight >= __MAXWEIGHT /2) then {
            player playActionNow "grabDrag";
            waitUntil {animationState player in __DRAGANIMSTATE};
            _attachPoint = [0, 1.3, ((_draggedObject modelToWorld [0,0,0]) select 2) - ((player modelToWorld [0,0,0]) select 2)];
        } else {
            player action ["WeaponOnBack",player];
            _attachPoint = [0, 1.3, ((_draggedObject modelToWorld [0,0,0]) select 2) - ((player modelToWorld [0,0,0]) select 2) + 0.5];
            player forceWalk true;
        };
        _draggedObject attachTo [player, _attachPoint];
        JK_var_GetInVehiclePFH = addMissionEventHandler ["Draw3D",{
            if (player == vehicle player) exitWith {};
            private ["_draggedObject", "_position"];
            _draggedObject = player getVariable ["JK_DragDrop_Item", objNull];
            detach _draggedObject;
            if (isNull _draggedObject) exitWith {};
            player setVariable ["JK_DragDrop_Item", objNull, true];
            _draggedObject setVariable ["JK_DragDrop_Player", objNull, true];
            detach _draggedObject;
            player forceWalk false;
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
] call JK_Core_fnc_Interaction_addAction;

[
    {format [localize "STR_JK_JK_DRAG_MED", (if ((player getVariable ["JK_LastTarget", cursorTarget]) isKindOf "Man") then {name (player getVariable ["JK_LastTarget", cursorTarget])} else {getText(configFile >> "CfgVehicles" >> typeof (player getVariable ["JK_LastTarget", cursorTarget]) >> "displayName")})]},
    ["Man"],
    3,
    "isNull (player getVariable ['JK_DragDrop_Item', objNull]) && isNull (_target getVariable ['JK_DragDrop_Player', objNull]) && ([_target in JK_BIS_revive_units, false] select (isNil 'JK_BIS_revive_units') || [_target in BIS_revive_units, false] select (isNil 'BIS_revive_units')) && !(_target isKindOf 'Man')",

    {
        private "_attachPoint";
        params ["_draggedObject"];

        player setVariable ["JK_DragDrop_Item", _draggedObject, true];
        _draggedObject setVariable ["JK_DragDrop_Player", player, true];

        player playActionNow "grabDrag";
        waitUntil {animationState player in __DRAGANIMSTATE};

        _attachPoint = [0, 1.1, ((getPos _draggedObject) select 2) - ((getPos player) select 2)];
        _draggedObject attachTo [player, _attachPoint];
    }
] call JK_Core_fnc_Interaction_addAction;

[
    (localize "STR_JK_JK_DROP"),
    player,
    0,
    "!(isNull (player getVariable ['JK_DragDrop_Item', objNull]))",
    {
        private ["_draggedObject", "_position"];
        _draggedObject = player getVariable ["JK_DragDrop_Item", objNull];

        player playAction "released";

        if (isNull _draggedObject) exitWith {};

        player setVariable ["JK_DragDrop_Item", objNull, true];
        _draggedObject setVariable ["JK_DragDrop_Player", objNull, true];

        detach _draggedObject;
        player forceWalk false;
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
    {format[localize "STR_JK_JK_LOADIN", getText(configFile >> "CfgVehicles" >> typeof cursorTarget >> "displayName")]},
    ["Car","Helicopter_Base_H","I_Heli_light_03_base_F ","Ship"],
    10,
    "!(isNull (player getVariable ['JK_DragDrop_Item', objNull]))",
    {
        private ["_draggedObject", "_ItemArray"];
        params ["_vehicle"];
        _draggedObject = player getVariable ["JK_DragDrop_Item", objNull];
        player playAction "released";
        _draggedObject enableSimulationGlobal false;
        _draggedObject allowDamage false;
        _draggedObject setDamage 0;
        detach _draggedObject;
        [[_draggedObject, true], "hideObjectGlobal", false, false, true] call BIS_fnc_MP;
        _draggedObject setPos [-10000,-10000,100000];
        _ItemArray = _vehicle getVariable ["JK_Loadedin", []];
        _ItemArray pushBack _draggedObject;
        _vehicle setVariable ["JK_Loadedin", _ItemArray];
        player setVariable ["JK_DragDrop_Item",objNull];
    }
] call JK_Core_fnc_Interaction_addAction;

[
    {format[localize "STR_JK_JK_LOADOUT",getText(configFile >> "CfgVehicles" >> typeOf (cursorTarget getVariable ["JK_Loadedin",[ObjNull]] select 0) >> "displayName"),getText(configFile >> "CfgVehicles" >> typeof cursorTarget >> "displayName")]},
    ["AllVehicles"],
    10,
    "isNull (player getVariable ['JK_DragDrop_Item', objNull]) && !((_target getVariable ['JK_Loadedin', []]) isEqualTo [])",
    {
        private ["_draggedObjectArray", "_draggedObject", "_attachPoint", "_item"];
        params ["_vehicle"];
        _draggedObjectArray = _vehicle getVariable ["JK_Loadedin",[ObjNull]];
        _draggedObject = _draggedObjectArray deleteAt 0;
        _currentWeight = _draggedObject call JK_Core_fnc_GetWeight;
        _vehicle setVariable ["JK_Loadedin",_draggedObjectArray,true];
        player setVariable ["JK_DragDrop_Item", _draggedObject, true];
        _draggedObject setVariable ["JK_DragDrop_Player", player, true];
        _attachPoint = [0, 1.3, 0.5];
        player forceWalk true;
        removeMissionEventHandler ["Draw3D",JK_var_GetInVehiclePFH];
        [[_draggedObject, true], "hideObjectGlobal", false, false, true] call BIS_fnc_MP;
        if (_draggedObject isKindOf "StaticWeapon" || _currentWeight >= __MAXWEIGHT /2) then {
            player playActionNow "grabDrag";
            waitUntil {animationState player in __DRAGANIMSTATE};
        } else {
            player action ["WeaponOnBack",player];
        };
        _draggedObject attachTo [player, _attachPoint];
        _draggedObject enableSimulationGlobal true;
        _draggedObject allowDamage true;
        _draggedObject setDamage 0;
    }
] call JK_Core_fnc_Interaction_addAction;
