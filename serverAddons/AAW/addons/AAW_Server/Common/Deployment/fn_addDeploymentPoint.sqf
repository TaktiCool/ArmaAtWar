#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Adds spawn point

    Parameter(s):
    0: Name <STRING>
    1: Type <String>
    2: Position <ARRAY>
    3: Spawn point for <SIDE, GROUP>
    4: Tickets <NUMBER>
    5: Icon path <STRING>
    6: Map icon path <STRING>
    7: Objects <ARRAY>
    8: CustomData <Array>


    CustomData Array Structure:
    Array
        0: Name <String>
        1: Data <Any>

    Returns:
    Id <STRING>
*/
params ["_name", "_type", "_position", "_availableFor", "_spawnTickets", "_icon", ["_mapIcon", ""], ["_pointObjects", []], ["_customData", []]];

private _id = format ["%1_%2", _name, _position];
private _namespace = true call CFUNC(createNamespace);
_namespace setPos _position;

[GVAR(DeploymentPointStorage), _id, _namespace, QGVAR(DeploymentPointStorage), true] call CFUNC(setVariable);
{
    _x call FUNC(setDeploymentData
    nil
} count [
    ["name", _name],
    ["type", _type],
    ["position", _position],
    ["availableFor", _availableFor],
    ["spawnTickets", _spawnTickets],
    ["icon", _icon],
    ["mapIcon", _mapIcon],
    ["pointObjects", _pointObjects]
];

{
    _x call FUNC(setDeploymentData);
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
