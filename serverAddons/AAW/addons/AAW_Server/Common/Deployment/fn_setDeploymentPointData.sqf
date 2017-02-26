#include "macros.hpp"
/*
    Arma At War

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

// delay for 1 frame to garantie that data has updated on remoted clients
[{
    ["DeploymentPointDataChanged", _this] call CFUNC(globalEvent);
}, [_pointID, _dataName]] call CFUNC(execNextFrame);

if (_dataName == "all") exitWith {
    GVAR(DeploymentPointStorage) setVariable [_pointId, _data, true];
};

private _index = GVAR(DeploymentVarTypes) find _dataName;
if (_index != -1) then {
    private _var = [_pointID, "All"] call FUNC(getDeploymentPointData);
    _var set [_index, _data];
    GVAR(DeploymentPointStorage) setVariable [_pointID, _var, true];
};
