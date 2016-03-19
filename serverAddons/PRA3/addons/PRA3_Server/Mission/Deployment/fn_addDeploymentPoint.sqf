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

if (isNil QGVAR(deploymentLogic)) then {
    // Create deployment logic for everyone
    GVAR(deploymentLogic) = (call CFUNC(getLogicGroup)) createUnit ["Logic", [-1000, -1000, 0], [], 0, "NONE"];
    publicVariable QGVAR(deploymentLogic);
};

private _id = format ["%1_%2", _name, _position];
GVAR(deploymentLogic) setVariable [_id, [_name, _icon, _spawnTickets, _position, _spawnCondition, _args, _pointObjects], true];

_id
