#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Initializes the deployment part of the respawn screen.

    Parameter(s):
    None

    Returns:
    None
*/
[UIVAR(DeploymentScreen_onLoad), {
    // The dialog needs one frame until access to controls is possible
    [{
        // Update the values of the UI elements
        UIVAR(RespawnScreen_DeploymentManagement_update) call CFUNC(localEvent);

        // Fade the control in
        400 call FUNC(fadeControl);
    }] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

// When the group changes the rally might change too so update the list
["groupChanged", {
    UIVAR(RespawnScreen_DeploymentManagement_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

//@todo switch to events related to deployment point instead of rally with #178
[QEGVAR(Deployment,rallyPlaced), {
    [UIVAR(RespawnScreen_DeploymentManagement_update), group PRA3_Player] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);
[QEGVAR(Deployment,rallyDestroyed), {
    [UIVAR(RespawnScreen_DeploymentManagement_update), group PRA3_Player] call CFUNC(targetEvent);
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

// When the selected entry changed animate the map
[UIVAR(RespawnScreen_SpawnPointList_onLBSelChanged), {
    //@todo only animate if really changed
    UIVAR(RespawnScreen_DeploymentManagement_animateMap) call CFUNC(localEvent);
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