#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    [Description]

    Parameter(s):
    None

    Returns:
    None
*/
// When the group changes the rally might change too so update the list
["groupChanged", {
    UIVAR(RespawnScreen_DeploymentManagement_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

// When the selected entry changed animate the map
[UIVAR(RespawnScreen_SpawnPointList_onLBSelChanged), {
    UIVAR(RespawnScreen_DeploymentManagement_animateMap) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

// This EH updates the deployment list
[UIVAR(RespawnScreen_DeploymentManagement_update), {
    if (!dialog) exitWith {};

    // Prepare the data for the lnb
    private _lnbData = [];
    EGVAR(Deployment,deploymentPoints) params ["_pointIds", "_pointData"]; //@todo use current position if deployment is deactivated
    {
        private _pointDetails = _pointData select _forEachIndex;
        _pointDetails params ["_name", "_icon", "_tickets", "_position", "_spawnCondition", "_args"];
        if (_args call _spawnCondition) then {
            if (_tickets > 0) then {
                _name = format ["%1 (%2)", _name, _tickets];
            };

            _lnbData pushBack [[_name], _x, _icon];
        };
    } forEach _pointIds;

    // Update the lnb
    [403, _lnbData] call FUNC(updateListNBox); // This may trigger an lbSelChanged event
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_DeploymentManagement_animateMap), {
    disableSerialization;

    // Get the selected value
    EGVAR(Deployment,deploymentPoints) params ["_pointIds", "_pointData"]; //@todo use current position if deployment is deactivated
    private _selectedEntry = lnbCurSelRow 403;
    if (_selectedEntry == -1) exitWith {};
    private _selectedPoint = [403, [_selectedEntry, 0]] call CFUNC(lnbLoad);

    // Get the point data
    private _pointDetails = _pointData select (_pointIds find _selectedPoint); //@todo rewrite with #178
    private _position = _pointDetails select 3;

    // Animate the map
    private _map = (findDisplay 1000) displayCtrl 700;
    _map ctrlMapAnimAdd [0.5, 0.15, _position]; // Dialog syntax can not be used
    ctrlMapAnimCommit _map;
}] call CFUNC(addEventHandler);