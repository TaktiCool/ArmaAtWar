#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy

    Description:
    Heal Action init

    Parameter(s):
    -

    Returns:
    -
*/

private _iconIdle = "";
private _iconProgress = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa";
private _condition = {
    alive _target &&
    alive CLib_Player &&
    !(CLib_Player getVariable [QGVAR(isUnconscious), false]) &&
    !(_target getVariable [QGVAR(isUnconscious), false]) &&
    (_target distance CLib_Player < 3) &&
    (side group _target == side group CLib_Player)
};

GVAR(healStartTime) = -1;
GVAR(healDuration) = ([QGVAR(Settings_healActionDuration), 20] call CFUNC(getSetting)) * ([[QGVAR(Settings_healCoefficient), 20] call CFUNC(getSetting), 1] select (CLib_Player getVariable [QEGVAR(Kit,isMedic), false]));
private _onStart = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "HEAL", true];
    GVAR(healDuration) = ([QGVAR(Settings_healActionDuration), 20] call CFUNC(getSetting)) * ([[QGVAR(Settings_healCoefficient), 20] call CFUNC(getSetting), 1] select (CLib_Player getVariable [QEGVAR(Kit,isMedic), false]));
    GVAR(healStartTime) = time;

    CLib_Player playAction "medicStart";

};

private _onProgress = {
    CLib_Player playAction "medicStart";
    (time - GVAR(healStartTime)) / GVAR(healDuration);
};

private _onComplete = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "", true];

    if ("FirstAidKit" in items CLib_Player && !("Medikit" in items CLib_Player)) then {
        CLib_Player removeItem "FirstAidKit";
    };
    GVAR(healStartTime) = -1;
    [QGVAR(heal), _target, [CLib_Player getVariable [QEGVAR(Kit,isMedic), false]]] call CFUNC(targetEvent);

    CLib_Player playAction "medicStop";
};

private _onInterruption = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "", true];
    GVAR(healStartTime) = -1;
    CLib_Player switchAction "medicStop";
};

["VanillaAction", "HealSoldier", _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress,_onComplete,_onInterruption] call CFUNC(addHoldAction);
["VanillaAction", "HealSoldierSelf", _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress,_onComplete,_onInterruption] call CFUNC(addHoldAction);

[QGVAR(heal), {
    (_this select 0) params ["_isMedic"];
    if (_isMedic) then {
        CLib_Player setDamage 0;
        CLib_Player setVariable [QGVAR(bloodLevel), 1];
        CLib_Player setVariable [QGVAR(bleedingRate), 0];
    } else {
        private _oldDamage = +((getAllHitPointsDamage CLib_Player) select 2);
        CLib_Player setDamage 0.20;
        {
            CLib_Player setHitIndex [_forEachIndex, _x min 0.20];
        } forEach _oldDamage;

        //CLib_Player setVariable [QGVAR(bloodLevel), (CLib_Player getVariable [QGVAR(bloodLevel), 1]) max 0.5];
    };

}] call CFUNC(addEventhandler);
