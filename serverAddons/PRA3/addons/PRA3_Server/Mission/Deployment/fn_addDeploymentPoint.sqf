#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    add spawn point

    Parameter(s):
    0: Name <STRING>
    1: Icon path <STRING>
    2: posi <ARRAY>
    3: condition <CODE>
    4: arguments <ANY>
    5: objects <ARRAY>

    Returns:
    Id <STRING>
*/
params ["_name", "_icon", "_spawnTickets", "_position", "_spawnCondition", ["_args", []], ["_pointObjects", []]];

if (isNil QGVAR(deploymentPoints)) then {
    // Create deployment logic for everyone
    GVAR(deploymentPoints) = [[], []];
};

GVAR(deploymentPoints) params ["_pointIds", "_pointData"];

private _id = format ["%1_%2", _name, _position];
_pointIds pushBack _id;
_pointData pushBack [_name, _icon, _spawnTickets, _position, _spawnCondition, _args, _pointObjects];

GVAR(deploymentPoints) set [0, _pointIds];
GVAR(deploymentPoints) set [1, _pointData];

publicVariable QGVAR(deploymentPoints);

_id
