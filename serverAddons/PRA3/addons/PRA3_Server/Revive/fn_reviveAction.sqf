#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Initialize the Revive Action

    Parameter(s):
    -

    Returns:
    -
*/

private _title = localize "STR_A3_Revive";
private _iconIdle = "\A3\Ui_f\data\IGUI\Cfg\Revive\overlayIcons\u100_ca.paa";
private _iconProgress = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa";
private _condition = {
    alive _target &&
    (_target distance PRA3_player < 3) &&
    (_target getVariable [QGVAR(isUnconscious),false]) &&
    (side group _target == side group PRA3_player)
};

GVAR(reviveDuration) = ([QGVAR(Settings_reviveActionDuration), 20] call CFUNC(getSetting)) * ([[QGVAR(Settings_reviveCoefficient), 20] call CFUNC(getSetting), 1] select (PRA3_player getVariable [QEGVAR(Kit,isMedic), false]));
GVAR(reviveStartTime) = 0;
private _onStart = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "REVIVE", true];
    GVAR(reviveStartTime) = time;
    GVAR(reviveDuration) = ([QGVAR(Settings_reviveActionDuration), 20] call CFUNC(getSetting)) * ([[QGVAR(Settings_reviveCoefficient), 20] call CFUNC(getSetting), 1] select (PRA3_player getVariable [QEGVAR(Kit,isMedic), false]));
    PRA3_player playAction "medicStart";
};

private _onProgress = {
    PRA3_player playAction "medicStart";
    (time - GVAR(reviveStartTime)) / GVAR(reviveDuration);
};

private _onComplete = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "", true];
    GVAR(reviveStartTime) = -1;

    if (_target getVariable [QGVAR(isUnconscious), false]) then {
        [QGVAR(revive), _target] call CFUNC(targetEvent);
    };
    PRA3_player playAction "medicStop";
};

private _onInterruption = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "", true];
    GVAR(reviveStartTime) = -1;
    PRA3_player playActionNow "medicStop";
};


["CAManBase", _title, _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress,_onComplete,_onInterruption, [], 1000, true, false, ["isNotUnconscious"]] call CFUNC(addHoldAction);

[QGVAR(revive), {
    [false] call FUNC(setUnconscious);

    private _oldDamage = +((getAllHitPointsDamage PRA3_player) select 2);
    PRA3_player setDamage 0.75;
    {
        PRA3_player setHitIndex [_forEachIndex, _x min 0.75];
    } forEach _oldDamage;

    PRA3_player setVariable [QGVAR(bloodLevel), (PRA3_player getVariable [QGVAR(bloodLevel), 1]) max 0.25];
    PRA3_player setVariable [QGVAR(bleedingRate), 0];
}] call CFUNC(addEventhandler);
