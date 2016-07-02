#include "macros.hpp"
/*
    Project Reality ArmA 3

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
    private _pointDetails = GVAR(pointStorage) getVariable _x;
    if (!(isNil "_pointDetails")) then {
        _pointDetails params ["_name", "_position", "_availableFor", "_spawnTickets"];

        if ((_availableFor isEqualType playerSide && {playerSide == _availableFor}) || (_availableFor isEqualType grpNull && {group PRA3_Player == _availableFor})) then {
            _availablePoints pushBack _x;
        };
    };
    nil
} count ([GVAR(pointStorage), QGVAR(pointStorage)] call CFUNC(allVariables));

_availablePoints
