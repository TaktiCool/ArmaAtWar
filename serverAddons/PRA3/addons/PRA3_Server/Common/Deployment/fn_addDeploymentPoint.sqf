#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Adds spawn point

    Parameter(s):
    0: Name <STRING>
    1: Position <ARRAY>
    2: Spawn point for <SIDE, GROUP>
    3: Tickets <NUMBER>
    4: Icon path <STRING>
    5: Map icon path <STRING>
    6: Objects <ARRAY>

    Returns:
    Id <STRING>
*/
params ["_name", "_position", "_availableFor", "_spawnTickets", "_icon", ["_mapIcon", ""], ["_pointObjects", []]];

private _id = format ["%1_%2", _name, _position];

[GVAR(DeploymentPointStorage), _id, [_name, _position, _availableFor, _spawnTickets, _icon, _mapIcon, _pointObjects], QGVAR(DeploymentPointStorage), true] call CFUNC(setVariable);

[QGVAR(deploymentPointAdded), _availableFor] call CFUNC(targetEvent);

_id
