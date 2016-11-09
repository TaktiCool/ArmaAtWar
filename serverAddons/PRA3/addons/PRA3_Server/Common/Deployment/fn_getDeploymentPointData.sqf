#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    get Deploymentpoint data from the point ID

    Parameter(s):
    0: PointID <String>

    Returns:
    0: Name <STRING>
    1: Type <String>
    2: Position <ARRAY>
    3: Spawn point for <SIDE, GROUP>
    4: Tickets <NUMBER>
    5: Icon path <STRING>
    6: Map icon path <STRING>
    7: Objects <ARRAY>
*/

params ["_pointID"];

[GVAR(DeploymentPointStorage), _pointID, [["", "_type", [0,0,0], sideUnknown, -1, "", "", [], []]]] call CFUNC(getVariable);
