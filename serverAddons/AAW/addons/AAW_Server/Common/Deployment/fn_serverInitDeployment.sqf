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

// Add the bases as default points
["missionStarted", {
    {
        private _markerName = "baseSpawn_" + (toLower str _x);
        private _markerPosition = getMarkerPos _markerName;
        if (!(_markerPosition isEqualTo [0, 0, 0])) then {
            ["BASE", "BASE", _markerPosition, _x, -1, "A3\ui_f\data\gui\cfg\ranks\colonel_gs.paa", "A3\ui_f\data\gui\cfg\ranks\colonel_gs.paa"] call FUNC(addDeploymentPoint);
        };
        nil
    } count EGVAR(Common,competingSides);
}] call CFUNC(addEventHandler);

GVAR(changedDPDPointIDs) = [];
GVAR(changedDPDDataNames) = [];
GVAR(changedDPDWaitIsRunning) = false;
/* TODO Cache the event call to reduce Network Trafic
[QGVAR(DeploymentPointDataChanged), {
    (_this select 0) params ["_pointID", "_dataName"];
    _pointID = toLower _pointID;
    _dataName = toLower _dataName;
    private _isNew = false;
    private _i = GVAR(changedDPDPointIDs) find _pointID;
    if (_i == -1) then {
        _i = GVAR(changedDPDPointIDs) pushBack _pointID;
        _isNew = true;
    };
    private _dataNames = if !(_isNew) then {
        GVAR(changedDPDDataNames) select _i
    } else {
        []
    };

    if !(_dataName in _dataNames) then {
        _dataNames pushBack _dataName;
    };

    if (GVAR(changedDPDWaitIsRunning)) exitWith {};
    GVAR(changedDPDWaitIsRunning) = true;
    [{
        {
            if (_x call FUNC(isValidDeploymentPoint)) then {
                private _availableFor = [_x, "availableFor"] call FUNC(getDeploymentPointData);
                if !(_availableFor isEqualTo sideUnknown) then {
                    private _dataNames = GVAR(changedDPDDataNames) select _forEachIndex;
                    ["DeploymentPointDataChanged", _availableFor, [_pointID, _dataNames]] call CFUNC(targetEvent);
                };
            };
        } forEach GVAR(changedDPDPointIDs);
        GVAR(changedDPDDataNames) = [];
        GVAR(changedDPDPointIDs) = [];
        GVAR(changedDPDWaitIsRunning) = false;
    }, 1] call CFUNC(wait);

}] call CFUNC(addEventHandler);
*/
