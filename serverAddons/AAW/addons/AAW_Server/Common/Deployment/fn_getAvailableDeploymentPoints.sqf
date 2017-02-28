#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Get all available spawn points for player

    Parameter(s):
    None

    Returns:
    Id list of points <ARRAY>
*/
private _availablePoints = [];

{
    private _pointDetails = GVAR(DeploymentPointStorage) getVariable _x;
    if (!(isNil "_pointDetails")) then {
        _pointDetails params ["_name", "_type", "_position", "_availableFor", "_spawnTickets"];

        if ((_availableFor isEqualType playerSide && {playerSide == _availableFor}) || (_availableFor isEqualType grpNull && {group CLib_Player == _availableFor})) then {
            _availablePoints pushBack _x;
        };
    };
    nil
} count ([GVAR(DeploymentPointStorage), QGVAR(DeploymentPointStorage)] call CFUNC(allVariables));

_availablePoints
