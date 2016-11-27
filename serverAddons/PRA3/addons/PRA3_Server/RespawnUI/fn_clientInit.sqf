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
[QGVAR(RespawnSettings), missionConfigFile >> QPREFIX >> "CfgRespawn"] call CFUNC(loadSettings);

// When player dies show respawn UI
["Killed", {
    [[-10000, -10000, 50], true] call EFUNC(Common,respawn);

    [{
        // Respawn screen may already open by user action
        if (!(isNull (uiNamespace getVariable [QGVAR(respawnDisplay), displayNull]))) exitWith {
            [UIVAR(RespawnScreen_onLoad), GVAR(respawnDisplay)] call CFUNC(localEvent);
        };

        (findDisplay 46) createDisplay UIVAR(RespawnScreen);
    }] call CFUNC(execNextFrame);
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
        } count EGVAR(Common,competingSides);

        // Move the player to the side
        private _initialUnit = CLib_Player;
        [[-1000, -1000, 10], _leastPlayerSide] call EFUNC(Common,respawnNewSide);
        deleteVehicle _initialUnit;

        [QGVAR(SideSelection)] call bis_fnc_endLoadingScreen;

        // Open the respawn UI
        (findDisplay 46) createDisplay UIVAR(RespawnScreen);
    }, [], "respawn"] call CFUNC(mutex);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onLoad), {
    (_this select 0) params ["_display"];

    [_display, "RespawnUIHeader", [safeZoneX, safeZoneY]] call CFUNC(createFromTemplate);
    [_display, "RespawnUISquadHeader", [safeZoneX + PX(4), safeZoneY + PY(12.5)]] call CFUNC(createFromTemplate);
    uiNamespace setVariable [QGVAR(respawnDisplay), _display];

    // Load the different screens
    [UIVAR(TeamInfoScreen_onLoad), _display] call CFUNC(localEvent);
    [UIVAR(SquadScreen_onLoad), _display] call CFUNC(localEvent);
    [UIVAR(RoleScreen_onLoad), _display] call CFUNC(localEvent);
    [UIVAR(DeploymentScreen_onLoad), _display] call CFUNC(localEvent);

    // The dialog needs one frame until access to controls is possible
    [{
        params ["_display"];

        // Register the map for the marker system
        [_display displayCtrl 800] call CFUNC(registerMapControl);

        private _control = uiNamespace getVariable UIVAR(MissionType);



        if (!(alive CLib_Player) || (CLib_Player getVariable [QEGVAR(Common,tempUnit), false])) then {
            // Catch the escape key
            _display displayAddEventHandler ["KeyDown", FUNC(showDisplayInterruptEH)];
        };

        // Update the MissionName Text
        private _missionName = getText (missionConfigFile >> "onLoadMission");

        // Update Tickets
        private _startTickets = getNumber (missionConfigFile >> QPREFIX >> "tickets");
        private _firstSide = EGVAR(Common,competingSides) select 0;
        private _secondSide = EGVAR(Common,competingSides) select 1;

        (uiNamespace getVariable UIVAR(MissionName)) ctrlSetStructuredText parseText format ["<t size='%1' align='right' shadow='0'>%2</t>", PY(2.4)/0.035*1.3,_missionName];
        (uiNamespace getVariable UIVAR(MissionType)) ctrlSetStructuredText parseText format ["<t size='%1' align='right' shadow='0'>Advance &amp; Secure</t>", PY(1.6)/0.035*1.3];

        (uiNamespace getVariable UIVAR(SquadHeaderText)) ctrlSetStructuredText parseText format ["<t size='%1' align='center' shadow='0'>JOIN OR CREATE A SQUAD</t>", PY(1.6)/0.035*1.3];

    }, _display] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

["ticketsChanged", {
    private _display = uiNamespace getVariable [QGVAR(respawnDisplay), displayNull];
    if (isNull _display || EGVAR(Tickets,deactivateTicketSystem)) exitWith {};

    private _startTickets = getNumber(missionConfigFile >> QPREFIX >> "tickets");
    /*
    (_display displayCtrl 605) ctrlSetText str (missionNamespace getVariable [format [QEGVAR(Tickets,sideTickets_%1), EGVAR(Common,competingSides) select 0], _startTickets]);
    (_display displayCtrl 606) ctrlSetText str (missionNamespace getVariable [format [QEGVAR(Tickets,sideTickets_%1), EGVAR(Common,competingSides) select 1], _startTickets]);

    {
        (_display displayCtrl _x) ctrlCommit 0;
        nil;
    } count [605, 606];
    */
}] call CFUNC(addEventHandler);

// Alternative notification display
["notificationDisplayed", {
    private _display = uiNamespace getVariable [QGVAR(respawnDisplay), displayNull];
    if (isNull _display || dialog) exitWith {};

    (_this select 0) params ["_priority", "_timeAdded", "_text", "_color", "_time", "_condition"];

    // Center and zero width
    private _controlGroup = _display displayCtrl 700;
    private _groupPos = ctrlPosition _controlGroup;
    private _oldGroupPos = +_groupPos;
    _groupPos set [0, 0.5];
    _groupPos set [2, 0];
    _controlGroup ctrlSetPosition _groupPos;

    // Background
    private _controlBackground = _display displayCtrl 799;
    _controlBackground ctrlSetTextColor _color;
    private _bgPos = ctrlPosition _controlBackground;
    _bgPos set [0, -(_bgPos select 2) / 2];
    _controlBackground ctrlSetPosition _bgPos;
    _bgPos set [0, 0];

    // Text
    private _controlText = _display displayCtrl 701;
    _controlText ctrlSetStructuredText parseText format ["%1",_text];
    private _txtPos = ctrlPosition _controlText;
    _txtPos set [0, -(_txtPos select 2) / 2];
    _controlText ctrlSetPosition _txtPos;
    _txtPos set [0, 0];

    // Commit initial positions
    _controlGroup ctrlCommit 0;
    _controlBackground ctrlCommit 0;
    _controlText ctrlCommit 0;

    // Prepare animation
    _controlGroup ctrlSetPosition _oldGroupPos;
    _controlGroup ctrlSetFade 0;
    _controlGroup ctrlShow true;
    _controlBackground ctrlSetPosition _bgPos;
    _controlText ctrlSetPosition _txtPos;

    // Commit animation
    _controlGroup ctrlCommit 0.2;
    _controlBackground ctrlCommit 0.2;
    _controlText ctrlCommit 0.2;
}] call CFUNC(addEventHandler);

["notificationHidden", {
    private _display = uiNamespace getVariable [QGVAR(respawnDisplay), displayNull];
    if (isNull _display) exitWith {};

    private _controlGroup = _display displayCtrl 700;
    _controlGroup ctrlSetFade 1;
    _controlGroup ctrlShow false;
    _controlGroup ctrlCommit 0.2;
}] call CFUNC(addEventHandler);
