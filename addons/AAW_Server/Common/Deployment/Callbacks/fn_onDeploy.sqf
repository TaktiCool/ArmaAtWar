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
params ["_pointId"];

private _data = [_pointId, ["type"]] call FUNC(getDeploymentPointData);
[_data select 0, "onDeploy", _pointId] call FUNC(callDeploymentPointCallback);
