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
params ["_pointId", "_pointObjects"];

private _data = [_pointId, ["type"]] call FUNC(getDeploymentPointData);
[_data select 0, "onDestroy", _pointId, _pointObjects] call FUNC(callDeploymentPointCallback);
