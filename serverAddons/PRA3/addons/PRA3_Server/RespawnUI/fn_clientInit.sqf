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
            private _side = _x;
            private _playerCount = {side group _x == _side} count allPlayers;
            if (_playerCount < _leastPlayerCount) then {
                _leastPlayerSide = _side;
                _leastPlayerCount = _playerCount;
            };
            nil
        } count EGVAR(Mission,competingSides);

        // Move the player to the side as temporary unit
        PRA3_Player setVariable [QCGVAR(tempUnit), true];
        [[-1000, -1000, 10], _leastPlayerSide] call CFUNC(respawn);

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

        //Update the MissionName Text
        (findDisplay 1000  displayCtrl 604) ctrlSetStructuredText parseText format ["%1", getText (missionConfigFile >> "onLoadMission")];

        //Update Tickets
        private _startTickets = getNumber(missionConfigFile >> "PRA3" >> "tickets");
        (findDisplay 1000 displayCtrl 801) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,Flag_%1),EGVAR(Mission,competingSides) select 0],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
        (findDisplay 1000 displayCtrl 803) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,sideName_%1),EGVAR(Mission,competingSides) select 0],""]);
        (findDisplay 1000 displayCtrl 805) ctrlSetText str (missionNamespace getVariable [format [QEGVAR(Tickets,sideTickets_%1),EGVAR(Mission,competingSides) select 0],_startTickets]);
        (findDisplay 1000 displayCtrl 802) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,Flag_%1),EGVAR(Mission,competingSides) select 1],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
        (findDisplay 1000 displayCtrl 804) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,sideName_%1),EGVAR(Mission,competingSides) select 1],""]);
        (findDisplay 1000 displayCtrl 806) ctrlSetText str (missionNamespace getVariable [format [QEGVAR(Tickets,sideTickets_%1),EGVAR(Mission,competingSides) select 1],_startTickets]);

        {
            (findDisplay 1000 displayCtrl _x) ctrlCommit 0;
            nil;
        } count [801,802,803,804,805,806];

        // The right background
        // @todo move the backgrounds in the sub screens #223
        601 call FUNC(fadeControl); // left
        602 call FUNC(fadeControl); // right
        603 call FUNC(fadeControl); // header (left)
        604 call FUNC(fadeControl); // MissionName
        800 call FUNC(fadeControl); // MissionName
    }] call CFUNC(execNextFrame);


}] call CFUNC(addEventHandler);

["ticketsChanged", {
    disableSerialization;
    if (isNull findDisplay 1000) exitWith {};
    if (GVAR(deactivateTicketSystem)) exitWith {};
    private _startTickets = getNumber(missionConfigFile >> "PRA3" >> "tickets");
    (findDisplay 1000 displayCtrl 801) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,Flag_%1),EGVAR(Mission,competingSides) select 0],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
    (findDisplay 1000 displayCtrl 803) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,sideName_%1),EGVAR(Mission,competingSides) select 0],""]);
    (findDisplay 1000 displayCtrl 805) ctrlSetText str (missionNamespace getVariable [format [QEGVAR(Tickets,sideTickets_%1),EGVAR(Mission,competingSides) select 0],_startTickets]);
    (findDisplay 1000 displayCtrl 802) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,Flag_%1),EGVAR(Mission,competingSides) select 1],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
    (findDisplay 1000 displayCtrl 804) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,sideName_%1),EGVAR(Mission,competingSides) select 1],""]);
    (findDisplay 1000 displayCtrl 806) ctrlSetText str (missionNamespace getVariable [format [QEGVAR(Tickets,sideTickets_%1),EGVAR(Mission,competingSides) select 1],_startTickets]);

    {
        (findDisplay 1000 displayCtrl _x) ctrlCommit 0;
        nil;
    } count [801,802,803,804,805,806];
}] call CFUNC(addEventHandler);

// alternative notification Display
["notificationDisplayed", {
    disableSerialization;
    private _display = findDisplay 1000;
    if (isNull _display) exitWith {};
    (_this select 0) params ["_priority", "_timeAdded", "_text", "_color", "_time", "_condition"];



    private _groupPos = ctrlPosition (_display displayCtrl 4000);
    private _oldGroupPos = +_groupPos;
    _groupPos set [0, 0.5];
    _groupPos set [2, 0];
    (_display displayCtrl 4000) ctrlSetPosition _groupPos;


    private _bgPos = ctrlPosition (_display displayCtrl 4001);
    _bgPos set [0, -(_bgPos select 2)/2];
    (_display displayCtrl 4001) ctrlSetPosition _bgPos;
    _bgPos set [0, 0];

    private _txtPos = ctrlPosition (_display displayCtrl 4002);
    _txtPos set [0, -(_txtPos select 2)/2];
    (_display displayCtrl 4002) ctrlSetPosition _txtPos;
    _txtPos set [0, 0];
    (_display displayCtrl 4001) ctrlSetTextColor _color;

    (_display displayCtrl 4002) ctrlSetStructuredText parseText format ["%1",_text];
    (_display displayCtrl 4000) ctrlCommit 0;
    (_display displayCtrl 4001) ctrlCommit 0;
    (_display displayCtrl 4002) ctrlCommit 0;

    (_display displayCtrl 4000) ctrlSetPosition _oldGroupPos;
    (_display displayCtrl 4000) ctrlSetFade 0;
    (_display displayCtrl 4000) ctrlShow true;
    (_display displayCtrl 4001) ctrlSetPosition _bgPos;
    (_display displayCtrl 4002) ctrlSetPosition _txtPos;
    (_display displayCtrl 4000) ctrlCommit 0.2;
    (_display displayCtrl 4001) ctrlCommit 0.2;
    (_display displayCtrl 4002) ctrlCommit 0.2;
}] call CFUNC(addEventHandler);

["notificationHidden", {
    disableSerialization;
    private _display = findDisplay 1000;
    if (isNull _display) exitWith {};
    (_display displayCtrl 4000) ctrlSetFade 1;
    (_display displayCtrl 4000) ctrlShow false;
    (_display displayCtrl 4002) ctrlCommit 0.2;
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
            [_deployPosition] call CFUNC(respawn);

            // Fix issue that player spawn Prone
            ["switchMove", [PRA3_Player, ""]] call CFUNC(globalEvent);

            // Apply selected kit
            [PRA3_Player getVariable [QEGVAR(Kit,kit), ""]] call EFUNC(Kit,applyKit);
        }, [_deployPosition]] call CFUNC(execNextFrame);

        GVAR(lastRespawnFrame) = diag_frameNo;
    }, [], "respawn"] call CFUNC(mutex);
}] call CFUNC(addEventHandler);
