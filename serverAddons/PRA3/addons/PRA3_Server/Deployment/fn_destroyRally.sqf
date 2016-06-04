#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    detroy rally

    Parameter(s):
    None

    Returns:
    None
*/
params ["_group"];

GVAR(deploymentPoints) params ["_pointIds", "_pointData"];
private _pointId = _group getVariable [QGVAR(rallyId), ""];
if (_pointId == "") exitWith {};

private _pointDetails = _pointData select (_pointIds find _pointId);
private _rallyObjects = _pointDetails select 6;

{
    deleteVehicle _x;
    nil
} count _rallyObjects;

[_pointId] call FUNC(removeDeploymentPoint);
_group setVariable [QGVAR(rallyId), nil, true];
[QGVAR(updateMapIcons), group PRA3_Player] call CFUNC(targetEvent);