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
    (_this select 0) params ["_display"];
    uiNamespace setVariable [QGVAR(deploymentDisplay), _display];

    // The dialog needs one frame until access to controls is possible
    [{
        params ["_display"];

        // Update the deploy button
        UIVAR(RespawnScreen_DeploymentButton_update) call CFUNC(localEvent);

        // Update the values of the UI elements
        UIVAR(RespawnScreen_DeploymentManagement_update) call CFUNC(localEvent);

        // Fade the control in
        (_display displayCtrl 400) call FUNC(fadeControl);
    }, _display] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_DeploymentButton_update), {
    private _display = uiNamespace getVariable [QGVAR(deploymentDisplay), displayNull];
    if (isNull _display) exitWith {};

    private _control = _display displayCtrl 404;

    // Calculate the respawn timer if necessary
    if (!(alive CLib_Player) || (CLib_Player getVariable [QEGVAR(Common,tempUnit), false])) then {
        // Disable the button and start the timer
        _control ctrlEnable false;
        [{
            params ["_params", "_id"];
            _params params ["_control", "_respawnTime"];

            // If the display has closed exit the PFH
            if (isNull GVAR(deploymentDisplay)) exitWith {
                _id call CFUNC(removePerFrameHandler);
            };

            // If the timer is up enabled deploying
            if (diag_tickTime >= _respawnTime) exitWith {
                _control ctrlSetText "DEPLOY";
                _control ctrlEnable true;

                _id call CFUNC(removePerFrameHandler);
            };

            // Update the text on the button
            private _time = _respawnTime - diag_tickTime;
            _control ctrlSetText format ["%1.%2s", floor _time, floor ((_time % 1) * 10)];
        }, 0.1, [_control, diag_tickTime + ([QGVAR(RespawnSettings_respawnCountdown), 0] call CFUNC(getSetting))]] call CFUNC(addPerFrameHandler);
    } else {
        _control ctrlSetText "Close";
    };
}] call CFUNC(addEventHandler);

// Handle the deploy button
[UIVAR(RespawnScreen_DeployButton_action), {
    private _deploymentDisplay = uiNamespace getVariable [QGVAR(deploymentDisplay), displayNull];
    private _roleDisplay = uiNamespace getVariable [QGVAR(roleDisplay), displayNull];
    if (isNull _deploymentDisplay || isNull _roleDisplay) exitWith {};

    if (alive CLib_Player && !(CLib_Player getVariable [QEGVAR(Common,tempUnit), false])) exitWith {
        _deploymentDisplay closeDisplay 1;
    };

    // We use the mutex to prevent race conditions
    [{
        params ["_deploymentDisplay", "_roleDisplay"];

        // Check squad
        if (!((groupId group CLib_Player) in EGVAR(Squad,squadIds))) exitWith {
            [MLOC(JoinASquad)] call EFUNC(Common,displayNotification);
        };

        // Check kit
        private _currentRoleSelection = lnbCurSelRow (_roleDisplay displayCtrl 303);
        if (_currentRoleSelection < 0) exitWith {
            [MLOC(ChooseARole)] call EFUNC(Common,displayNotification);
        };

        // Check deployment
        private _controlDeploymentList = _deploymentDisplay displayCtrl 403;
        private _currentDeploymentPointSelection = lnbCurSelRow _controlDeploymentList;
        if (_currentDeploymentPointSelection < 0) exitWith {
            [MLOC(selectSpawn)] call EFUNC(Common,displayNotification);
        };

        // Get position
        _currentDeploymentPointSelection = [_controlDeploymentList, [_currentDeploymentPointSelection, 0]] call CFUNC(lnbLoad);
        private _deployPosition = [_currentDeploymentPointSelection] call EFUNC(Deployment,prepareSpawn);

        _deploymentDisplay closeDisplay 1;

        [{
            params ["_deployPosition"];

            // Spawn
            [AGLToASL ([_deployPosition, 5, 0, typeOf CLib_Player] call CFUNC(findSavePosition))] call EFUNC(Common,respawn);

            [{
                // Fix issue that player spawn Prone
                ["switchMove", [CLib_Player, ""]] call CFUNC(globalEvent);

                // Apply selected kit
                [CLib_Player getVariable [QEGVAR(Kit,kit), ""]] call EFUNC(Kit,applyKit);
            }] call CFUNC(execNextFrame);
        }, [_deployPosition]] call CFUNC(execNextFrame);
    }, [_deploymentDisplay, _roleDisplay], "respawn"] call CFUNC(mutex);
}] call CFUNC(addEventHandler);

// When the group changes the rally might change too so update the list
["groupChanged", {
    UIVAR(RespawnScreen_DeploymentManagement_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[QEGVAR(Deployment,pointAdded), {
    [UIVAR(RespawnScreen_DeploymentManagement_update), group CLib_Player] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);
[QEGVAR(Deployment,pointRemoved), {
    [UIVAR(RespawnScreen_DeploymentManagement_update), group CLib_Player] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);
[QEGVAR(Deployment,ticketsChanged), {
    [UIVAR(RespawnScreen_DeploymentManagement_update), group CLib_Player] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

// This EH updates the deployment list
[UIVAR(RespawnScreen_DeploymentManagement_update), {
    private _display = uiNamespace getVariable [QGVAR(deploymentDisplay), displayNull];
    if (isNull _display) exitWith {};

    // Prepare the data for the lnb
    private _lnbData = [];
    {
        (EGVAR(Deployment,pointStorage) getVariable _x) params ["_name", "_position", "_availableFor", "_tickets", "_icon"];
        if (_tickets > 0) then {
            _name = format ["%1 (%2)", _name, _tickets];
        };

        _lnbData pushBack [[_name], _x, _icon];
        nil
    } count (call EFUNC(Deployment,getAvailablePoints)); // TODO use current position if deployment is deactivated

    // Update the lnb
    [_display displayCtrl 403, _lnbData] call FUNC(updateListNBox); // This may trigger an lbSelChanged event
}] call CFUNC(addEventHandler);

// When the selected entry changed animate the map
[UIVAR(RespawnScreen_SpawnPointList_onLBSelChanged), {
    // TODO only animate if really changed
    UIVAR(RespawnScreen_DeploymentManagement_animateMap) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_DeploymentManagement_animateMap), {
    private _display = uiNamespace getVariable [QGVAR(deploymentDisplay), displayNull];
    if (isNull _display) exitWith {};

    // Get the selected value
    private _control = _display displayCtrl 403;
    private _selectedEntry = lnbCurSelRow _control;
    if (_selectedEntry == -1) exitWith {};
    private _selectedPoint = [_control, [_selectedEntry, 0]] call CFUNC(lnbLoad);

    // Get the point data
    private _pointDetails = EGVAR(Deployment,pointStorage) getVariable _selectedPoint;
    private _position = _pointDetails select 1;

    // Animate the map
    private _controlMap = _display displayCtrl 800;
    _controlMap ctrlMapAnimAdd [0.5, 0.15, _position]; // Dialog syntax can not be used
    ctrlMapAnimCommit _controlMap;
}] call CFUNC(addEventHandler);
