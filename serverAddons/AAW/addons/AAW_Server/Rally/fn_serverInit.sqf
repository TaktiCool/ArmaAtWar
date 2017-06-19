#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, NetFusion

    Description:
    Server init for rally system

    Parameter(s):
    None

    Returns:
    None
*/

[{
    {
        private _pointDetails = [_x, ["position", "availablefor"]] call EFUNC(Common,getDeploymentPointData);
        _pointDetails params ["_position", "_availableFor"];

        // For RPs only
        if (_availableFor isEqualType grpNull) then {
            if (isNull _availableFor) then {
                [_x] call EFUNC(Common,removeDeploymentPoint);
            } else {
                private _maxEnemyCount = [CFGSRP(maxEnemyCount), 1] call CFUNC(getSetting);
                private _maxEnemyCountRadius = [CFGSRP(maxEnemyCountRadius), 10] call CFUNC(getSetting);

                private _rallySide = side _availableFor;
                private _enemyCount = {(side group _x != sideUnknown) && {(side group _x) != _rallySide}} count (_position nearObjects ["CAManBase", _maxEnemyCountRadius]);

                if (_enemyCount >= _maxEnemyCount) then {
                    [_availableFor] call FUNC(destroy);
                };
            };
        };
        nil
    } count (call EFUNC(Common,getAllDeploymentPoints));
}, 0.2] call CFUNC(addPerFrameHandler);
