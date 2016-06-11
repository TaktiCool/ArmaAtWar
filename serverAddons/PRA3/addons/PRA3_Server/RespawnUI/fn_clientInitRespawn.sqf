#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author:

    Description:
    [Description]

    Parameter(s):
    None

    Returns:
    None
*/
[UIVAR(RespawnScreen_onLoad), {
    // The dialog needs one frame until access to controls is possible
    [{
        UIVAR(RespawnScreen_TeamInfo_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_NewSquadDesignator_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_SquadManagement_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_SquadMemberButtons_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_RoleManagement_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_DeploymentManagement_update) call CFUNC(localEvent);

        [(findDisplay 1000  displayCtrl 700)] call CFUNC(registerMapControl);

        if (!(alive PRA3_Player) || (PRA3_Player getVariable [QCGVAR(tempUnit), false])) then {
            (findDisplay 1000) displayAddEventHandler ["KeyDown", FUNC(showDisplayInterruptEH)];
        };

        (findDisplay 1000 displayCtrl 500) ctrlEnable false;
        [{
            params ["_respawnTime", "_id"];

            if (!dialog) exitWith {
                _id call CFUNC(removePerFrameHandler);
            };

            if (diag_tickTime >= _respawnTime) exitWith {
                (findDisplay 1000 displayCtrl 500) ctrlSetText "DEPLOY";
                (findDisplay 1000 displayCtrl 500) ctrlEnable true;

                _id call CFUNC(removePerFrameHandler);
            };

            private _time = _respawnTime - diag_tickTime;
            (findDisplay 1000  displayCtrl 500) ctrlSetText format ["%1.%2 s", floor _time, floor ((_time % 1) * 10)];
        }, 0.1, diag_tickTime + ([QGVAR(RespawnSettings_respawnCountdown), 0] call CFUNC(getSetting))] call CFUNC(addPerFrameHandler);

        {
            private _pos = ctrlPosition (findDisplay 1000  displayCtrl _x);
            _pos set [0, (_pos select 0) - PX(40)];
            (findDisplay 1000  displayCtrl _x) ctrlSetPosition _pos;
            (findDisplay 1000  displayCtrl _x) ctrlCommit 0;
            nil;
        } count [100,200,601,603];

        {
            private _pos = ctrlPosition (findDisplay 1000  displayCtrl _x);
            _pos set [0, (_pos select 0) + PX(40)];
            (findDisplay 1000  displayCtrl _x) ctrlSetPosition _pos;
            (findDisplay 1000  displayCtrl _x) ctrlCommit 0;
            nil;
        } count [300,400,500,602];

        [{
            {
                private _pos = ctrlPosition (findDisplay 1000  displayCtrl _x);
                _pos set [0, (_pos select 0) + PX(40)];
                (findDisplay 1000  displayCtrl _x) ctrlSetPosition _pos;
                (findDisplay 1000  displayCtrl _x) ctrlSetFade 0;
                (findDisplay 1000  displayCtrl _x) ctrlCommit 0.5;
                nil;
            } count [100,200,601,603];

            {
                private _pos = ctrlPosition (findDisplay 1000  displayCtrl _x);
                _pos set [0, (_pos select 0) - PX(40)];
                (findDisplay 1000  displayCtrl _x) ctrlSetPosition _pos;
                (findDisplay 1000  displayCtrl _x) ctrlSetFade 0;
                (findDisplay 1000  displayCtrl _x) ctrlCommit 0.5;
                nil;
            } count [300,400,500,602];

        }] call CFUNC(execNextFrame);

    }] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

GVAR(lastRespawnFrame) = 0;
[UIVAR(RespawnScreen_DeployButton_action), {
    // Check squad
    if (!((groupId group PRA3_Player) in EGVAR(Squad,squadIds))) exitWith {
        ["You have to join a squad!"] call CFUNC(displayNotification);
    };

    // Check role
    [{
        if (diag_frameNo == GVAR(lastRespawnFrame)) exitWith {};

        // Check kit
        private _currentRoleSelection = lnbCurSelRow 303;
        if (_currentRoleSelection < 0) exitWith {
            ["You have to select a role!"] call CFUNC(displayNotification);
        };

        // Check deployment
        private _currentDeploymentPointSelection = lnbCurSelRow 403;
        if (_currentDeploymentPointSelection < 0) exitWith {
            ["You have to select a spawnpoint!"] call CFUNC(displayNotification);
        };
        _currentDeploymentPointSelection = [403, [_currentDeploymentPointSelection, 0]] call CFUNC(lnbLoad);
        EGVAR(Deployment,deploymentPoints) params ["_pointIds", "_pointData"];
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
                [group PRA3_Player] call EFUNC(Deployment,destroyRally);
            } else {
                publicVariable QEGVAR(Deployment,deploymentPoints);
            };
            [UIVAR(RespawnScreen_DeploymentManagement_update), group PRA3_Player] call CFUNC(targetEvent);
            [QEGVAR(Deployment,updateMapIcons), group PRA3_Player] call CFUNC(targetEvent);
        };

        closeDialog 2;

        [{
            params ["_deployPosition"];
            // Spawn
            [playerSide, group PRA3_Player, _deployPosition] call CFUNC(respawn);

            // fix issue that player spawn Prone
            ["switchMove",[PRA3_Player, ""]] call CFUNC(globalEvent);

            // Apply selected kit
            //private _currentKitName = PRA3_Player getVariable [QEGVAR(Kit,kit), ""];
            [PRA3_Player getVariable [QEGVAR(Kit,kit), ""]] call EFUNC(Kit,applyKit);
        }, [_deployPosition]] call CFUNC(execNextFrame);


        GVAR(lastRespawnFrame) = diag_frameNo;


    }] call CFUNC(mutex);
}] call CFUNC(addEventHandler);
