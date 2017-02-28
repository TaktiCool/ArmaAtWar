#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Prepares to spawn at a point

    Parameter(s):
    0: Id <STRING>

    Returns:
    Position <POSITION>
*/
params ["_pointId"];

private _pointDetails = [_pointId, ["position", "spawntickets", "availablefor"]] call FUNC(getDeploymentPointData);
_pointDetails params [["_position", [0, 0, 0]], ["_spawnTickets", -1], "_availableFor"];
if (_spawnTickets > 0) then {
    _spawnTickets = _spawnTickets - 1;

    if (_spawnTickets == 0) then {
        [_pointId] call FUNC(removeDeploymentPoint);
    } else {
        [_pointId, "spawntickets", _spawnTickets] call FUNC(setDeploymentPointData);
        [QGVAR(ticketsChanged), _availableFor] call CFUNC(targetEvent);
    };
};

_position
