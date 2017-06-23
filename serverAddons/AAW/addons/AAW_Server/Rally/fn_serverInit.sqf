#include "macros.hpp"
/*
    Arma At War - AAW
    Author: joko // Jonas, NetFusion
    Description:
    Server init for rally system
    Parameter(s):
    None
    Returns:
    None
*/

[{
    {
        private _pointDetails = [_x, ["type", "position", "availablefor"]] call EFUNC(Common,getDeploymentPointData);
        _pointDetails params ["_type", "_position", "_availableFor"];

        // For RPs only
        if (_type == "RALLY") then {
            if (isNull _availableFor || {((count (units _availableFor)) == 0)}) then {
                [_x] call EFUNC(Common,removeDeploymentPoint);
            };
        };
        nil
    } count (call EFUNC(Common,getAllDeploymentPoints));
}, 0.5] call CFUNC(addPerFrameHandler);
