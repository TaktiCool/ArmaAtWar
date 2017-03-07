#include "macros.hpp"
/*
    Arma At War - AAW

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
    // we dont need to resend if the data is equal
    if (([_pointID, "All"] call FUNC(getDeploymentPointData)) isEqualTo _data) exitWith {};
        // delay for 1 frame to garantie that data has updated on remoted clients

    GVAR(DeploymentPointStorage) setVariable [_pointId, _data, true];
    [{
        ["DeploymentPointDataChanged", _this] call CFUNC(globalEvent);
    }, [_pointID, _dataName]] call CFUNC(execNextFrame);
};

private _index = GVAR(DeploymentVarTypes) find _dataName;
if (_index != -1) then {
    private _var = [_pointID, "All"] call FUNC(getDeploymentPointData);
    private _oldData = _var select _index;

    // we dont need to resend if the data is equal
    if (_oldData isEqualTo _data) exitWith {};

    _var set [_index, _data];
    GVAR(DeploymentPointStorage) setVariable [_pointID, _var, true];

    [{
        ["DeploymentPointDataChanged", _this] call CFUNC(globalEvent);
    }, [_pointID, _dataName]] call CFUNC(execNextFrame);
};
