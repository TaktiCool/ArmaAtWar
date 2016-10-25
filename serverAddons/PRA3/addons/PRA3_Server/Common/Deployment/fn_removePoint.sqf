#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Remove spawn point

    Parameter(s):
    0: ID <STRING>

    Returns:
    Id <STRING>
*/
params ["_pointId"];

private _pointDetails = GVAR(pointStorage) getVariable [_pointId, []];
if (_pointDetails isEqualTo []) exitWith {};

private _pointObjects = _pointDetails select 6;
{
    deleteVehicle _x;
    nil
} count _pointObjects;


[GVAR(pointStorage), _pointId, nil, QGVAR(pointStorage), true] call CFUNC(setVariable);

private _availableFor = _pointDetails select 2;

if ((_availableFor isEqualType sideUnknown) || {!(isNull _availableFor)}) then {
    [QGVAR(pointRemoved), _availableFor, _pointId] call CFUNC(targetEvent);
};
