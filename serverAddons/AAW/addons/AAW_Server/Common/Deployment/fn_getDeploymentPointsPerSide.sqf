#include "macros.hpp"
/*
    Arma At War - AAW

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
    private _pointNamespace = GVAR(DeploymentPointStorage) getVariable [_x, objNull];
    if (!(isNull _pointNamespace)) then {
        private _availableFor = [_x, ["availableFor", sideUnknown]] call FUNC(getDeploymentPointData);

        if ((_availableFor isEqualType playerSide && {_side == _availableFor}) || (_availableFor isEqualType grpNull && {_side == side _availableFor})) then {
            _availablePoints pushBack _x;
        };
    };
    nil
} count ([GVAR(DeploymentPointStorage), QGVAR(DeploymentPointStorage)] call CFUNC(allVariables));

_availablePoints
