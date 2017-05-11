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
    call {
        _target = CLib_Player;
        scopeName "ActionCondition";
        {
            private _pointDetails = [_x, ["name", "type", "position", "availablefor"]] call EFUNC(Common,getDeploymentPointData);
            _pointDetails params ["_name", "_type", "_position", "_availableFor"];

            private _counterActive = [_x, "counterActive", 0] call EFUNC(Common,getDeploymentPointData);

            if (_type == "FOB" && {CLib_Player distance _position <= 5 && _counterActive == 0 && _availableFor == side group CLib_Player}) then {
                GVAR(currentFob) = _x;
                true breakOut "ActionCondition";
            };
        } count ([EGVAR(Common,DeploymentPointStorage), QEGVAR(Common,DeploymentPointStorage)] call CFUNC(allVariables));
        false
    };
};

GVAR(dismantleStartTime) = -1;
GVAR(currentFob) = "";
private _onStart = {
    params ["_target", "_caller"];

    GVAR(dismantleStartTime) = time;
};

private _onProgress = {
    (time - GVAR(dismantleStartTime)) / 10;
};

private _onComplete = {
    params ["_target"];
    [GVAR(currentFob)] call EFUNC(Common,removeDeploymentPoint);
    GVAR(dismantleStartTime) = -1;
};

private _onInterruption = {

    GVAR(dismantleStartTime) = -1;
};

[CLib_Player, _title, _iconIdle, _iconProgress, _showCondition, _showCondition, _onStart, _onProgress, _onComplete, _onInterruption, [], 5000, true, true] call CFUNC(addHoldAction);
