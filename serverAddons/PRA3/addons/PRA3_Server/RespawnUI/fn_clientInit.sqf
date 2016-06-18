#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Init of respawn UI stuff.

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(RespawnSettings), missionConfigFile >> "PRA3" >> "CfgRespawn"] call CFUNC(loadSettings);

// When player dies show respawn UI
[QEGVAR(Revive,Killed), { //@todo this should work without the revive module (vanilla death)
    setPlayerRespawnTime 10e10; // Prevent respawn

    // Respawn screen may already open by user action
    if (dialog) then {
        closeDialog 2;
    };

    createDialog UIVAR(RespawnScreen);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onLoad), {
    showHUD [true, true, true, true, true, true, false, true];
    [UIVAR(RespawnScreen), true] call CFUNC(blurScreen);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onUnload), {
    showHUD [true,true,true,true,true,true,true,true];
    [UIVAR(RespawnScreen), false] call CFUNC(blurScreen);
}] call CFUNC(addEventHandler);

// Wait for the mission start first.
["missionStarted", {
    // Choose the initial side for the player before showing the respawn screen.
    [QGVAR(SideSelection)] call bis_fnc_startLoadingScreen;

    // We need a mutex to ensure the player detects the side with fewest players correctly
    [{
        50 call bis_fnc_progressLoadingScreen;

        // Calculate the side with fewest players
        private _leastPlayerSide = sideUnknown;
        private _leastPlayerCount = 999;
        {
            private _side = call compile _x;
            private _playerCount = {side group _x == _side} count allPlayers;
            if (_playerCount < _leastPlayerCount) then {
                _leastPlayerSide = _side;
                _leastPlayerCount = _playerCount;
            };
            nil
        } count EGVAR(Mission,competingSides);

        // Move the player to the side as temporary unit
        PRA3_Player setVariable [QCGVAR(tempUnit), true];
        [_leastPlayerSide, createGroup _leastPlayerSide, [-1000, -1000, 10], true] call CFUNC(respawn);

        // Open the respawn UI
        [QGVAR(SideSelection)] call bis_fnc_endLoadingScreen;

        createDialog UIVAR(RespawnScreen);
    }, [], "respawn"] call CFUNC(mutex);

//    ["Respawn Screen", PRA3_Player, 0, {!dialog}, {
//        createDialog UIVAR(RespawnScreen);
//    }] call CFUNC(addAction);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onLoad), {
    // Load the different screens
    UIVAR(TeamInfoScreen_onLoad) call CFUNC(localEvent);
    UIVAR(SquadScreen_onLoad) call CFUNC(localEvent);
    UIVAR(RoleScreen_onLoad) call CFUNC(localEvent);
    UIVAR(DeploymentScreen_onLoad) call CFUNC(localEvent);

    // The dialog needs one frame until access to controls is possible
    [{
        // Register the map for the marker system
        [(findDisplay 1000  displayCtrl 700)] call CFUNC(registerMapControl);

        // Fade the button in, calculate the respawn timer if necessary
        //@todo move the button into deployment #222
        500 call FUNC(fadeControl);
        if (!(alive PRA3_Player) || (PRA3_Player getVariable [QCGVAR(tempUnit), false])) then {
            // Catch the escape key
            (findDisplay 1000) displayAddEventHandler ["KeyDown", FUNC(showDisplayInterruptEH)];

            // Disable the button and start the timer
            (findDisplay 1000 displayCtrl 500) ctrlEnable false;
            [{
                params ["_respawnTime", "_id"];

                // If the dialog has closed exit the PFH
                if (!dialog) exitWith {
                    _id call CFUNC(removePerFrameHandler);
                };

                // If the timer is up enabled deploying
                if (diag_tickTime >= _respawnTime) exitWith {
                    (findDisplay 1000 displayCtrl 500) ctrlSetText "DEPLOY";
                    (findDisplay 1000 displayCtrl 500) ctrlEnable true;

                    _id call CFUNC(removePerFrameHandler);
                };

                // Update the text on the button
                private _time = _respawnTime - diag_tickTime;
                (findDisplay 1000  displayCtrl 500) ctrlSetText format ["%1.%2s", floor _time, floor ((_time % 1) * 10)];
            }, 0.1, diag_tickTime + ([QGVAR(RespawnSettings_respawnCountdown), 0] call CFUNC(getSetting))] call CFUNC(addPerFrameHandler);
        } else {
            (findDisplay 1000  displayCtrl 500) ctrlSetText "Close";
        };

        // The right background
        // @todo move the backgrounds in the sub screens #223
        601 call FUNC(fadeControl); // left
        602 call FUNC(fadeControl); // right
        603 call FUNC(fadeControl); // header (left)
    }] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

// Handle the deploy button
GVAR(lastRespawnFrame) = 0; //@todo remove this with #29
[UIVAR(RespawnScreen_DeployButton_action), {
    if (alive PRA3_Player && !(PRA3_Player getVariable [QCGVAR(tempUnit), false])) exitWith {
        closeDialog 1;
    };

    // We use the mutex to prevent race conditions
    [{
        if (diag_frameNo == GVAR(lastRespawnFrame)) exitWith {}; //@todo remove this with #29

        // Check squad
        if (!((groupId group PRA3_Player) in EGVAR(Squad,squadIds))) exitWith {
            ["You have to join a squad!"] call CFUNC(displayNotification);
        };

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

        // Check tickets
        _currentDeploymentPointSelection = [403, [_currentDeploymentPointSelection, 0]] call CFUNC(lnbLoad);
        EGVAR(Deployment,deploymentPoints) params ["_pointIds", "_pointData"];
        private _pointDetails = _pointData select (_pointIds find _currentDeploymentPointSelection);
        private _tickets = _pointDetails select 2;
        private _deployPosition = _pointDetails select 3;
        if (_tickets == 0) exitWith {
            ["Spawn point has no tickets left!"] call CFUNC(displayNotification);
        };

        // Reduce ticket of deployment point because we spawn there
        //@todo rewrite with #178
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

        closeDialog 1;

        [{
            params ["_deployPosition"];

            // Spawn
            [playerSide, group PRA3_Player, _deployPosition] call CFUNC(respawn);

            // Fix issue that player spawn Prone
            ["switchMove", [PRA3_Player, ""]] call CFUNC(globalEvent);

            // Apply selected kit
            [PRA3_Player getVariable [QEGVAR(Kit,kit), ""]] call EFUNC(Kit,applyKit);
        }, [_deployPosition]] call CFUNC(execNextFrame);

        GVAR(lastRespawnFrame) = diag_frameNo;
    }, [], "respawn"] call CFUNC(mutex);
}] call CFUNC(addEventHandler);
