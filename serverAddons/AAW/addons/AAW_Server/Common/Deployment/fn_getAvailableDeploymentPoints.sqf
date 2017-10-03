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
params ["_unit"];

private _group = group _unit;
private _availablePoints = [];

{
    private _availableFor = [_x, "availableFor"] call FUNC(getDeploymentPointData);
    if !(isNil "_availableFor") then {
        if ((_availableFor isEqualType sideUnknown && {side _group == _availableFor}) || (_availableFor isEqualType grpNull && {_group == _availableFor})) then {
            _availablePoints pushBack _x;
        };
    };
    nil
} count (call FUNC(getAllDeploymentPoints));

_availablePoints
