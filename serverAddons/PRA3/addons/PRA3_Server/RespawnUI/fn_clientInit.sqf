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

GVAR(respawnCountdown) = getNumber(missionConfigFile >> "PRA3" >> "respawnCountdown");
GVAR(respawnTime) = 0;
GVAR(selectedKit) = "";
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
        _ctrl ctrlSetEventHandler ["buttonClick", "
            closeDialog 0;
            failMission ""LOSER"";
        "];
        _ctrl ctrlEnable true;
        _ctrl ctrlSetText "ABORT";
        _ctrl ctrlSetTooltip "Abort.";

        _ret = true;
    };

    _ret;
};
["missionStarted", {
    [QGVAR(SideSelection)] call bis_fnc_startLoadingScreen;
    [{
        50 call bis_fnc_progressloadingscreen;
        private _sidePlayerCount = EGVAR(Mission,competingSides) apply {
            private _side = call compile _x;
            [{side group _x == _side} count (allPlayers), _side]
        };
        _sidePlayerCount sort true;
        private _newSide = _sidePlayerCount select 0 select 1;

        PRA3_Player setVariable [QCGVAR(tempUnit), true];
        [_newSide, createGroup _newSide, [-1000, -1000, 10], true] call CFUNC(respawn);
        createDialog UIVAR(RespawnScreen);
        [QGVAR(initCamera)] call CFUNC(localEvent);
        (findDisplay 1000) displayAddEventHandler ["KeyDown", FUNC(escapeFnc)];
        [QGVAR(SideSelection)] call bis_fnc_endLoadingScreen;
    }] call CFUNC(mutex);

    [QEGVAR(Revive,Killed), {
        setPlayerRespawnTime 10e10; //@todo make this independent of revive module
        GVAR(respawnTime) = diag_tickTime + GVAR(respawnCountdown);
        createDialog UIVAR(RespawnScreen);
        (findDisplay 1000) displayAddEventHandler ["KeyDown", FUNC(escapeFnc)];
        [{
            if (diag_tickTime >= GVAR(respawnTime)) exitWith {
                (_this select 1) call CFUNC(remotePerFrameHandler);
                (findDisplay 1000  displayCtrl 500) ctrlSetText "DEPLOY";
                (findDisplay 1000  displayCtrl 500) ctrlEnable true;
            };

            private _time = GVAR(respawnTime) - diag_tickTime;
            (findDisplay 1000  displayCtrl 500) ctrlSetText format ["%1.%2 s", floor(_time), floor((_time mod 1)*10)];
            (findDisplay 1000  displayCtrl 500) ctrlEnable false;

        }, 0, []] call CFUNC(addPerFrameHandler);
        [QGVAR(initCamera)] call CFUNC(localEvent);
    }] call CFUNC(addEventHandler);
    /*
    ["Respawn Screen", PRA3_Player, 0, {!dialog}, {
        createDialog UIVAR(RespawnScreen);
    }] call CFUNC(addAction);
    */
}] call CFUNC(addEventHandler);


["playerSideChanged", {
    UIVAR(RespawnScreen_TeamInfo_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

["leaderChanged", {
    UIVAR(RespawnScreen_SquadManagement_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

["groupChanged", {
    _this select 0 params ["_newGroup", "_oldGroup"];

    [UIVAR(RespawnScreen_RoleManagement_update), [_newGroup, _oldGroup]] call CFUNC(targetEvent);
    UIVAR(RespawnScreen_SquadManagement_update) call CFUNC(globalEvent);
    UIVAR(RespawnScreen_DeploymentManagement_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);
