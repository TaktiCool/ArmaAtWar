#include "macros.hpp"
/*
    Arma At War

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
private _iconProgress = "\A3\Ui_f\data\IGUI\Cfg\Revive\overlayIcons\u100_ca.paa";
private _condition = {
    alive _target
     && alive CLib_Player
     && !(CLib_Player getVariable [QGVAR(isUnconscious), false])
     && (_target distance CLib_Player < 3)
     && (_target getVariable [QGVAR(isUnconscious),false])
     && (side group _target == side group CLib_Player)
};

GVAR(reviveDuration) = ([QGVAR(Settings_reviveActionDuration), 20] call CFUNC(getSetting)) * ([[QGVAR(Settings_reviveCoefficient), 20] call CFUNC(getSetting), 1] select (CLib_Player getVariable [QEGVAR(Kit,isMedic), false]));
GVAR(reviveStartTime) = 0;
private _onStart = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "REVIVE", true];
    GVAR(reviveStartTime) = time;
    GVAR(reviveDuration) = ([QGVAR(Settings_reviveActionDuration), 20] call CFUNC(getSetting)) * ([[QGVAR(Settings_reviveCoefficient), 20] call CFUNC(getSetting), 1] select (CLib_Player getVariable [QEGVAR(Kit,isMedic), false]));
    CLib_Player playAction "medicStart";
};

private _onProgress = {
    CLib_Player playAction "medicStart";
    (time - GVAR(reviveStartTime)) / GVAR(reviveDuration);
};

private _onComplete = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "", true];
    GVAR(reviveStartTime) = -1;

    if (_target getVariable [QGVAR(isUnconscious), false]) then {
        [QGVAR(revive), _target] call CFUNC(targetEvent);
    };
    CLib_Player playAction "medicStop";
};

private _onInterruption = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(reviveAction), "", true];
    GVAR(reviveStartTime) = -1;
    CLib_Player playActionNow "medicStop";
};


["CAManBase", _title, _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress,_onComplete,_onInterruption, [], 1000, true, false, ["isNotUnconscious"]] call CFUNC(addHoldAction);

[QGVAR(revive), {
    [false] call FUNC(setUnconscious);

    private _oldDamage = +((getAllHitPointsDamage CLib_Player) select 2);
    CLib_Player setDamage 0.75;
    {
        CLib_Player setHitIndex [_forEachIndex, _x min 0.75];
    } forEach _oldDamage;

    //CLib_Player setVariable [QGVAR(bloodLevel), (CLib_Player getVariable [QGVAR(bloodLevel), 1]) max 0.25];
    //CLib_Player setVariable [QGVAR(bleedingRate), 0];
}] call CFUNC(addEventhandler);
