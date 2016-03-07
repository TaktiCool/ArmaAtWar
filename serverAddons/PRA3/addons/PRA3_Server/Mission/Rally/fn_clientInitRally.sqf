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
private _cfg = (missionConfigFile >> "PRA3" >> "CfgRally");
private _minDistance = getNumber (_cfg >> "minDistance");
private _spawnCount = getNumber (_cfg >> "spawnCount");
private _nearPlayerToBuild = getNumber (_cfg >> "nearPlayerToBuild");
private _waitTime = getNumber (_cfg >> "waitTime");
private _side = [];
private _objects = [];
{
    _side pushBack toLower(configName _x);
    _objects pushBack getArray(_x >> "objects");
    nil
} count ("isClass _x" configClasses _cfg);

private _sides = [_side, _objects];

GVAR(rallyArray) = [_minDistance, _spawnCount, _sides, _nearPlayerToBuild, _waitTime];
GVAR(maxNearEnemy) = getNumber (_cfg >> "maxEnemyCount");
DFUNC(BuildRally) = {
    params ["_array", "_position"];
    private _ret = [];
    {
        _x params ["_type", "_pos"];
        private _obj = createVehicle [_type, _position, [], 0, "NONE"];
        _obj setPosASL [_position select 0, _position select 1, (getTerrainHeightASL _position)];
        _obj setVectorUp (surfaceNormal (getPos _obj));
        ["enableSimulation", [_obj, false]] call CFUNC(serverEvent);
        _ret pushBack _obj;
        nil
    } count (_this select 0);
    _ret
};
DFUNC(deleteRally) = {
    params ["_currentRally"];
    {
        deleteVehicle _x;
        nil
    } count (_currentRally select 2);
    GVAR(respawnPositions) deleteAt GVAR(RallyIndex);
    GVAR(RallyMaxIndex) = count GVAR(respawnPositions);
    GVAR(RallyIndex) = (GVAR(RallyIndex) - 1) max 0;
};
if (isServer) then {
    GVAR(RallyIndex) = -1;
    GVAR(RallyMaxIndex) = 0;
    [{
        if ((GVAR(respawnPositions) isEqualTo []) || (GVAR(RallyMaxIndex) isEqualTo 0) || GVAR(RallyIndex) isEqualTo -1) exitWith {
            GVAR(RallyMaxIndex) = count GVAR(respawnPositions);
            if !(GVAR(RallyMaxIndex) isEqualTo 0) then {
                GVAR(RallyIndex) = 0;
            };
        };
        GVAR(RallyIndex) = ((GVAR(RallyIndex) + 1) mod GVAR(RallyMaxIndex));
        private _currentRally = GVAR(respawnPositions) select GVAR(RallyIndex);
        if (_currentRally select 1 isEqualTo "Base") exitWith {};
        private _side = _currentRally select 0;

        if (({isNull _x} count (_currentRally select 2)) != 0) exitWith {
            [_currentRally] call FUNC(deleteRally);
        };
        private _enemyCount = {
            !(toLower(str(side _x)) isEqualTo toLower(_side))
        } count (nearestObjects [getPos (_currentRally select 1), ["CAManBase"], 10]);
        if (_enemyCount >= GVAR(maxNearEnemy)) then {
            [_currentRally] call FUNC(deleteRally);
        };

    }, 0.2] call CFUNC(addPerFrameHandler);
};

[
    "BuildRallyPoint",
    {
        (_this select 0) params ["_unit"];
        if !([_unit] call FUNC(isRallyPlaceable)) exitWith {
            ["displayNotification", ["Cant Build Rally"]] call CFUNC(targetEvent);
        };
        private _currentSide = toLower(str(side group _unit));
        private _index = ((GVAR(rallyArray) select 2) select 0) find _currentSide;
        private _array = [((GVAR(rallyArray) select 2) select 1) select _index, _unit modelToWorld [0,1,0]] call FUNC(BuildRally);
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
        GVAR(canBuildRally) = false;
        [{GVAR(canBuildRally) = true;}, GVAR(rallyArray) select 4] call CFUNC(wait);
    }
] call CFUNC(addAction);
