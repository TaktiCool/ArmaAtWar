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

["playerSideChanged", {
    if (!dialog) exitWith {};

    [QGVAR(destroyCamera)] call CFUNC(localEvent);
    [QGVAR(initCamera)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[QGVAR(initCamera), {
    [{
        GVAR(currentCameraTarget) = (format ["base_%1", playerSide]) call EFUNC(Sector,getSector);
        private _basePosition = getPos GVAR(currentCameraTarget);
        _basePosition set [2, 10];

        GVAR(camera) = "camera" camCreate _basePosition;
        GVAR(camera) cameraEffect ["INTERNAL", "BACK"];
        showCinemaBorder false;

        private _calculateTargetPFH = [{
            private _possibleTargets = (EGVAR(Sector,allSectorsArray) select {
                GVAR(currentCameraTarget) in (
                    (_x getVariable ["dependency", []]) apply {
                        _x call EFUNC(Sector,getSector)
                    }
                )
            }) select {
                _x getVariable ["side", sideUnknown] == playerSide
            };

            if (!(_possibleTargets isEqualTo [])) then {
                GVAR(currentCameraTarget) = selectRandom _possibleTargets;
            };
        }, 60] call CFUNC(addPerFrameHandler);

        private _updatePositionPFH = [{
            private _targetPosition = getPos GVAR(currentCameraTarget);
            _targetPosition set [2, 10];

            private _currentPosition = getPos GVAR(camera);

            if (_currentPosition isEqualTo _targetPosition) exitWith {};

            private _vectorDiff = _targetPosition vectorDiff _currentPosition;
            private _newPosition = _currentPosition vectorAdd (vectorNormalized _vectorDiff);
            _newPosition set [2, 10];

            GVAR(camera) camSetPos _newPosition;
            GVAR(camera) camCommit 1;
        }, 1] call CFUNC(addPerFrameHandler);

        GVAR(cameraPFHs) = [_calculateTargetPFH, _updatePositionPFH];
    }, {
        !isNil QEGVAR(Sector,sectorCreationDone)
    }] call CFUNC(waitUntil);
}] call CFUNC(addEventHandler);

[QGVAR(destroyCamera), {
    {
        _x call CFUNC(removePerFrameHandler);
        nil
    } count GVAR(cameraPFHs);

    GVAR(camera) cameraEffect ["TERMINATE", "BACK"];
    camDestroy GVAR(camera);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onLoad), {
    showHUD [true,true,true,true,true,true,false,true];
    [UIVAR(RespawnScreen), true] call CFUNC(blurScreen);

    // The dialog needs one frame until access to controls via IDC is possible
    [{
        UIVAR(RespawnScreen_TeamInfo_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_SquadManagement_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_RoleManagement_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_DeploymentManagement_update) call CFUNC(localEvent);
        [{
            [(findDisplay 1000  displayCtrl 700)] call CFUNC(registerMapControl);
        }, {!(isNull (findDisplay 1000 displayCtrl 700))}] call CFUNC(waitUntil);

    }] call CFUNC(execNextFrame);

    [QGVAR(initCamera)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onUnload), {
    showHUD [true,true,true,true,true,true,true,true];
    [UIVAR(RespawnScreen), false] call CFUNC(blurScreen);

    [QGVAR(destroyCamera)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

GVAR(lastRespawnFrame) = 0;
[UIVAR(RespawnScreen_DeployButton_action), {
    // Check squad
    if (!((groupId group PRA3_Player) in EGVAR(Squad,squadIds))) exitWith {
        ["Join a squad!"] call CFUNC(displayNotification);
    };

    // Check role
    [{
        if (diag_frameNo == GVAR(lastRespawnFrame)) exitWith {};

        // Check kit
        private _currentRoleSelection = lnbCurSelRow 303;
        if (_currentRoleSelection < 0) exitWith {
            ["Select a role!"] call CFUNC(displayNotification);
        };

        // Check deployment
        private _currentDeploymentPointSelection = lnbCurSelRow 403;
        if (_currentDeploymentPointSelection < 0) exitWith {
            ["Select spawn point!"] call CFUNC(displayNotification);
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
        };

        // Spawn
        [playerSide, group PRA3_Player, _deployPosition] call CFUNC(respawn);

        // fix issue that player spawn Prone
        ["switchMove",[PRA3_Player, ""]] call CFUNC(globalEvent);

        // Apply selected kit
        private _currentKitName = PRA3_Player getVariable [QEGVAR(Kit,kit), ""];
        [_currentKitName] call EFUNC(Kit,applyKit);

        GVAR(lastRespawnFrame) = diag_frameNo;

        closeDialog 2;
    }] call CFUNC(mutex);
}] call CFUNC(addEventHandler);
