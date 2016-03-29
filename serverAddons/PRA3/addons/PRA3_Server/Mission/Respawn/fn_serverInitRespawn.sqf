#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Server Init

    Parameter(s):
    None

    Returns:
    None
*/
GVAR(attachPoint) = "Land_HelipadEmpty_F" createVehicle [-10000, -10000, 50];
GVAR(attachPoint) enableSimulationGlobal false
GVAR(attachPoint) hideObjectGlobal true;
publicVariable QGVAR(attachPoint);
