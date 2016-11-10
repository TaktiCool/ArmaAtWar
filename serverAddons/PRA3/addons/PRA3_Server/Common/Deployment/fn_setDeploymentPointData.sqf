#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    get Deploymentpoint data from the point ID

    Parameter(s):
    0: PointID <String>
    1: DataName <String>
    2: Data <Any>

    Returns:
    None
*/

params ["_pointID", "_dataName", "_data"];

if (_dataName == "all") exitWith {
    GVAR(DeploymentPointStorage) setVariable [_pointId, _data, true];
};

private _index = GVAR(DeploymentVarTypes) find _dataName;
if (_index != -1) then {
    private _var = [_pointID, "All"] call FUNC(getDeploymentPointData);
    _var set [_index, _data];
    GVAR(DeploymentPointStorage) getVariable [_pointID, _var, true];
};
