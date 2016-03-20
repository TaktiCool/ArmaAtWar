#include "macros.hpp"

GVAR(SELECTIONS) = ["", "head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];
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

// Bleedout Timer
[FUNC(bleedoutTimer), 0] call CFUNC(addPerFrameHandler);

["UnconsciousnessChanged", {DUMP("UnconsciousnessChanged")}] call CFUNC(addEventhandler);

["killed", {
    if !(isNil QGVAR(PPEffects)) then {
        {
            _x ppEffectEnable false;
            nil
        } count GVAR(PPEffects);
    };
    PRA3_Player setVariable [QGVAR(bleedOutTime), 0, true];
    PRA3_Player setVariable [QGVAR(isUnconscious), false, true];
    ["UnconsciousnessChanged", [false, PRA3_Player]] call CFUNC(localEvent);
}] call CFUNC(addEventhandler);

PRA3_player addEventHandler ["handleDamage", FUNC(handleDamage)];

// disable Healing
PRA3_player addEventHandler ["HitPart", {0}];
PRA3_player addEventHandler ["Hit", {0}];
["playerChanged", {
    ((_this select 0) select 0) addEventHandler ["handleDamage", FUNC(handleDamage)];
    ((_this select 0) select 0) addEventHandler ["HitPart", {0}];
    ((_this select 0) select 0) addEventHandler ["Hit", {0}];
}] call CFUNC(addEventhandler);
