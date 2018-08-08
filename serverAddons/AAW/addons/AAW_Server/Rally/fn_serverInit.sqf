#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, NetFusion

    Description:
    Server init for rally system

    Parameter(s):
    None

    Returns:
    None
*/

["RALLY", "onPrepare", {
    params ["_pointId", "", "_oldRet"];

    private _pointDetails = [_pointId, ["spawntickets", "availablefor"]] call EFUNC(Common,getDeploymentPointData);
    _pointDetails params [["_spawnTickets", -1], "_availableFor"];
    _spawnTickets = _spawnTickets - 1;

    if (_spawnTickets == 0) then {
        [_pointId] call EFUNC(Common,removeDeploymentPoint);
    } else {
        [_pointId, "spawntickets", _spawnTickets] call EFUNC(Common,setDeploymentPointData);
        [QGVAR(ticketsChanged), _availableFor] call CFUNC(targetEvent);
    };
    _oldRet
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["RALLY", "onPrepare", {
    params ["_pointId"];
    private _pointDetails = [_pointId, ["position"]] call EFUNC(Common,getDeploymentPointData);
    _pointDetails params [["_pos", [0,0,0]]];
    _pos;
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["RALLY", "isAvailableFor", {
    params ["_pointId", "_prevRet", "_target"];
    if (_target isEqualType objNull) then {
        _target = group _target;
    };
    private _side = [_pointId, "availableFor", 0] call EFUNC(Common,getDeploymentPointData);
    if (_target isEqualType sideUnknown) then {
        _side = side _side;
    };
    if (_side isEqualTo _target) exitWith {
        true;
    };
    _prevRet
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["RALLY", "isLocked", {
    params ["_pointId", "_prevRet"];
    if !(isNil "_prevRet") exitWith { _prevRet; };
    if ([_pointId, "spawnPointBlocked", 0] call EFUNC(Common,getDeploymentPointData) == 1) exitWith {
        false;
    };
    true;
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["RALLY", "onDeploy", {
    params ["_pointId", "_prevRet"];
    if !(isNil "_prevRet") exitWith { _prevRet; };
    if ([_pointId, "spawnPointBlocked", 0] call EFUNC(Common,getDeploymentPointData) == 1) exitWith {
        ["RESPAWN POINT BLOCKED!", "Too many enemies nearby!"] call EFUNC(Common,displayHint);
        false;
    };
    true;
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["RALLY", "onDestroy", {
    params ["_pointId", "_prevRet", "_pointObjects"];
    if !(isNil "_prevRet") exitWith { _prevRet; };
    _pointObjects call CFUNC(deleteSimpleObjectComp);
    true;
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

[{
    {
        private _pointDetails = [_x, ["type", "availablefor"]] call EFUNC(Common,getDeploymentPointData);
        _pointDetails params ["_type", "_availableFor"];

        // For RPs only
        if (_type == "RALLY") then {
            if (isNull _availableFor || {((count (units _availableFor)) == 0)}) then {
                [_x] call EFUNC(Common,removeDeploymentPoint);
            };
        };
        nil
    } count (call EFUNC(Common,getAllDeploymentPoints));
}, 0.5] call CFUNC(addPerFrameHandler);
