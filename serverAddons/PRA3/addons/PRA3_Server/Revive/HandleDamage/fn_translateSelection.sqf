#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: Glowbal ported by joko // Jonas && BadGuy

    Description:
    Translate selection names into medical usable hit selection names.

    Parameter(s):
    0: Unit <Object>
    1: selection name <String>
    2: HitPoint Index/True to get hitpoint <Bool, Number>

    Returns:
    name of the selection <String>
*/

#define HEAD_SELECTIONS ["face_hub", "neck", "head"]
#define HEAD_HITPOINTS ["hitface", "hitneck", "hithead"]
#define TORSO_SELECTIONS ["pelvis", "spine1", "spine2", "spine3", "body"]
#define TORSO_HITPOINTS ["hitpelvis", "hitabdomen", "hitdiaphragm", "hitchest", "hitbody"]
#define L_ARM_SELECTIONS ["hand_l"]
#define L_ARM_HITPOINTS ["hitleftarm", "hand_l"]
#define R_ARM_SELECTIONS ["hand_r"]
#define R_ARM_HITPOINTS ["hitrightarm", "hand_r"]
#define L_LEG_SELECTIONS ["leg_l"]
#define L_LEG_HITPOINTS ["hitleftleg", "leg_l"]
#define R_LEG_SELECTIONS ["leg_r"]
#define R_LEG_HITPOINTS ["hitrightleg", "leg_r"]

params ["_unit", "_selectionName", "_hitPointIndex"];

if (_selectionName == "") exitWith {""};
if (_selectionName in HEAD_SELECTIONS) exitWith {"head"};
if (_selectionName in TORSO_SELECTIONS) exitWith {"body"};

//Backup method to detect weird selections/hitpoints
if (_selectionName == "?" || {!(_selectionName in GVAR(selections))}) exitWith {
    if (_hitPointIndex < 0) exitWith {"body"};

    private _hitPoint = toLower configName ((configProperties [(configFile >> "CfgVehicles" >> (typeOf _unit) >> "HitPoints")]) select _hitPointIndex);

    if (_hitPoint in HEAD_HITPOINTS) exitWith {"head"};
    if (_hitPoint in TORSO_HITPOINTS) exitWith {"body"};
    if (_hitPoint in L_ARM_HITPOINTS) exitWith {"hand_l"};
    if (_hitPoint in R_ARM_HITPOINTS) exitWith {"hand_r"};
    if (_hitPoint in L_LEG_HITPOINTS) exitWith {"leg_l"};
    if (_hitPoint in R_LEG_HITPOINTS) exitWith {"leg_r"};

    switch (_selectionName) do {
        case "legs": {selectRandom ["leg_r", "leg_l"]};
        case "arms": {selectRandom ["hand_l", "hand_r"]};
        case "hands": {selectRandom ["hand_l", "hand_r"]};
        default {"body"};
    };
};
