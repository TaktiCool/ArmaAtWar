#include "macros.hpp"

GVAR(SELECTIONS) = ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];
GVAR(lastDamageSelection) = [0,0,0,0,0,0];
private _cfg = missionConfigFile >> "PRA3" >> "CfgRevive";
GVAR(reviveBleedingTime) = getNumber (_cfg >> "reviveBleedingTime");
GVAR(reviveBleedOutTime) = getNumber (_cfg >> "reviveBleedOutTime");
/*
 * Author: Glowbal ported by joko // Jonas && BadGuy
 * Translate selection names into medical usable hit selection names.
 * 0: Unit <OBJECT>
 * 1: selection name <STRING>
 * 2: HitPoint Index/True to get hitpoint <NUMBER><BOOL>
*/
DFUNC(translateSelections) = {
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

    params ["_unit", "_selection", "_hitPointIndex"];

    if (_selection == "") exitWith {""};

    //Get Selection from standard selection ["head","body","hand_l","hand_r","leg_l","leg_r"]
    if (_hitPointIndex isEqualTo true) exitWith {
        private _returnHitPoint = GVAR(HITPOINTS) select (GVAR(SELECTIONS) find _selection);
        //If the selection is a valid hitpoint just return it:
        if (!isNil {_unit getHitPointDamage _returnHitPoint}) exitWith {
            _returnHitPoint;
        };

        //Those VR fuckers have weird limb hitpoints
        private _hitPoints = switch (_selection) do {
            case ("hand_l"): {L_ARM_HITPOINTS};
            case ("hand_r"): {R_ARM_HITPOINTS};
            case ("leg_l"): {L_LEG_HITPOINTS};
            case ("leg_r"): {R_LEG_HITPOINTS};
            case ("head"): {HEAD_HITPOINTS};
            case ("body"): {TORSO_HITPOINTS};
            default {[]};
        };
        {
            if (!isNil {_unit getHitPointDamage _x}) exitWith {
                _returnHitPoint = _x;
            };
        } forEach _hitPoints;
        _returnHitPoint
    };

    //Get Selection from Selection/HitIndex:

    if (_selection in HEAD_SELECTIONS) exitWith {"head"};
    if (_selection in TORSO_SELECTIONS) exitWith {"body"};

    // Not necessary unless we get more hitpoints variants in an next arma update
    /*if (_selection in L_ARM_SELECTIONS) exitWith {"hand_l"};
    if (_selection in R_ARM_SELECTIONS) exitWith {"hand_r"};
    if (_selection in L_LEG_SELECTIONS) exitWith {"leg_l"};
    if (_selection in R_LEG_SELECTIONS) exitWith {"leg_r"};*/

    //Backup method to detect weird selections/hitpoints
    if ((_selection == "?") || {!(_selection in GVAR(SELECTIONS))}) exitWith {
        if (_hitPointIndex < 0) exitWith {_selection};
        private _hitPoint = toLower configName ((configProperties [(configFile >> "CfgVehicles" >> (typeOf _unit) >> "HitPoints")]) select _hitPointIndex);
        DUMP("Weird sel/hit"+ str(_unit) + " " + str(_selection) + " " + str(_hitPointIndex) + " " + str(_hitPoint));

        if (_hitPoint in HEAD_HITPOINTS) exitWith {"head"};
        if (_hitPoint in TORSO_HITPOINTS) exitWith {"body"};
        if (_hitPoint in L_ARM_HITPOINTS) exitWith {"hand_l"};
        if (_hitPoint in R_ARM_HITPOINTS) exitWith {"hand_r"};
        if (_hitPoint in L_LEG_HITPOINTS) exitWith {"leg_l"};
        if (_hitPoint in R_LEG_HITPOINTS) exitWith {"leg_r"};

        _selection
    };

    _selection;
};

