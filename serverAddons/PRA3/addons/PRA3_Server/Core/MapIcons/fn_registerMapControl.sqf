#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Registers a Map Control for Map Icon Drawing

    Parameter(s):
    0: Map <Control>

    Remarks:
    None

    Returns:
    None
*/
params ["_map"];

GVAR(MapIconMapControls) pushBackUnique _map;
