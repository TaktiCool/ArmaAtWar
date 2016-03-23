#include "macros.hpp"

GVAR(SELECTIONS) = ["", "head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];
private _cfg = missionConfigFile >> "PRA3" >> "CfgRevive";

// bleedout Timer Variables
GVAR(reviveBleedingTime) = getNumber (_cfg >> "reviveBleedingTime");
GVAR(reviveBleedOutTime) = getNumber (_cfg >> "reviveBleedOutTime");

// Actions Varaibles
// - Heal
GVAR(healSpeed) = getNumber (_cfg >> "healSpeed");
GVAR(healCoef) = getNumber (_cfg >> "healCoef");
GVAR(maxHeal) = getNumber (_cfg >> "maxHeal");
// - Revive
GVAR(reviveSpeed) = getNumber (_cfg >> "reviveSpeed");
GVAR(reviveCoef) = getNumber (_cfg >> "reviveCoef");
// - Bandage
GVAR(bandageSpeed) = getNumber (_cfg >> "bandageSpeed");
GVAR(bandageCoef) = getNumber (_cfg >> "bandageCoef");

// Damage Coefs
GVAR(unconBleedCoef) = getNumber (_cfg >> "unconBleedCoef");
GVAR(bleedCoef) = getNumber (_cfg >> "bleedCoef");
GVAR(damageCoef) = getArray (_cfg >> "damageCoef");

// Damage Values
GVAR(preventInstandDeath) = getNumber (_cfg >> "preventInstandDeath") == 1;
GVAR(maxDamage) = getArray (_cfg >> "maxDamage");

DFUNC(resetPPEffects) = {
    if !(isNil QGVAR(PPEffects)) then {
        {
            _x ppEffectEnable false;
            nil
        } count GVAR(PPEffects);
    };

    if !(isNil QGVAR(ppEffectPFHID)) then {
        [GVAR(ppEffectPFHID)] call CFUNC(removePerFrameHandler);
        GVAR(ppEffectPFHID) = nil;
    };
};

DFUNC(resetMedicalVars) = {
    _this setVariable [QGVAR(bleedOutTime), 0, true];
    _this setVariable [QGVAR(isUnconscious), false, true];
    [_this, QGVAR(DamageSelection), [0,0,0,0,0,0,0]] call CFUNC(setVariablePublic);
    [_this, QGVAR(bloodLoss), 0] call CFUNC(setVariablePublic);
};

// Bleedout Timer
[FUNC(bleedoutTimer), 0] call CFUNC(addPerFrameHandler);

["UnconsciousnessChanged", {DUMP("UnconsciousnessChanged")}] call CFUNC(addEventhandler);

["respawn", {
    (_this select 0) select 0call FUNC(resetMedicalVars);
    call FUNC(resetPPEffects);
    ["UnconsciousnessChanged", [false, PRA3_Player]] call CFUNC(localEvent);
}] call CFUNC(addEventhandler);

PRA3_player addEventHandler ["handleDamage", FUNC(handleDamage)];

// disable Healing
PRA3_player addEventHandler ["HitPart", {0}];
PRA3_player addEventHandler ["Hit", {0}];

// reset all Eventhandler on player Changed Event
["playerChanged", {
    ((_this select 0) select 0) addEventHandler ["handleDamage", FUNC(handleDamage)];
    ((_this select 0) select 0) addEventHandler ["HitPart", {0}];
    ((_this select 0) select 0) addEventHandler ["Hit", {0}];
}] call CFUNC(addEventhandler);