// Bleedout Timer
[{
    if (PRA3_player getVariable [QGVAR(medicalActionIsInProgress), false]) exitWith {};
    private _bloodLoss = PRA3_Player getVariable [QGVAR(bloodLoss), 0];
    if (_bloodLoss == 0) exitWith {};
    private _bleedOutTime = PRA3_Player getVariable [QGVAR(bleedOutTime), 0];

    _bleedOutTime = _bleedOutTime + ((_bloodLoss * CGVAR(deltaTime)) * 2);

    [PRA3_Player, QGVAR(bleedOutTime), _bleedOutTime] call CFUNC(setVariablePublic);

    // if Player is Uncon check if maxBleedoutTime is reached and than force the player to respawn
    if (PRA3_Player getVariable [QGVAR(isUnconscious), false]) then {
        if (_bleedOutTime >= GVAR(reviveBleedOutTime)) then {
            // Force Player to Respawn
            PRA3_Player setDamage 1;
            PRA3_Player setVariable [QGVAR(bleedOutTime), 0, true];
            PRA3_Player setVariable [QGVAR(isUnconscious), false, true];
            ["UnconsciousnessChanged", [false, PRA3_Player]] call CFUNC(localEvent);
        };
    } else {
        // if Player is not Uncon chech if maxBleedingTime is reach and than toggle Uncon
        if (_bleedOutTime >= GVAR(reviveBleedingTime)) then {
            PRA3_Player setVariable [QGVAR(bleedOutTime), 0, true];
            PRA3_Player setVariable [QGVAR(isUnconscious), false, true];
            ["UnconsciousnessChanged", [false, PRA3_Player]] call CFUNC(localEvent);
        };
    };
}, 0] call CFUNC(addPerFrameHandler);

DFUNC(HandleDamage) = {
    params ["_unit", "_selectionName", "_damage", "_source", "_projectile", "_hitPartIndex"];
    _selectionName = [_unit, _selectionName, _hitPartIndex] call FUNC(translateSelections);

    private _newDamage = _damage - (GVAR(lastDamageSelection) select GVAR(SELECTIONS) find _selectionName);

    if (_newDamage > 0.3) then {
        private _bloodLoss = _unit getVariable [QGVAR(bloodLoss), 0];
        _bloodLoss = _bloodLoss + _newDamage;
        _unit setVariable [QGVAR(bloodLoss), _bloodLoss];
    };

    if (_selectionName in ["head", "body", ""]) then {
        if (_damage > 0.9) then {
            _damage = 0.9;
            [{
                if !(_this getVariable [QGVAR(isUnconscious), false]) then {
                    _this setVariable [QGVAR(isUnconscious), true, true];
                    ["UnconsciousnessChanged", [true, _this]] call CFUNC(localEvent);
                };
            }, _unit] call CFUNC(execNextFrame);
        };
    };


    GVAR(lastDamageSelection) set [GVAR(SELECTIONS) find _selectionName, _damage];
    _damage;
};

["UnconsciousnessChanged", {DUMP("UnconsciousnessChanged")}] call CFUNC(addEventhandler);


// Client Init
PRA3_player addEventHandler ["handleDamage", DFUNC(HandleDamage)];
["playerChanged", {PRA3_player addEventHandler ["handleDamage", DFUNC(HandleDamage)];}] call CFUNC(addEventhandler);

/*
Vanilla HandleDamage Calles
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"head",0,<NULL-object>,"B_65x39_Caseless",2]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"",0.421437,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",-1]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"",0.421437,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",-1]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"face_hub",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",0]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"neck",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",1]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"head",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",2]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"pelvis",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",3]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"spine1",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",4]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"spine2",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",5]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"spine3",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",6]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"body",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",7]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"arms",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",8]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"hands",0,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",9]]
2:53:46 ["HandleDamage",[B Alpha 1-2:1,"legs",0.260238,B Alpha 1-1:1 (jokoho482),"B_65x39_Caseless",10]]
*/

/*
Animations:
    // GetDown Anims
    Incapacitated
    IncapacitatedPistol
    IncapacitatedRifle
    BasicDriverDying
    BasicDriverOutDying
    Unconscious

    // Translations Back to Front Rolling
    AinjPpneMstpSnonWnonDnon_rolltoback
    AinjPpneMstpSnonWnonDnon_rolltofront

    // Laydown Pose
    AinjPpneMstpSnonWnonDnon
    AinjPpneMstpSnonWnonDnon_injuredHealed
    Mk201_Dead
    Mk34_Dead
    Mortar_01_F_Dead
    Static_Dead
    Helper_InjuredRfl
*/
