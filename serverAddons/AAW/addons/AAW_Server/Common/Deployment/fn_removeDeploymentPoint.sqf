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
if (isNull _pointDetails) exitWith {};
private _pointObjects = "pointObjects" call FUNC(getDeploymentPointData);

{
    deleteVehicle _x;
    nil
} count _pointObjects;


[GVAR(DeploymentPointStorage), _pointId, nil, QGVAR(DeploymentPointStorage), true] call CFUNC(setVariable);

private _availableFor = _pointDetails select 3;

if ((_availableFor isEqualType sideUnknown) || {!(isNull _availableFor)}) then {
    private _side = sideUnknown;

    if (_availableFor isEqualType sideUnknown) then {
        _side = _availableFor;
    } else {
        _side = side _availableFor;
    };
    [QGVAR(deploymentPointRemoved), _side, _pointId] call CFUNC(targetEvent);
};
