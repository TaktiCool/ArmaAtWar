#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Cleanup after closing respawn dialog

    Parameter(s):
    0: RespawnDialog <Dialog>

    Returns:
    None
*/
params ["_dialog"];


[GVAR(respawnScreenPFH)] call CFUNC(removePerFrameHandler);
