#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Init for Rally System for Leaders

    Parameter(s):
    None

    Returns:
    None
*/
/*
class CfgRally {
    minDistance = 100;
    spawnCount = 9;
    class East {
        objects[] = {};
    };
    class West {
        objects[] = {};
    };
};
*/
private _cfg = (missionConfigFile >> "PRA3" >> "CfgRally");
private _minDistance = getNumber (_cfg >> "minDistance");
private _spawnCount = getNumber (_cfg >> "spawnCount");
private _sides = [];
{
    _sides
} forEach "isClass _x" configClasses _cfg;

GVAR(rallyArray) = [_minDistance, _spawnCount, ];

[
    "Create Rally Point",
     PRA3_Player,
     0,
     "PRA3_Player == leader PRA3_Player",
     {



     }
] call CFUNC(addAction);
