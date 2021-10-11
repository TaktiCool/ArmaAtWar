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
params ["_name", "_type", "_position", "_availableFor", "_spawnTickets", "_icon", ["_mapIcon", "", ["", []]], ["_customData", []]];

private _id = format ["%1_%2_%3", _type, _name, _position];
private _namespace = true call CFUNC(createNamespace);

[GVAR(DeploymentPointStorage), _id, _namespace, QGVAR(DeploymentPointStorage), true] call CFUNC(setVariable);
{
    [_id, _x select 0, _x select 1] call FUNC(setDeploymentPointData);
    nil
} count [
    ["name", _name],
    ["type", _type],
    ["position", _position],
    ["availableFor", _availableFor],
    ["spawnTickets", _spawnTickets],
    ["icon", _icon],
    ["mapIcon", _mapIcon]
];

{
    [_id, _x select 0, _x select 1] call FUNC(setDeploymentPointData);
    nil
} count _customData;


if !(_availableFor isEqualType sideUnknown) then {
    _availableFor = side _availableFor;
};

[_id] call FUNC(onPlaced);

switch (typeName _position) do {
    case ("OBJECT"): {
        _namespace setPos (getPos _position);
    };
    case ("CODE"): {
        _namespace setPos (_id call _position);
    };
    default {
        _namespace setPos _position;
    };
};

[QGVAR(deploymentPointAdded), _availableFor, _id] call CFUNC(targetEvent);

_id
