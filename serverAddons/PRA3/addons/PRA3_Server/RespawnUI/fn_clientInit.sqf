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
    }] call CFUNC(mutex);

    ["Respawn Screen", PRA3_Player, 0, {!dialog}, {
        createDialog UIVAR(RespawnScreen);
    }] call CFUNC(addAction);
}] call CFUNC(addEventHandler);
