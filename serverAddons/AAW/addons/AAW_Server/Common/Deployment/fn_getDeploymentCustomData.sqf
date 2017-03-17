#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    get Custom Deploymentdata from Deploymentpoint

    Parameter(s):
    0: PointID <String>
    1: Dataname <String>
    2: Default data <Any> (Optional: any)

    Returns:
    None
*/
params ["_pointId", "_name", "_default"];
_name = toLower _name;
private _customData = (_pointId call FUNC(getDeploymentPointData)) select 8;
_customData params ["_names", "_data"];
private _index = _names find _name;
if (_index == -1) exitWith {
    _default;
};
_data select _index;
