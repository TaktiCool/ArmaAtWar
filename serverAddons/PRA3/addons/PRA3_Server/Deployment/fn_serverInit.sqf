#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Init for rally system

    Parameter(s):
    None

    Returns:
    None
*/
// Create a global namespace and publish it
GVAR(pointStorage) = true call CFUNC(createNamespace);
publicVariable QGVAR(pointStorage);

// Add the bases as default points
["missionStarted", {
    {
        private _markerName = "respawn_" + (toLower str _x);
        private _markerPosition = getMarkerPos _markerName;
        if (!(_markerPosition isEqualTo [0, 0, 0])) then {
            ["BASE", _markerPosition, _x, -1, "a3\ui_f\data\map\Markers\Military\box_ca.paa"] call FUNC(addPoint);
        };
        nil
    } count EGVAR(Mission,competingSides);
}] call CFUNC(addEventHandler);

//// This PFH clean abandoned DPs and some other stuff
//[{
//    {
//        private _pointDetails = GVAR(pointStorage) getVariable _x;
//        if (!(isNil "_pointDetails")) then {
//            _pointDetails params ["_name", "_icon", "_tickets", "_position", "_condition", "_args", "_objects"];
//
//            // For RPs only
//            if (_args isEqualType grpNull) then {
//                if (isNull _args) then {
//                    [_x] call FUNC(removeDeploymentPoint);
//                } else {
//                    private _maxEnemyCount = [QGVAR(Rally_maxEnemyCount), 1] call CFUNC(getSetting);
//                    private _maxEnemyCountRadius = [QGVAR(Rally_maxEnemyCountRadius), 10] call CFUNC(getSetting);
//
//                    private _rallySide = side _args;
//                    private _enemyCount = {(side group _x) != _rallySide} count (nearestObjects [_position, ["CAManBase"], _maxEnemyCountRadius]);
//
//                    if (_enemyCount >= _maxEnemyCount) then {
//                        [_args] call FUNC(destroyRally);
//                    };
//                };
//            };
//        };
//        nil
//    } count (allVariables GVAR(pointStorage));
//}, 0.2] call CFUNC(addPerFrameHandler);
