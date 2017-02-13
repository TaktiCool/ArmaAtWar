#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas, NetFusion

    Description:
    Init for rally system

    Parameter(s):
    None

    Returns:
    None
*/

// Create a global namespace and publish it
GVAR(DeploymentPointStorage) = true call CFUNC(createNamespace);
publicVariable QGVAR(DeploymentPointStorage);

// Add the bases as default points
["missionStarted", {
    {
        private _markerName = "baseSpawn_" + (toLower str _x);
        private _markerPosition = getMarkerPos _markerName;
        if !(_markerPosition isEqualTo [0, 0, 0]) then {
            ["BASE", "BASE", _markerPosition, _x, -1, "a3\ui_f\data\map\Markers\Military\box_ca.paa"] call FUNC(addDeploymentPoint);
        };
        nil
    } count EGVAR(Common,competingSides);
}] call CFUNC(addEventHandler);
