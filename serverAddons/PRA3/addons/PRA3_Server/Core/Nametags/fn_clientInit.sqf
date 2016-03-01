#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Init for Nametags

    Parameter(s):
    None

    Returns:
    None
*/
if !(hasInterface) exitWith {};
addMissionEventHandler ["Draw3D", FUNC(draw3D)];
