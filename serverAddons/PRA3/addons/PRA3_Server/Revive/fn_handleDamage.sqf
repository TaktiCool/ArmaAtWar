#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Handle the Damage Eventhandler

    Parameter(s):
    Handle Damage Eventhandler Return

    Returns:
    0 or 1
*/
params ["_unit", "_selectionName", "_newDamage", "_source", "_projectile", "_hitPartIndex"];

if (!(alive _unit) || _newDamage == 0 || _unit != PRA3_Player) exitWith {0};

// Get the correct selection name
_selectionName = [_unit, _selectionName, _hitPartIndex] call FUNC(translateSelection);
private _selectionIndex = GVAR(selections) find _selectionName;

// Calculate the correct damage
private _damageCoefficients = [QGVAR(Settings_damageCoefficients), GVAR(selections) apply {1}] call CFUNC(getSetting);
_newDamage = _newDamage / (_damageCoefficients select _selectionIndex);

//@todo try to move this into unconscious hit effect
if (_unit getVariable [QGVAR(isUnconscious), false]) then {
    private _unconsciousDamageCoefficient = [QGVAR(Settings_unconsciousDamageCoefficient), 1] call CFUNC(getSetting);
    _newDamage = _newDamage * _unconsciousDamageCoefficient;
};

// Add the damage to the previous
private _maxDamage = [QGVAR(Settings_maxDamage), 3] call CFUNC(getSetting);
private _previousDamage = _unit getVariable [QGVAR(selectionDamage), GVAR(selections) apply {0}];
private _totalDamage = (_previousDamage select _selectionIndex) + _newDamage;
_previousDamage set [_selectionIndex, _totalDamage min _maxDamage];
[_unit, QGVAR(selectionDamage), _previousDamage] call CFUNC(setVariablePublic); // Use setVariablePublic to improve performance and not publish multiple times

// Broadcast to hit locally
[QGVAR(Hit), [_unit, _selectionName, _newDamage, _totalDamage]] call CFUNC(localEvent);

[0, 1] select (_selectionName in ["head", "body", ""] && _totalDamage >= _maxDamage)

/*
    Vanilla HandleDamage Calles
    ["HandleDamage",[B Alpha 1-2:1,"head",0,<NULL-object>,"B_65x39_Caseless",2]]
    ["HandleDamage",[B Alpha 1-2:1,"",0.421437,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",-1]]
    ["HandleDamage",[B Alpha 1-2:1,"",0.421437,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",-1]]
    ["HandleDamage",[B Alpha 1-2:1,"face_hub",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",0]]
    ["HandleDamage",[B Alpha 1-2:1,"neck",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",1]]
    ["HandleDamage",[B Alpha 1-2:1,"head",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",2]]
    ["HandleDamage",[B Alpha 1-2:1,"pelvis",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",3]]
    ["HandleDamage",[B Alpha 1-2:1,"spine1",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",4]]
    ["HandleDamage",[B Alpha 1-2:1,"spine2",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",5]]
    ["HandleDamage",[B Alpha 1-2:1,"spine3",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",6]]
    ["HandleDamage",[B Alpha 1-2:1,"body",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",7]]
    ["HandleDamage",[B Alpha 1-2:1,"arms",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",8]]
    ["HandleDamage",[B Alpha 1-2:1,"hands",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",9]]
    ["HandleDamage",[B Alpha 1-2:1,"legs",0.260238,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",10]]
*/
