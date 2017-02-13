#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas

    Description:
    Get Deploymentpoint data from the point ID

    Parameter(s):
    0: PointID <String> (Default: "")
    1: DataName <String> (Default: "")
    2: Data <Anything> (Default: nil)

    Returns:
    None
*/

params [
    ["_pointID", "", [""]],
    ["_dataName", "", [""]],
    ["_data", nil, []]
];

if (_dataName == "all") exitWith {
    GVAR(DeploymentPointStorage) setVariable [_pointId, _data, true];
};

private _index = GVAR(DeploymentVarTypes) find _dataName;
if (_index != -1) then {
    private _var = [_pointID, "All"] call FUNC(getDeploymentPointData);
    _var set [_index, _data];
    GVAR(DeploymentPointStorage) setVariable [_pointID, _var, true];
};
