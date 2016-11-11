#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Remove spawn point

    Parameter(s):
    0: ID <STRING>

    Returns:
    Id <STRING>
*/
params ["_pointId"];

private _pointDetails = GVAR(DeploymentPointStorage) getVariable [_pointId, []];
if (_pointDetails isEqualTo []) exitWith {};

private _pointObjects = _pointDetails select 7;
{
    deleteVehicle _x;
    nil
} count _pointObjects;


[GVAR(DeploymentPointStorage), _pointId, nil, QGVAR(DeploymentPointStorage), true] call CFUNC(setVariable);

private _availableFor = _pointDetails select 3;

if ((_availableFor isEqualType sideUnknown) || {!(isNull _availableFor)}) then {
    [QGVAR(deploymentPointRemoved), _availableFor, _pointId] call CFUNC(targetEvent);
};
