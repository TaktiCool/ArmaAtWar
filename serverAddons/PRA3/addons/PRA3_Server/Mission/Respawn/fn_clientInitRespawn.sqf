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

DFUNC(escapeFnc) =  {
    params ["", "_key"];
    private _ret = false;

    if (_key == 1) then {
        createDialog (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);

        disableSerialization;

        private _dlg = findDisplay 49;

        for "_index" from 100 to 2000 do {
            (_dlg displayCtrl _index) ctrlEnable false;
        };

        private _ctrl = _dlg displayctrl 103;
        _ctrl ctrlSetEventHandler ["buttonClick", {
            closeDialog 0;
            failMission "LOSER";
        }];
        _ctrl ctrlEnable true;
        _ctrl ctrlSetText "ABORT";
        _ctrl ctrlSetTooltip "Abort.";


        /*
        _ctrl = _dlg displayctrl ([104, 1010] select isMultiplayer);
        _ctrl ctrlEnable false;
        _ctrl ctrlSetText "RESPAWN";
        _ctrl ctrlSetTooltip "Respawn.";
        _ret = true;
*/
        _ret = true;
    };

    _ret;
};

["missionStarted", {
    private _sidePlayerCount = GVAR(competingSides) apply {
        private _side = call compile _x;
        [{side group _x == _side} count (allUnits + allDeadMen), _side] //@todo use allPlayers when no AI needed
    };
    _sidePlayerCount sort true;
    private _newSide = _sidePlayerCount select 0 select 1;

    PRA3_Player setVariable [QGVAR(tempUnit), true];
    [_newSide, createGroup _newSide, [-1000, -1000, 10], true] call FUNC(respawn);

    createDialog UIVAR(RespawnScreen);
    (findDisplay 1000) displayAddEventHandler ["KeyDown", DFUNC(escapeFnc)];


}] call CFUNC(addEventHandler);

["Killed", {
    setPlayerRespawnTime 10e10;
    createDialog UIVAR(RespawnScreen);
    (findDisplay 1000) displayAddEventHandler ["KeyDown", DFUNC(escapeFnc)];
}] call CFUNC(addEventHandler);

/*
 * UI STUFF
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
    }, _display] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onUnload), {
    showHUD [true,true,true,true,true,true,true,true];

    [UIVAR(RespawnScreen), false] call CFUNC(blurScreen);
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

GVAR(lastRespawnFrame) = 0;
[UIVAR(RespawnScreen_DeployButton_action), {
    // Check squad
    if (!((groupId group PRA3_Player) in GVAR(squadIds))) exitWith {
        ["Join a squad!"] call CFUNC(displayNotification);
    };

    // Check role
    [{
        if (diag_frameNo == GVAR(lastRespawnFrame)) exitWith {};

        private _currentRoleSelection = lnbCurSelRow 303;
        if (_currentRoleSelection < 0) exitWith {
            ["Select a role!"] call CFUNC(displayNotification);
        };
        private _currentKitName = PRA3_Player getVariable [QGVAR(kit), ""];
        private _kitName = [303, [_currentRoleSelection, 0]] call CFUNC(lnbLoad);
        private _usedKits = {(_x getVariable [QGVAR(kit), ""]) == _kitName} count units group PRA3_Player;
        if ([_kitName] call FUNC(getUsableKitCount) <= ([_usedKits, _usedKits - 1] select (_kitName == _currentKitName))) exitWith {
            ["Select another role!"] call CFUNC(displayNotification);
        };

        // Check deployment
        private _currentDeploymentPointSelection = lnbCurSelRow 403;
        if (_currentDeploymentPointSelection < 0) exitWith {
            ["Select spawn point!"] call CFUNC(displayNotification);
        };
        _currentDeploymentPointSelection = [403, [_currentDeploymentPointSelection, 0]] call CFUNC(lnbLoad);
        GVAR(deploymentPoints) params ["_pointIds", "_pointData"];
        private _pointDetails = _pointData select (_pointIds find _currentDeploymentPointSelection);
        private _tickets = _pointDetails select 2;
        private _deployPosition = _pointDetails select 3;
        if (_tickets == 0) exitWith {
            ["Spawn point has no tickets left!"] call CFUNC(displayNotification);
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

        // fix issue that player spawn Prone
        ["switchMove",[PRA3_Player, ""]] call CFUNC(globalEvent);

        // Apply selected kit
        [_kitName] call FUNC(applyKit);
        [UIVAR(RespawnScreen_RoleManagement_update), group PRA3_Player] call CFUNC(targetEvent);

        GVAR(lastRespawnFrame) = diag_frameNo;

        closeDialog 2;
    }] call CFUNC(mutex);
}] call CFUNC(addEventHandler);
