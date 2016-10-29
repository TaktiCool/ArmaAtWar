#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Server init for rally system

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(Rally), missionConfigFile >> QPREFIX >> "CfgSquadRallyPoint"] call CFUNC(loadSettings);

[{
    {
        private _pointDetails = EGVAR(Common,DeploymentPointStorage) getVariable _x;
        if (!(isNil "_pointDetails")) then {
            _pointDetails params ["_name", "_position", "_availableFor"];

            // For RPs only
            if (_availableFor isEqualType grpNull) then {
                if (isNull _availableFor) then {
                    [_x] call FUNC(removeDeploymentPoint);
                } else {
                    private _maxEnemyCount = [QGVAR(Rally_maxEnemyCount), 1] call CFUNC(getSetting);
                    private _maxEnemyCountRadius = [QGVAR(Rally_maxEnemyCountRadius), 10] call CFUNC(getSetting);

                    private _rallySide = side _availableFor;
                    private _enemyCount = {(side group _x != sideUnknown) && {(side group _x) != _rallySide}} count (_position nearObjects ["CAManBase", _maxEnemyCountRadius]);

                    if (_enemyCount >= _maxEnemyCount) then {
                        [_availableFor] call FUNC(destroyRally);
                    };
                };
            };
        };
        nil
    } count ([EGVAR(Common,DeploymentPointStorage), QEGVAR(Common,DeploymentPointStorage)] call CFUNC(allVariables));
}, 0.2] call CFUNC(addPerFrameHandler);
