#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Unregisters a Map Control for Map Icon Drawing

    Parameter(s):
    0: Map <Control>

    Remarks:
    None

    Returns:
    None
*/
params ["_map"];

private _idx = GVAR(MapIconMapControls) find _map;
if (_idx >= 0) then {
    GVAR(MapIconMapControls) deleteAt _idx;
};
