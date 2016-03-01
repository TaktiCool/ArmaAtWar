#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Init for Interaction

    Parameter(s):
    None

    Returns:
    None
*/

if !(hasInterface) exitWith {};
GVAR(Interaction_Actions) = [];
player call FUNC(loop);
