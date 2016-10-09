#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Force respawn Action init

    Parameter(s):
    -

    Returns:
    -
*/

private _title = localize "STR_A3_ForceRespawn";
private _iconIdle = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_forceRespawn_ca.paa";
private _iconProgress = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_forceRespawn_ca.paa";
private _showCondition = {
    _target = PRA3_player;
    (_target getVariable [QGVAR(isUnconscious), false]) && ((_target getVariable [QGVAR(reviveAction), ""]) == "");
};

private _progressCondition = {
    (PRA3_player getVariable [QGVAR(isUnconscious), false]) && ((PRA3_player getVariable [QGVAR(reviveAction), ""]) == "")
};

GVAR(forceRespawnStartTime) = -1;
private _onStart = {
    params ["_target", "_caller"];

    _caller setVariable [QGVAR(forceRespawn), true, true];
    GVAR(forceRespawnStartTime) = time;
};

private _onProgress = {
    (time - GVAR(forceRespawnStartTime))/5;
};

private _onComplete = {
    params ["_target", "_caller"];

    _caller setVariable [QGVAR(forceRespawn), false, true];
    GVAR(forceRespawnStartTime) = -1;
    _caller setDamage 1;
};

private _onInterruption = {
    params ["_target", "_caller"];

    _caller setVariable [QGVAR(forceRespawn), false, true];
    GVAR(forceRespawnStartTime) = -1;
};


[PRA3_player, _title, _iconIdle, _iconProgress, _showCondition, _progressCondition, _onStart, _onProgress,_onComplete,_onInterruption, [], 5000, true, true, ["isNotUnconscious", "isNotInVehicle"]] call CFUNC(addHoldAction);
