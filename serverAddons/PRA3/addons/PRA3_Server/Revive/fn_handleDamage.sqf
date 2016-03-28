#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Handle the Damage Eventhandler

    Parameter(s):
    Handle Damage Eventhandler Return

    Returns:
    0
*/
params ["_unit", "_selectionName", "_damage", "_source", "_projectile", "_hitPartIndex"];
if (!(alive _unit) || (_damage == 0)) exitWith {0};

_selectionName = [_unit, _selectionName, _hitPartIndex] call FUNC(translateSelections);
private _selectionIndex = GVAR(SELECTIONS) find _selectionName;

// fixes issue with Various Mods that not have standart selection Names
if (_selectionIndex == -1) then {
    _selectionName = "body";
    _selectionIndex = GVAR(SELECTIONS) find _selectionName;
};

private _allDamage = _unit getVariable [QGVAR(DamageSelection),[0,0,0,0,0,0,0]];
_damage = (_allDamage select _selectionIndex) + (_damage / (GVAR(damageCoef) select _selectionIndex));
private _newDamage = _damage - (_allDamage select _selectionIndex);
_allDamage set [_selectionIndex, _damage];


if (_selectionName != "" && _newDamage > 0.2) then {
    private _bloodLoss = _unit getVariable [QGVAR(bloodLoss), 0];

    _bloodLoss = _bloodLoss + (_newDamage * ([GVAR(bleedCoef), GVAR(unconBleedCoef)] select (_unit getVariable [QGVAR(isUnconscious), false])));

    [_newDamage] call FUNC(bloodEffect);
    [_unit, QGVAR(bloodLoss), _bloodLoss] call CFUNC(setVariablePublic);
};

if (_selectionName in ["head", "body", ""]) then {

    if (!GVAR(preventInstandDeath) && {_newDamage >= GVAR(maxDamage)}) then {
        forceRespawn _unit;
    } else {
        if (_damage >= GVAR(maxDamage)) then {
            [{
                if !(_this getVariable [QGVAR(isUnconscious), false]) then {
                    ["UnconsciousnessChanged", [true, _this]] call CFUNC(localEvent);
                };
            }, _unit] call CFUNC(execNextFrame);
        };
    };
};

// @todo replace with Fatigue Framework
if (_selectionName in ["leg_l", "leg_r"] && _damage > 0.7) then {
    if !(isForcedWalk _unit) then {
        _unit forceWalk true;
    };
};

// use setVariablePublic to Improve performance and not publish multible times the damage variable
[PRA3_Player, QGVAR(DamageSelection), _allDamage] call CFUNC(setVariablePublic);

0

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
