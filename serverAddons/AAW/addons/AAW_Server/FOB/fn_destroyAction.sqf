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
private _title = "Destroy FOB";
private _iconIdle = "\a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargoput_ca.paa";
private _iconProgress = "\a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargoput_ca.paa";
private _showCondition = {
    scopeName "ActionCondition";
    {
        if ([_x, CLib_Player] call FUNC(canDestroy)) then {
            private _position = [_x, "position"] call MFUNC(getDeploymentPointData);
            if ([CLib_Player, _position, 1.55] call CFUNC(inFOV)) then {
                GVAR(currentFob) = _x;
                true breakOut "ActionCondition";
            };
        };
    } count (call MFUNC(getAllDeploymentPoints));
    false
};

GVAR(destroyFOBStartTime) = -1;
GVAR(currentFob) = "";
private _onStart = {
    params ["_target", "_caller"];

    GVAR(destroyFOBStartTime) = time;
};

private _onProgress = {
    (time - GVAR(destroyFOBStartTime)) / 5;
};

private _onComplete = {
    params ["_target", "_caller"];

    GVAR(destroyFOBStartTime) = -1;
    [QGVAR(startDestroyTimer), [GVAR(currentFob)]] call CFUNC(serverEvent);
};

private _onInterruption = {
    params ["_target", "_caller"];

    GVAR(destroyFOBStartTime) = -1;
};

[CLib_Player, _title, _iconIdle, _iconProgress, _showCondition, _showCondition, _onStart, _onProgress, _onComplete, _onInterruption, [], 5000, true, true] call CFUNC(addHoldAction);
