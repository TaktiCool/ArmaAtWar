#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Init for Rally System for Leaders

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(Rally), missionConfigFile >> "PRA3" >> "CfgSquadRallyPoint"] call CFUNC(loadSettings);

GVAR(rallyCache) = [];

[{
    private _invalidRallyIndices = [];
    {
        _x params ["_group", "_rallyData"];
        _rallyData params ["_placedTime", "_position", "_objects", "_spawnCount"];

        if (isNull _group) then {
            {
                deleteVehicle _x;
                nil
            } count _objects;
            GVAR(rallyCache) deleteAt _forEachIndex;
        } else {
            private _rallySide = side _group;
            private _enemyCount = {(side group _x) != _rallySide} count (nearestObjects [_position, ["CAManBase"], 10]);
            if (_enemyCount >= ([QGVAR(Rally_maxEnemyCount)] call CFUNC(getSetting))) then {
                {
                    deleteVehicle _x;
                    nil
                } count _objects;

                _group setVariable [QGVAR(rallyPoint), [_placedTime, [], []], true];
                GVAR(rallyCache) deleteAt _forEachIndex;
                [QGVAR(updateDeploymentList), _group] call CFUNC(targetEvent);
            };
        };
    } forEach GVAR(rallyCache);
}, 0.2] call CFUNC(addPerFrameHandler);

[QGVAR(rallyPlaced), {
    params ["_group"];

    GVAR(rallyCache) pushBack [_group, _group getVariable [QGVAR(rallyPoint), [0, [], [], 0]]];
}] call CFUNC(addEventHandler);
