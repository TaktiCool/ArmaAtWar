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
private _nearPlayerToBuild = getNumber (_cfg >> "nearPlayerToBuild");
private _waitTime = getNumber (_cfg >> "waitTime");
private _sides = [];
{
    _sides pushBack [configName _x, getArray(_x >> "objects")];
    nil
} count "isClass _x" configClasses _cfg;

GVAR(rallyArray) = [_minDistance, _spawnCount, _sides, _nearPlayerToBuild, _waitTime];

DFUNC(BuildRally) = {
    params ["_array", "_position"];
    _ret = [];
    {
        _x params ["_type", "_pos"];
        private _obj = createVehicle [_type, _position, [], 0, "NONE"];
        ["enableSimulation", _obj] call CFUNC(serverEvent);
        _ret pushBack _obj;
        nil
    } count (_this select 0);
    _ret
};

if (isServer) then {
    // ToDo distroy stuff
    [{}, 2] call CFUNC(addPerFrameHandler);
};

[
    "BuildRallyPoint",
    {
        (_this select 0) params ["_unit"];
        if !([_unit] call FUNC(isRallyPlaceable)) exitWith {
            ["displayNotification", ["Cant Build Rally"]] call CFUNC(targetEvent);
        };
        private _currentSide = str(side group _unit);
        private _index = (GVAR(rallyArray) select 2) find [_currentSide];
        private _array = [((GVAR(rallyArray) select 2) select _index) select 1, _unit modelToWorld [0,1,0]] call FUNC(BuildRally);
        GVAR(respawnPositions) pushBack [_currentSide, _array select 0, _array];
        publicVariable QGVAR(respawnPositions);
    }
] call CFUNC(addEventhandler);

GVAR(canBuildRally) = true;
[
    "Create Rally Point",
    PRA3_Player,
    0,
    {PRA3_Player == leader PRA3_Player && {GVAR(canBuildRally)} && {[QFUNC(isRallyPlaceable), FUNC(isRallyPlaceable), [PRA3_Player], 5, QGVAR(ClearRallyPlacable)] call CFUNC(cachedCall)}},
    {
        [QGVAR(ClearRallyPlacable)] call CFUNC(localEvent);
        ["BuildRallyPoint", [PRA3_Player]] call CFUNC(serverEvent);
        [{GVAR(canBuildRally)}, GVAR(rallyArray) select 4] call CFUNC(wait);
    }
] call CFUNC(addAction);
