#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    set Custom Deploymentdata to Deploymentpoint

    Parameter(s):
    0: PointID <String>
    1: Dataname <String>

    Returns:
    None
*/
params ["_pointId", "_name", "_data"];

private _customData = (_pointId call FUNC(getDeploymentPointData)) select 8;

_customData params ["_names", "_data"];

private _index = _customData find _name;
if (_index == -1) then {
    _index = _names pushBack _name;
};
_datas set [_index, _data];
