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

if (getMarkerPos "respawn_west" distance [0,0,0] >= 1) then {
    ["BASE", "a3\ui_f\data\map\Markers\Military\box_ca.paa", -1, getMarkerPos "respawn_west", {playerSide == west}] call FUNC(addDeploymentPoint);
};

if (getMarkerPos "respawn_east" distance [0,0,0] >= 1) then {
    ["BASE", "a3\ui_f\data\map\Markers\Military\box_ca.paa", -1, getMarkerPos "respawn_east", {playerSide == east}] call FUNC(addDeploymentPoint);
};

if (getMarkerPos "respawn_guerrila" distance [0,0,0] >= 1) then {
    ["BASE", "a3\ui_f\data\map\Markers\Military\box_ca.paa", -1, getMarkerPos "respawn_guerrila", {playerSide == independent}] call FUNC(addDeploymentPoint);
};

[{
    GVAR(deploymentPoints) params ["_pointIds", "_pointData"];
    {
        private _pointDetails = _pointData select (_pointIds find _x);
        _pointDetails params ["_name", "_icon", "_tickets", "_position", "_condition", "_args", "_objects"];

        if (_args isEqualType grpNull) then {
            if (isNull _args) then {
                {
                    deleteVehicle _x;
                    nil
                } count _objects;
                [_x] call FUNC(removeDeploymentPoint);
            } else {
                private _maxEnemyCount = [QGVAR(Rally_maxEnemyCount), 1] call CFUNC(getSetting);
                private _maxEnemyCountRadius = [QGVAR(Rally_maxEnemyCountRadius), 10] call CFUNC(getSetting);

                private _rallySide = side _args;
                private _enemyCount = {(side group _x) != _rallySide} count (nearestObjects [_position, ["CAManBase"], _maxEnemyCountRadius]);

                if (_enemyCount >= _maxEnemyCount) then {
                    [_args] call FUNC(destroyRally);
                    [_x] call FUNC(removeDeploymentPoint);
                    [UIVAR(RespawnScreen_DeploymentManagement_update), _args] call CFUNC(targetEvent);
                };
            };
        };
        nil
    } count _pointIds;
}, 0.2] call CFUNC(addPerFrameHandler);
