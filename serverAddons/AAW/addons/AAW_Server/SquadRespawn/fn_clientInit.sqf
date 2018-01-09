#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    Init Squad Spawn system (currently just for fun and testing :D)

    Parameter(s):
    None

    Returns:
    None
*/
if (side CLib_player == sideLogic && {player isKindOf "VirtualSpectator_F"}) exitWith {};
GVAR(oldSpawns) = [];
[{
    {
        if (!(_x call MFUNC(isAlive)) && !(simulationEnabled _x) && !(isObjectHidden _x)) then {
            _x call MFUNC(removeDeploymentPoint);
        };
        nil
    } count GVAR(oldSpawns);

    {
        if (_x getVariable [QGVAR(hasRespawnPointAttached), false]) then {
            GVAR(oldSpawns) pushBack ["Player " + name _x, "SQUAD", getPos _x, playerSide, -1, "ui\media\fob_ca.paa", "ui\media\fob_ca.paa", []] call MFUNC(addDeploymentPoint);
        };
        nil
    } count units CLib_Player;
}, 0] call CFUNC(addPerFrameHandler);

//["playerChanged", {
//
//}] call CFUNC(addEventhandler);
