#include "macros.hpp"
/*
    Project Reality ArmA 3

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
    !(_target getVariable [QGVAR(isUnconscious), false]) &&
    (_target distance PRA3_player < 3) &&
    (side group _target == side group PRA3_player)
};

GVAR(healStartTime) = -1;
GVAR(healDuration) = ([QGVAR(Settings_healActionDuration), 20] call CFUNC(getSetting)) * ([[QGVAR(Settings_healCoefficient), 20] call CFUNC(getSetting), 1] select (PRA3_player getVariable [QEGVAR(Kit,isMedic), false]));
private _onStart = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "HEAL", true];
    GVAR(healDuration) = ([QGVAR(Settings_healActionDuration), 20] call CFUNC(getSetting)) * ([[QGVAR(Settings_healCoefficient), 20] call CFUNC(getSetting), 1] select (PRA3_player getVariable [QEGVAR(Kit,isMedic), false]));
    GVAR(healStartTime) = time;

    PRA3_player playAction "medicStart";

};

private _onProgress = {
    PRA3_player playAction "medicStart";
    (time - GVAR(healStartTime)) / GVAR(healDuration);
};

private _onComplete = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "", true];

    if ("FirstAidKit" in items PRA3_player && !("Medikit" in items PRA3_player)) then {
        PRA3_player removeItem "FirstAidKit";
    };
    GVAR(healStartTime) = -1;
    [QGVAR(heal), _target, [PRA3_player getVariable [QEGVAR(Kit,isMedic), false]]] call CFUNC(targetEvent);


    PRA3_player playAction "medicStop";
};

private _onInterruption = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "", true];
    GVAR(healStartTime) = -1;
    PRA3_player switchAction "medicStop";
};

["VanillaAction", "HealSoldier", _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress,_onComplete,_onInterruption] call CFUNC(addHoldAction);
["VanillaAction", "HealSoldierSelf", _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress,_onComplete,_onInterruption] call CFUNC(addHoldAction);

[QGVAR(heal), {
    (_this select 0) params ["_isMedic"];
    if (_isMedic) then {
        PRA3_player setDamage 0;
        PRA3_player setVariable [QGVAR(bloodLevel), 1];
    } else {
        private _oldDamage = +((getAllHitPointsDamage PRA3_player) select 2);
        PRA3_player setDamage 0.20;
        {
            PRA3_player setHitIndex [_forEachIndex, _x min 0.20];
        } forEach _oldDamage;

        PRA3_player setVariable [QGVAR(bloodLevel), (PRA3_player getVariable [QGVAR(bloodLevel), 1]) max 0.5];
    };

}] call CFUNC(addEventhandler);
