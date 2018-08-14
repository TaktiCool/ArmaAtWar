#include "macros.hpp"
/*
    Arma At War - AAW

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
["BASE", "onPrepare", {
    params ["_pointId"];
    private _pointDetails = [_pointId, ["position"]] call EFUNC(Common,getDeploymentPointData);
    _pointDetails params [["_pos", [0,0,0]]];
    _pos;
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["BASE", "onDeploy", {
    params ["_pointId", "_prevRet"];
    if !(isNil "_prevRet") exitWith { _prevRet; };
    true;
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["BASE", "isLocked", {
    params ["_pointId", "_prevRet"];
    false;
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["BASE", "isAvailableFor", {
    params ["_pointId", "_prevRet", "_target"];
    if (_target isEqualType objNull) then {
        _target = group _target;
    };
    if (_target isEqualType grpNull) then {
        _target = side _target;
    };
    if ([_pointId, "availableFor", 0] call EFUNC(Common,getDeploymentPointData) isEqualTo _target) then {
        true;
    } else {
        if (isNil "_prevRet") then {
            false;
        } else {
            _prevRet;
        };
    };
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

// Add the bases as default points
["missionStarted", {
    {
        private _markerName = "baseSpawn_" + (toLower str _x);
        private _markerPosition = getMarkerPos _markerName;
        if (!(_markerPosition isEqualTo [0, 0, 0])) then {
            ["BASE", "BASE", _markerPosition, _x, -1, "A3\ui_f\data\gui\cfg\ranks\colonel_gs.paa", "A3\ui_f\data\gui\cfg\ranks\colonel_gs.paa"] call FUNC(addDeploymentPoint);
        };

        if (!isNull (missionNamespace getVariable ["baseSpawn_" + (toLower str _x), objNull])) then {
            ["BASE", "BASE", getPosATL (missionNamespace getVariable ["baseSpawn_" + (toLower str _x), objNull]), _x, -1, "A3\ui_f\data\gui\cfg\ranks\colonel_gs.paa", "A3\ui_f\data\gui\cfg\ranks\colonel_gs.paa"] call FUNC(addDeploymentPoint);
        };
        nil
    } count EGVAR(Common,competingSides);
}] call CFUNC(addEventHandler);
