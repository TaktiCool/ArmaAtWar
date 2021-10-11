#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Prepares to spawn at a point

    Parameter(s):
    0: Id <STRING>

    Returns:
    None
*/
params ["_deployPosition", "_pointId"];

// Spawn
[_deployPosition] call FUNC(respawn);

[{
    private _data = [_this, ["type"]] call FUNC(getDeploymentPointData);
    [_data select 0, "onSpawn", _this, CLib_Player] call FUNC(callDeploymentPointCallback);

}, _pointId] call CFUNC(execNextFrame);
