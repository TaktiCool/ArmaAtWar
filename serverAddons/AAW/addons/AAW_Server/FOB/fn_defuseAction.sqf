#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Destroy a FOB

    Parameter(s):
    None

    Returns:
    None
*/
private _title = "Defuse";
private _iconIdle = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_forceRespawn_ca.paa";
private _iconProgress = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_forceRespawn_ca.paa";
private _showCondition = {
    scopeName "ActionCondition";
    {
        if ([_x, CLib_Player] call FUNC(canDefuse)) then {
            private _position = [_x, "position"] call MFUNC(getDeploymentPointData);
            if ([CLib_Player, _position, 1.55] call CFUNC(inFOV)) then {
                GVAR(currentFob) = _x;
                true breakOut "ActionCondition";
            };
        };
    } count (call MFUNC(getAllDeploymentPoints));
    false
};

GVAR(defuseStartTime) = -1;
GVAR(currentFob) = "";
private _onStart = {
    params ["_target", "_caller"];

    GVAR(defuseStartTime) = time;
    [QGVAR(stopDestroyTimer), [GVAR(currentFob)]] call CFUNC(serverEvent);
};

private _onProgress = {
    (time - GVAR(defuseStartTime)) / 5;
};

private _onComplete = {
    GVAR(defuseStartTime) = -1;
    [QGVAR(resetDestroyTimer), [GVAR(currentFob)]] call CFUNC(serverEvent);
};

private _onInterruption = {
    [QGVAR(continueDestroyTimer), [GVAR(currentFob)]] call CFUNC(serverEvent);
    GVAR(defuseStartTime) = -1;
};

[CLib_Player, _title, _iconIdle, _iconProgress, _showCondition, _showCondition, _onStart, _onProgress, _onComplete, _onInterruption, [], 5000, true, true] call CFUNC(addHoldAction);
