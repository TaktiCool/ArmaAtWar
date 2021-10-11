#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Get all available spawn points per side

    Parameter(s):
    None

    Returns:
    Id list of points <ARRAY>
*/
params [["_side", sideUnknown]];

(call FUNC(getAllDeploymentPoints)) select { [_x, _side] call FUNC(isAvailableFor); };
