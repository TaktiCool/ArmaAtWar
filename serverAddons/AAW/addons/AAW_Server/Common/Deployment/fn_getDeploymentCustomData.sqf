#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas

    Description:
    Get Custom Deploymentdata from Deploymentpoint

    Parameter(s):
    0: PointID <String> (Default: "")
    1: Dataname <String> (Default: "")
    2: Default data <Anything> (Default: nil)

    Returns:
    None
*/

params [
    ["_pointId", "", [""]],
    ["_name", "", [""]],
    ["_default", nil, []]
];

private _customData = (_pointId call FUNC(getDeploymentPointData)) select 8;
_customData params ["_names", "_data"];
private _index = _names find _name;
if (_index == -1) exitWith {
    _default;
};
_data select _index;
