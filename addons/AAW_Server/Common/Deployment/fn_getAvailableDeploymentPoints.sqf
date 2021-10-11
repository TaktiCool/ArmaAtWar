#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Get all available spawn points for player

    Parameter(s):
    None

    Returns:
    Id list of points <ARRAY>
*/
params ["_unit"];

(call FUNC(getAllDeploymentPoints)) select { [_x, _unit] call FUNC(isAvailableFor); };
