#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Destroy a FOB

    Parameter(s):
    None

    Returns:
    None
*/
private _title = "Destroy FOB";
private _iconIdle = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_forceRespawn_ca.paa";
private _iconProgress = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_forceRespawn_ca.paa";
private _showCondition = {
    call {
        _target = CLib_Player;
        scopeName "ActionCondition";
        private _cond = false;
        {
            private _pointDetails = GVAR(DeploymentPointStorage) getVariable _x;
            if (!(isNil "_pointDetails")) then {
                _pointDetails params ["_name", "_position", "_availableFor", "_spawnTickets", "_icon", ["_mapIcon", ""], ["_pointObjects", []], ["_destroyFOBPFH", -1]];

                if (CLib_Player distance _position <= 5 && _destroyFOBPFH < 0) then {
                    GVAR(currentFob) = _pointDetails;
                    _cond = true;
                    breakTo "ActionCondition";
                };
            };
        } count ([GVAR(DeploymentPointStorage), QGVAR(DeploymentPointStorage)] call CFUNC(allVariables));
        _cond;
    };
};

GVAR(destroyFOBStartTime) = -1;
GVAR(currentFob) = [];
private _onStart = {
    params ["_target", "_caller"];

    _caller setVariable [QGVAR(forceRespawn), true, true];
    GVAR(destroyFOBStartTime) = time;
};

private _onProgress = {
    (time - GVAR(destroyFOBStartTime))/5;
};

private _onComplete = {
    params ["_target", "_caller"];

    GVAR(destroyFOBStartTime) = -1;
    GVAR(currentFob) params ["_name", "_position", "_availableFor", "_spawnTickets", "_icon", ["_mapIcon", ""], ["_pointObjects", []], ["_destroyFOBPFH", -1]];

    



};

private _onInterruption = {
    params ["_target", "_caller"];

    GVAR(forceRespawnStartTime) = -1;
};


[CLib_Player, _title, _iconIdle, _iconProgress, _showCondition, _showCondition, _onStart, _onProgress,_onComplete,_onInterruption, [], 5000, true, true] call CFUNC(addHoldAction);
