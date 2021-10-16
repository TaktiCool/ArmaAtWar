#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Remove spawn point

    Parameter(s):
    0: ID <STRING>

    Returns:
    Id <STRING>
*/
params ["_pointId"];

private _pointNamespace = GVAR(DeploymentPointStorage) getVariable [_pointId, objNull];
if (isNull _pointNamespace) exitWith {};

private _data = [_pointId, ["pointObjects", "availableFor"]] call FUNC(getDeploymentPointData);
_data params ["_pointObjects", "_availableFor"];

[_pointId, _pointObjects] call FUNC(onDestroy);

[QGVAR(deploymentPointRemoved), _pointId] call CFUNC(globalEvent);
private _namespace = GVAR(DeploymentPointStorage) getVariable [_pointId, objNull];
deleteVehicle _namespace;
[GVAR(DeploymentPointStorage), _pointId, nil, QGVAR(DeploymentPointStorage), true] call CFUNC(setVariable);
