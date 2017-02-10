#include "macros.hpp"
/*
    Arma At War

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

private _customData = [_pointId, "customdata"] call FUNC(getDeploymentPointData);

_customData params [["_names", []], ["_datas", []]];

private _index = _names find _name;
if (_index == -1) then {
    _index = _names pushBack _name;
};
_datas set [_index, _data];

[_pointId, "customdata", [_names, _datas]] call FUNC(setDeploymentPointData);
