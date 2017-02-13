#include "macros.hpp"
/*
    Arma At War

    Author: NetFusion

    Description:
    Destroy rally

    Parameter(s):
    0: Group <Group> (Default: grpNull)

    Returns:
    None
*/

params [
    ["_group", grpNull, [grpNull]]
];

private _pointId = _group getVariable [QGVAR(rallyId), ""];
if (_pointId == "") exitWith {};

[_pointId] call EFUNC(Common,removeDeploymentPoint);
_group setVariable [QGVAR(rallyId), nil, true];
