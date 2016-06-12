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

["sectorSideChanged", {
    (_this select 0) params ["_sector"];

    if (_sector isEqualTo GVAR(currentCameraTarget)) then {
        [QGVAR(updateCameraTarget)] call CFUNC(localEvent);
    };
}] call CFUNC(addEventHandler);

[QGVAR(initCamera), {
    [{
        GVAR(currentCameraTarget) = (format ["base_%1", playerSide]) call EFUNC(Sector,getSector);
        private _basePosition = getPos GVAR(currentCameraTarget);
        _basePosition set [2, 10];

        GVAR(camera) = "camera" camCreate _basePosition;
        GVAR(camera) cameraEffect ["INTERNAL", "BACK"];
        showCinemaBorder false;

        GVAR(updatePositionPFH) = [{
            private _targetPosition = getPos GVAR(currentCameraTarget);
            _targetPosition set [2, 10];

            private _currentPosition = getPos GVAR(camera);

            if ((_currentPosition distance _targetPosition) < 5) exitWith {
                [QGVAR(updateCameraTarget)] call CFUNC(localEvent);
            };

            private _vectorDiff = _targetPosition vectorDiff _currentPosition;
            private _newPosition = _currentPosition vectorAdd ((vectorNormalized _vectorDiff) vectorMultiply 5);
            _newPosition set [2, 10];

            GVAR(camera) camSetPos _newPosition;
            GVAR(camera) camCommit 1;
        }, 1] call CFUNC(addPerFrameHandler);
    }, {
        !isNil QEGVAR(Sector,ServerInitDone) && {EGVAR(Sector,ServerInitDone)}
    }] call CFUNC(waitUntil);
}] call CFUNC(addEventHandler);

[QGVAR(updateCameraTarget), {
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

        private _currentPosition = getPos GVAR(camera);
        private _currentCameraTargetPosition = getPos GVAR(currentCameraTarget);
        private _relativeVectorToTarget = _currentCameraTargetPosition vectorDiff _currentPosition;
        private _relativeVectorToCenter = [worldSize / 2, worldSize / 2, 0] vectorDiff _currentPosition;

        private _angleToTarget = (_relativeVectorToTarget select 0) atan2 (_relativeVectorToTarget select 1);
        private _angleToCenter = (_relativeVectorToCenter select 0) atan2 (_relativeVectorToCenter select 1);

        private _angleDiff = _angleToTarget - _angleToCenter;

        GVAR(camera) setDir ([_angleToTarget - 90, _angleToTarget + 90] select (_angleDiff < 0));
    };
}] call CFUNC(addEventHandler);

[QGVAR(destroyCamera), {
    GVAR(updatePositionPFH) call CFUNC(removePerFrameHandler);

    GVAR(camera) cameraEffect ["TERMINATE", "BACK"];
    camDestroy GVAR(camera);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onLoad), {
    showHUD [true,true,true,true,true,true,false,true];
    [UIVAR(RespawnScreen), true] call CFUNC(blurScreen);
    GVAR(selectedKit) = PRA3_Player getVariable [QEGVAR(Kit,kit),""];
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


}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onUnload), {
    showHUD [true,true,true,true,true,true,true,true];
    [UIVAR(RespawnScreen), false] call CFUNC(blurScreen);

    [QGVAR(destroyCamera)] call CFUNC(localEvent);
    if (PRA3_Player getVariable [QEGVAR(Kit,kit), ""] != GVAR(selectedKit)) then {
        PRA3_Player setVariable [QEGVAR(Kit,kit), GVAR(selectedKit), true];
        [UIVAR(RespawnScreen_SquadManagement_update), group PRA3_Player] call CFUNC(targetEvent);
        [UIVAR(RespawnScreen_RoleManagement_update), group PRA3_Player] call CFUNC(targetEvent);
    };

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
        GVAR(selectedKit) = PRA3_Player getVariable [QEGVAR(Kit,kit), ""];
        closeDialog 2;

        [{
            params ["_deployPosition"];
            // Spawn
            [playerSide, group PRA3_Player, _deployPosition] call CFUNC(respawn);

            // fix issue that player spawn Prone
            ["switchMove",[PRA3_Player, ""]] call CFUNC(globalEvent);

            // Apply selected kit
            //private _currentKitName = PRA3_Player getVariable [QEGVAR(Kit,kit), ""];
            [GVAR(selectedKit)] call EFUNC(Kit,applyKit);
        }, [_deployPosition]] call CFUNC(execNextFrame);


        GVAR(lastRespawnFrame) = diag_frameNo;


    }] call CFUNC(mutex);
}] call CFUNC(addEventHandler);
