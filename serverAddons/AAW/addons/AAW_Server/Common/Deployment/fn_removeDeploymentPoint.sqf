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
private _pointObjects = [_pointId, "pointObjects"] call FUNC(getDeploymentPointData);

{
    deleteVehicle _x;
    nil
} count _pointObjects;


private _availableFor = [_pointId, "availableFor"] call FUNC(getDeploymentPointData);

if ((_availableFor isEqualType sideUnknown) || {!(isNull _availableFor)}) then {
    private _side = sideUnknown;

    if (_availableFor isEqualType sideUnknown) then {
        _side = _availableFor;
    } else {
        _side = side _availableFor;
    };
    [QGVAR(deploymentPointRemoved), _side, _pointId] call CFUNC(targetEvent);
};
private _namespace = GVAR(DeploymentPointStorage) getVariable [_pointId, objNull];
deleteVehicle _namespace;
[GVAR(DeploymentPointStorage), _pointId, nil, QGVAR(DeploymentPointStorage), true] call CFUNC(setVariable);
