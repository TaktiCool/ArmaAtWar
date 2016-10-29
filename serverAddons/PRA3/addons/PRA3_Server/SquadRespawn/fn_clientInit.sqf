#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Init Squad Spawn system (currently just for fun and testing :D)

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(oldSpawns) = [];
[{


    {
        if (!(_x call EFUNC(Common,isAlive)) && !(simulationEnabled _x) && !(isObjectHidden _x)) then {
            _x call EFUNC(Common,removeDeploymentPoint);
        };
        nil
    } count GVAR(oldSpawns);

    {
        if (_x getVariable [QGVAR(hasRespawnPointAttached), false]) then {
            GVAR(oldSpawns) pushBack ["Player " + name _x, getPos _x, playerSide, -1, "ui\media\fob_ca.paa", "ui\media\fob_ca.paa", []] call EFUNC(Common,addDeploymentPoint);
        };
        nil
    } count units CLib_Player;
}, 0] call CFUNC(addPerFrameHandler);

["playerChanged", {

}] call CFUNC(addEventhandler);
