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
params ["_pointId", "_target"];

private _data = [_pointId, ["type"]] call FUNC(getDeploymentPointData);
[_data select 0, "isAvailableFor", _pointId, _target] call FUNC(callDeploymentPointCallback);
