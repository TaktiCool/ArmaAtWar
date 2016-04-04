#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    remove spawn point

    Parameter(s):
    0: ID <STRING>

    Returns:
    Id <STRING>
*/
params ["_pointId"];

GVAR(deploymentPoints) params ["_pointIds", "_pointData"];

private _index = _pointIds find _pointId;
_pointData deleteAt _index;
_pointIds deleteAt _index;

GVAR(deploymentPoints) set [0, _pointIds];
GVAR(deploymentPoints) set [1, _pointData];

publicVariable QGVAR(deploymentPoints);