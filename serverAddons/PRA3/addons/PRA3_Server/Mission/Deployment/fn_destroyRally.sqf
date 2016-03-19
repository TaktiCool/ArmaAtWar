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

private _pointId = _group getVariable [QGVAR(rallyId), ""];
if (_pointId == "") exitWith {};

private _pointDetails = GVAR(deploymentLogic) getVariable [_pointId, []];
private _rallyObjects = _pointDetails select 6;

{
    deleteVehicle _x;
    nil
} count _rallyObjects;

GVAR(deploymentLogic) setVariable [_pointId, nil, true];
_group setVariable [QGVAR(rallyId), nil, true];