#include "macros.hpp"
/*
    Arma At War

    Author: NetFusion

    Description:
    Adds spawn point

    Parameter(s):
    0: Name <String> (Default: "")
    1: Type <String> (Default: "")
    2: Position <Array> (Default: [0, 0, 0])
    3: Spawn point for <Side, Group> (Default: sideUnknown)
    4: Tickets <Number> (Default: 0)
    5: Icon path <String> (Default: "")
    6: Map icon path <String> (Default: "")
    7: Objects <Array> (Default: [])
    8: CostumData <Array> (Default: [])


    CustomData Array Structure:
    Array
        0: Name <String>
        1: Data <Any>

    Returns:
    Id <STRING>
*/

params [
    ["_name", "", [""]],
    ["_type", "", [""]],
    ["_position", [0, 0, 0], [[]], 3],
    ["_availableFor", sideUnknown, [sideUnknown, grpNull]],
    ["_spawnTickets", 0, [0]],
    ["_icon", "", [""]],
    ["_mapIcon", "", [""]],
    ["_pointObjects", [], [[]], []],
    ["_customData", [], [[]], []]
];

private _id = format ["%1_%2", _name, _position];

[GVAR(DeploymentPointStorage), _id, [_name, _type, _position, _availableFor, _spawnTickets, _icon, _mapIcon, _pointObjects, [[], []]], QGVAR(DeploymentPointStorage), true] call CFUNC(setVariable);

{
    _x call FUNC(setDeploymentCustomData);
    nil
} count _customData;

private _side = sideUnknown;

if (_availableFor isEqualType sideUnknown) then {
    _side = _availableFor;
} else {
    _side = side _availableFor;
};

[QGVAR(deploymentPointAdded), _side] call CFUNC(targetEvent);

_id
