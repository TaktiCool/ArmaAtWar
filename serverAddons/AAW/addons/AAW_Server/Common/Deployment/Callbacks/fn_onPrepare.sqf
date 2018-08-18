#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Prepares to spawn at a point

    Parameter(s):
    0: Id <STRING>

    Returns:
    Position <POSITION>
*/
params ["_pointId"];

private _data = [_pointId, ["type"]] call FUNC(getDeploymentPointData);
[_data select 0, "onPrepare", _pointId] call FUNC(callDeploymentPointCallback);
