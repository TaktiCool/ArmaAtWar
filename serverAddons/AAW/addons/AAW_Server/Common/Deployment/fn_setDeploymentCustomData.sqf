#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas

    Description:
    Set Custom Deploymentdata to Deploymentpoint

    Parameter(s):
    0: PointID <String> (Default: "")
    1: Dataname <String> (Default: "")
    2: Data <Anything> (Default: nil)

    Returns:
    None
*/

params [
    ["_pointId", "", [""]],
    ["_name", "", [""]],
    ["_data", nil, []]
];

private _customData = [_pointId, "customdata"] call FUNC(getDeploymentPointData);

_customData params [["_names", []], ["_datas", []]];

private _index = _names find _name;
if (_index == -1) then {
    _index = _names pushBack _name;
};
_datas set [_index, _data];

[_pointId, "customdata", [_names, _datas]] call FUNC(setDeploymentPointData);
