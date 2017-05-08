#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:


    Parameter(s):


    Returns:

*/
private _friendlySide = side group CLib_player;
private _enemySide = (EGVAR(Common,competingSides) - [_friendlySide]) select 0;

private _ctrlFriendlyFlag = controlNull;
private _ctrlFriendlySideName = controlNull;
private _ctrlFriendlyPlayerCount = controlNull;
private _ctrlFriendlyTicketCount = controlNull;
private _ctrlFriendlyPlayerListGroup = controlNull;
private _ctrlEnemyFlag = controlNull;
private _ctrlEnemySideName = controlNull;
private _ctrlEnemyPlayerCount = controlNull;
private _ctrlEnemyPlayerListGroup = controlNull;
with uiNamespace do {
    _ctrlFriendlyFlag = GVAR(ctrlFriendlyFlag);
    _ctrlFriendlySideName = GVAR(ctrlFriendlySideName);
    _ctrlFriendlyPlayerCount = GVAR(ctrlFriendlyPlayerCount);
    _ctrlFriendlyTicketCount = GVAR(ctrlFriendlyTicketCount);
    _ctrlFriendlyPlayerListGroup = GVAR(ctrlFriendlyPlayerListGroup);
    _ctrlEnemyFlag = GVAR(ctrlEnemyFlag);
    _ctrlEnemySideName = GVAR(ctrlEnemySideName);
    _ctrlEnemyPlayerCount = GVAR(ctrlEnemyPlayerCount);
    _ctrlEnemyPlayerListGroup = GVAR(ctrlEnemyPlayerListGroup);
};

if (!isNull _ctrlFriendlyFlag) then {
    _ctrlFriendlyFlag ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,Flag_%1), _friendlySide], "#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
    _ctrlFriendlyFlag ctrlCommit 0;
};

if (!isNull _ctrlFriendlySideName) then {
    _ctrlFriendlySideName ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,sideName_%1), _friendlySide], ""]);
    _ctrlFriendlySideName ctrlCommit 0;
};

if (!isNull _ctrlFriendlyPlayerCount) then {
    _ctrlFriendlyPlayerCount ctrlSetText toUpper format ["%1 PLAYERS", {_friendlySide == side group _x} count allPlayers];
    _ctrlFriendlyPlayerCount ctrlCommit 0;
};

if (!isNull _ctrlFriendlyTicketCount) then {
    _ctrlFriendlyTicketCount ctrlSetText str (missionNamespace getVariable [format [QEGVAR(Tickets,sideTickets_%1), _friendlySide], GVAR(maxTickets)]);
    _ctrlFriendlyTicketCount ctrlCommit 0;
};

if (!isNull _ctrlFriendlyPlayerListGroup) then {
    [_ctrlFriendlyPlayerListGroup, _friendlySide] call FUNC(updateExtendedPlayerList);
};

if (!isNull _ctrlEnemyFlag) then {
    _ctrlEnemyFlag ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,Flag_%1), _enemySide], "#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
    _ctrlEnemyFlag ctrlCommit 0;
};

if (!isNull _ctrlEnemySideName) then {
    _ctrlEnemySideName ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,sideName_%1), _enemySide], ""]);
    _ctrlEnemySideName ctrlCommit 0;
};

if (!isNull _ctrlEnemyPlayerCount) then {
    _ctrlEnemyPlayerCount ctrlSetText toUpper format ["%1 PLAYERS", {_enemySide == side group _x} count allPlayers];
    _ctrlEnemyPlayerCount ctrlCommit 0;
};

if (!isNull _ctrlEnemyPlayerListGroup) then {
    [_ctrlEnemyPlayerListGroup, _enemySide] call FUNC(updateSimplePlayerList);
};
