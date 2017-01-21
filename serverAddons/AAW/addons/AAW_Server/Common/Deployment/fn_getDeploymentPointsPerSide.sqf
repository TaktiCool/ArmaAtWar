#include "macros.hpp"
/*
    Arma At War

    Author: NetFusion

    Description:
    Get all available spawn points per side

    Parameter(s):
    None

    Returns:
    Id list of points <ARRAY>
*/
params [["_side", sideUnknown]];
private _availablePoints = [];

{
    private _pointDetails = GVAR(DeploymentPointStorage) getVariable _x;
    if (!(isNil "_pointDetails")) then {
        _pointDetails params ["_name", "_type", "_position", "_availableFor", "_spawnTickets"];

        if ((_availableFor isEqualType playerSide && {_side == _availableFor}) || (_availableFor isEqualType grpNull && {_side == side _availableFor})) then {
            _availablePoints pushBack _x;
        };
    };
    nil
} count ([GVAR(DeploymentPointStorage), QGVAR(DeploymentPointStorage)] call CFUNC(allVariables));

_availablePoints
