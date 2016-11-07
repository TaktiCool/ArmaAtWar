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
private _title = "Defuse";
private _iconIdle = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_forceRespawn_ca.paa";
private _iconProgress = "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_forceRespawn_ca.paa";
private _showCondition = {
    call {
        _target = CLib_Player;
        scopeName "ActionCondition";
        private _cond = false;
        {
            private _pointDetails = EGVAR(Common,DeploymentPointStorage) getVariable _x;
            if (!(isNil "_pointDetails")) then {
                _pointDetails params ["_name", "_type", "_position", "_availableFor", "_spawnTickets", "_icon", ["_mapIcon", ""], ["_pointObjects", []], ["_customData", []]];

                _customData params [["_counterActive", 0]];

                if (_type == "FOB" && {CLib_Player distance _position <= 5 && _counterActive == 1 && _availableFor == side group CLib_Player}) then {
                    GVAR(currentFob) = format ["%1_%2", _name, _position];;
                    _cond = true;
                    breakTo "ActionCondition";
                };
            };
        } count ([EGVAR(Common,DeploymentPointStorage), QEGVAR(Common,DeploymentPointStorage)] call CFUNC(allVariables));
        _cond;
    };
};

GVAR(defuseStartTime) = -1;
GVAR(currentFob) = [];
private _onStart = {
    params ["_target", "_caller"];

    _caller setVariable [QGVAR(forceRespawn), true, true];
    GVAR(defuseStartTime) = time;
};

private _onProgress = {
    (time - GVAR(defuseStartTime))/5;
};

private _onComplete = {
    params ["_target", "_caller"];

    GVAR(defuseStartTime) = -1;
    [QGVAR(stopDestroyTimer), [GVAR(currentFob)]] call CFUNC(serverEvent);
};

private _onInterruption = {
    params ["_target", "_caller"];

    GVAR(forceRespawnStartTime) = -1;
};


[CLib_Player, _title, _iconIdle, _iconProgress, _showCondition, _showCondition, _onStart, _onProgress,_onComplete,_onInterruption, [], 5000, true, true] call CFUNC(addHoldAction);
