#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, NetFusion

    Description:
    Checks if FOB is placeable

    Parameter(s):
    None

    Returns:
    is Rally Placeable <Bool>
*/
params ["_pointID", "_caller"];
private _pointDetails = [_pointID, ["type", "position", "availablefor", "counterActive"]] call MFUNC(getDeploymentPointData);
_pointDetails params [["_type", ""], ["_position", [0, 0, 0]], ["_availableFor", sideUnknown], ["_counterActive", 0]];

_type == "FOB" && {_caller distance _position <= 5 && {_counterActive == 0 && {_availableFor != side group _caller}}}
