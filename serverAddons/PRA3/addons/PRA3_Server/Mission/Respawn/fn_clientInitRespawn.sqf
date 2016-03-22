#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    -

    Returns:
    -
*/

[UIVAR(RespawnScreen_onLoad), {
    showHUD [true,true,true,true,true,true,false,true];

    [UIVAR(RespawnScreen), true] call CFUNC(blurScreen);

    // The dialog needs one frame until access to controls via IDC is possible
    [{
        [UIVAR(RespawnScreen_TeamInfo_update)] call CFUNC(localEvent);
        [UIVAR(RespawnScreen_SquadManagement_update)] call CFUNC(localEvent);
        [UIVAR(RespawnScreen_RoleManagement_update)] call CFUNC(localEvent);
        [UIVAR(RespawnScreen_DeploymentManagement_update)] call CFUNC(localEvent);
    }] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onUnload), {
    showHUD [true,true,true,true,true,true,true,true];

    [UIVAR(RespawnScreen), false] call CFUNC(blurScreen);
}] call CFUNC(addEventHandler);

["Killed", {
    setPlayerRespawnTime 10e10;
    createDialog UIVAR(RespawnScreen);
}] call CFUNC(addEventHandler);

["groupChanged", {
    _this select 0 params ["_newGroup", "_oldGroup"];

    [UIVAR(RespawnScreen_SquadManagement_update)] call CFUNC(globalEvent);
    [UIVAR(RespawnScreen_RoleManagement_update), [_newGroup, _oldGroup]] call CFUNC(targetEvent);
    [UIVAR(RespawnScreen_DeploymentManagement_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

["playerSideChanged", {
    [UIVAR(RespawnScreen_TeamInfo_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

["leaderChanged", {
    [UIVAR(RespawnScreen_SquadManagement_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_DeployButton_action), {
    // Check squad
    if (!((groupId group PRA3_Player) in GVAR(squadIds))) exitWith {systemChat "Join a squad!"};

    // Check role
    [{
        private _currentRoleSelection = lnbCurSelRow 303;
        if (_currentRoleSelection < 0) exitWith {systemChat "Select a role!"};
        private _currentKitName = PRA3_Player getVariable [QGVAR(kit), ""];
        private _kitName = [303, [_currentRoleSelection, 0]] call CFUNC(lnbLoad);
        private _usedKits = {(_x getVariable [QGVAR(kit), ""]) == _kitName} count units group PRA3_Player;
        if ([_kitName] call FUNC(getUsableKitCount) <= ([_usedKits, _usedKits - 1] select (_kitName == _currentKitName))) exitWith {systemChat "Select another role!"};

        // Check deployment
        private _currentDeploymentPointSelection = lnbCurSelRow 403;
        if (_currentDeploymentPointSelection < 0) exitWith {systemChat "Select spawn point!"};
        _currentDeploymentPointSelection = [403, [_currentDeploymentPointSelection, 0]] call CFUNC(lnbLoad);
        GVAR(deploymentPoints) params ["_pointIds", "_pointData"];
        private _pointDetails = _pointData select (_pointIds find _currentDeploymentPointSelection);
        private _tickets = _pointDetails select 2;
        private _deployPosition = _pointDetails select 3;
        if (_tickets == 0) exitWith {
            systemChat "Spawn point has no tickets left!";
        };
        if (_tickets > 0) then {
            _tickets = _tickets - 1;
            _pointDetails set [2, _tickets];
            if (_tickets == 0) then {
                [group PRA3_Player] call FUNC(destroyRally);
            } else {
                publicVariable QGVAR(deploymentPoints);
            };
            [UIVAR(RespawnScreen_DeploymentManagement_update), group PRA3_Player] call CFUNC(targetEvent);
        };

        // Spawn
        [playerSide, group PRA3_Player, _deployPosition] call FUNC(respawn);

        // Apply selected kit
        [_kitName] call FUNC(applyKit);
        [UIVAR(RespawnScreen_RoleManagement_update), group PRA3_Player] call CFUNC(targetEvent);

        closeDialog 2;
    }] call CFUNC(mutex);
}] call CFUNC(addEventHandler);