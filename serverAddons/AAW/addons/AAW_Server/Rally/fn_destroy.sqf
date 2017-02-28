#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Destroy rally

    Parameter(s):
    None

    Returns:
    None
*/
params ["_group"];

private _pointId = _group getVariable [QGVAR(rallyId), ""];
if (_pointId == "") exitWith {};

[_pointId] call EFUNC(Common,removeDeploymentPoint);
_group setVariable [QGVAR(rallyId), nil, true];
