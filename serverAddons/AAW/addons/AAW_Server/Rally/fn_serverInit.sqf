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
["RALLY", "onPlaced", {}] call EFUNC(Common,registerDeploymentPointTypeCallback);
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
["RALLY", "onSpawn", {}] call EFUNC(Common,registerDeploymentPointTypeCallback);
["RALLY", "onDestroy", {}] call EFUNC(Common,registerDeploymentPointTypeCallback);
["RALLY", "isAvailableFor", {}] call EFUNC(Common,registerDeploymentPointTypeCallback);
["RALLY", "isLocked", {}] call EFUNC(Common,registerDeploymentPointTypeCallback);

[{
    {
        private _pointDetails = [_x, ["type", "position", "availablefor"]] call EFUNC(Common,getDeploymentPointData);
        _pointDetails params ["_type", "_position", "_availableFor"];

        // For RPs only
        if (_type == "RALLY") then {
            if (isNull _availableFor || {((count (units _availableFor)) == 0)}) then {
                [_x] call EFUNC(Common,removeDeploymentPoint);
            };
        };
        nil
    } count (call EFUNC(Common,getAllDeploymentPoints));
}, 0.5] call CFUNC(addPerFrameHandler);
