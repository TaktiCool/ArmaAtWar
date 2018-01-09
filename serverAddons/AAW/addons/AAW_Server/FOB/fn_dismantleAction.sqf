#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    Dismantle a FOB

    Parameter(s):
    None

    Returns:
    None
*/
private _title = "Dismantle";
private _iconIdle = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_forceRespawn_ca.paa";
private _iconProgress = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_forceRespawn_ca.paa";
private _showCondition = {
    scopeName "ActionCondition";
    {
        if ([_x, CLib_Player] call FUNC(canDismantle)) then {
            private _position = [_x, "position"] call MFUNC(getDeploymentPointData);
            if ([CLib_Player, _position, 1.55] call CFUNC(inFOV)) then {
                GVAR(currentFob) = _x;
                true breakOut "ActionCondition";
            };
        };
    } count (call MFUNC(getAllDeploymentPoints));
    false
};

GVAR(dismantleStartTime) = -1;
GVAR(currentFob) = "";
private _onStart = {

    GVAR(dismantleStartTime) = time;
};

private _onProgress = {
    (time - GVAR(dismantleStartTime)) / 10;
};

private _onComplete = {
    params ["_target"];
    [GVAR(currentFob)] call MFUNC(removeDeploymentPoint);
    GVAR(dismantleStartTime) = -1;
};

private _onInterruption = {

    GVAR(dismantleStartTime) = -1;
};

[CLib_Player, _title, _iconIdle, _iconProgress, _showCondition, _showCondition, _onStart, _onProgress, _onComplete, _onInterruption, [], 5000, true, true] call CFUNC(addHoldAction);
