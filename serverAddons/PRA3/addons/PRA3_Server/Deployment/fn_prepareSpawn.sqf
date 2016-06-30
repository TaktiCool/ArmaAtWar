#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Prepares to spawn at a point

    Parameter(s):
    0: Id <STRING>

    Returns:
    Position <POSITION>
*/
params ["_pointId"];

private _pointDetails = GVAR(pointStorage) getVariable [_pointId, []];
if (_pointDetails isEqualTo []) exitWith {[0, 0, 0]};

_pointDetails params ["_name", "_position", "_availableFor", "_spawnTickets", "_icon", "_mapIcon", "_pointObjects"];

if (_spawnTickets > 0) then {
    _spawnTickets = _spawnTickets - 1;

    if (_spawnTickets == 0) then {
        [_pointId] call FUNC(removePoint);
    } else {
        _pointDetails set [3, _spawnTickets];
        GVAR(pointStorage) setVariable [_pointId, _pointDetails, true];
        [QGVAR(ticketsChanged), _availableFor] call CFUNC(targetEvent);
    };
};

_position
