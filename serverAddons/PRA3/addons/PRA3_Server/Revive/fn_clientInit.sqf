#include "macros.hpp"

GVAR(SELECTIONS) = ["", "head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];
private _cfg = missionConfigFile >> "PRA3" >> "CfgRevive";

// bleedout Timer Variables
GVAR(reviveBleedingTime) = getNumber (_cfg >> "reviveBleedingTime");
GVAR(reviveBleedOutTime) = getNumber (_cfg >> "reviveBleedOutTime");

// Actions Varaibles
// - Heal
GVAR(healingTime) = getNumber (_cfg >> "healingTime");
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
GVAR(preventInstantDeath) = getNumber (_cfg >> "preventInstantDeath") isEqualTo 1;
GVAR(maxDamage) = getNumber (_cfg >> "maxDamage");

GVAR(currentHealers) = [];
GVAR(healingPFH) = -1;

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
    [_this, QGVAR(HealingProgress), 0] call CFUNC(setVariablePublic);
    [_this, QGVAR(HealingRate), 0] call CFUNC(setVariablePublic);
    [_this, QGVAR(HealingTimestamp), -1] call CFUNC(setVariablePublic);
};

DFUNC(updateHealingStatus) = {
    private _damageSelection = PRA3_Player getVariable QGVAR(DamageSelection);
    private _maxDamage = 0;
    {
        if (_x > _maxDamage) then {
            _maxDamage = _x;
        };
        nil;
    } count _damageSelection;

    private _healingRate = 0;
    {
        private _healingTime = GVAR(healingTime);
        if !(_x getVariable [QGVAR(isMedic), false]) then {
            _healingTime = _healingTime * GVAR(healCoef);
        };
        _healingRate = _healingRate + 1 / _healingTime;

        nil;
    } count GVAR(currentHealers);

    private _healingProgress = 1 - _maxDamage / GVAR(maxDamage);

    PRA3_Player setVariable [QGVAR(healingProgress), _healingProgress, true];
    PRA3_Player setVariable [QGVAR(healingRate), _healingRate, true];
    PRA3_Player setVariable [QGVAR(healingTimestamp), serverTime, true];
};

// Bleedout Timer
[FUNC(bleedoutTimer), 0] call CFUNC(addPerFrameHandler);

["healUnit", {
    [PRA3_Player, QGVAR(DamageSelection), [0,0,0,0,0,0,0]] call CFUNC(setVariablePublic);
}] call CFUNC(addEventhandler);

["unregisterHealer", {
    (_this select 0) params ["_healer"];

    if (_healer in GVAR(currentHealers)) then {
        private _index = GVAR(currentHealers) find _healer;
        GVAR(currentHealers) deleteAt _index;
    };

    call DFUNC(updateHealingStatus);
}] call CFUNC(addEventhandler);

["registerHealer", {
    (_this select 0) params ["_healer"];
    GVAR(currentHealers) pushBackUnique _healer;

    call DFUNC(updateHealingStatus);

    if (GVAR(healingPFH) < 0) then {
        GVAR(healingPFH) = [{

            if (objNull in GVAR(currentHealers)) then {
                GVAR(currentHealers) = GVAR(currentHealers) select {!isNull _x};
            };

            private _damageSelection = PRA3_Player getVariable QGVAR(DamageSelection);
            private _lastTimestamp = PRA3_Player getVariable [QGVAR(healingTimestamp),-1];

            if (_lastTimestamp < 0) exitWith {};

            private _healingRate = PRA3_Player getVariable [QGVAR(healingRate),-1];
            private _maxDamage = 0;
            {
                if (_x > _maxDamage) then {
                    _maxDamage = _x;
                };
                nil;
            } count _damageSelection;

            if ((serverTime - _lastTimestamp) <= 0) exitWith {};

            _maxDamage = _maxDamage - (serverTime - _lastTimestamp) * _healingRate * GVAR(maxDamage);

            _maxDamage = _maxDamage max 0;

            _damageSelection = _damageSelection apply {
                [_x, _maxDamage] select (_x > _maxDamage);
            };

            DUMP(_damageSelection)
            private _temp = 1 - _maxDamage / GVAR(maxDamage);
            DUMP(_temp)

            [PRA3_Player, QGVAR(DamageSelection), _damageSelection] call CFUNC(setVariablePublic);

            if (_maxDamage < 0.7) then {
                PRA3_Player forceWalk false;
            };

            if (count GVAR(currentHealers) == 0 || _maxDamage == 0) exitWith {
                GVAR(healingPFH) = -1;
                PRA3_Player setVariable [QGVAR(healingProgress), 1 - _maxDamage / GVAR(maxDamage), true];
                PRA3_Player setVariable [QGVAR(healingRate), 0, true];
                PRA3_Player setVariable [QGVAR(healingTimestamp), serverTime, true];
                [_this select 1] call CFUNC(removePerFrameHandler);
            };
            PRA3_Player setVariable [QGVAR(healingProgress), 1 - _maxDamage / GVAR(maxDamage)];
            PRA3_Player setVariable [QGVAR(healingTimestamp), serverTime];



        }, 0.1, []] call CFUNC(addPerFrameHandler);
    };

}] call CFUNC(addEventhandler);

["stopBleeding", {
    [PRA3_Player, QGVAR(bloodLoss), 0] call CFUNC(setVariablePublic);
}] call CFUNC(addEventhandler);

["UnconsciousnessChanged", {DUMP("UnconsciousnessChanged")}] call CFUNC(addEventhandler);

["Killed", {
    PRA3_Player call FUNC(resetMedicalVars);
    call FUNC(resetPPEffects);
    ["UnconsciousnessChanged", [false, PRA3_Player]] call CFUNC(localEvent);
}] call CFUNC(addEventhandler);

["Respawn", {
    (_this select 0) select 0 call FUNC(resetMedicalVars);
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
