#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Client Init for ScoreTable System

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(ppBlur) = ppEffectCreate ["DynamicBlur", 999];
GVAR(ppColor) = ppEffectCreate ["colorCorrections", 1501];
GVAR(maxTickets) = getNumber (missionConfigFile >> QPREFIX >> "tickets");

DFUNC(createGroupEntry) = {
    params ["_ctrlGroup", "_group"];

    private _groupColor = ["#(argb,8,8,3)color(0.6,0,0,1)", "#(argb,8,8,3)color(0.0,0.4,0.8,1)"] select (side _group == side group CLib_player);

    private _groupHeight = PY(3);

    private _playerBg = _display ctrlCreate ["RscPicture", -1, _ctrlGroup];

    private _groupBg = _display ctrlCreate ["RscPicture", -1, _ctrlGroup];
    _groupBg ctrlSetPosition [PX(0), PY(0), PX(79), PY(3)];
    _groupBg ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.2)";;
    _groupBg ctrlCommit 0;

    private _groupDesignatorBg = _display ctrlCreate ["RscPicture", -1, _ctrlGroup];
    _groupDesignatorBg ctrlSetPosition [PX(0), PY(0), PX(3), PY(3)];
    _groupDesignatorBg ctrlSetText _groupColor;
    _groupDesignatorBg ctrlCommit 0;

    private _groupDesignator = _display ctrlCreate ["RscPicture", -1, _ctrlGroup];
    _groupDesignator ctrlSetPosition [PX(0.5), PY(0.5), PX(2), PY(2)];
    _groupDesignator ctrlSetText format ["A3\ui_f\data\igui\cfg\simpletasks\letters\%1_ca.paa", toLower ((groupId _group) select [0, 1])];
    _groupDesignator ctrlCommit 0;

    private _groupDescriptionTxt = (_group getVariable [QEGVAR(Squad,Description), str _group]);
    if (_groupDescriptionTxt == "") then {
        _groupDescriptionTxt = groupId _group;
    };

    private _groupDescription = _display ctrlCreate ["RscTitle", -1, _ctrlGroup];
    _groupDescription ctrlSetFontHeight PY(2.2);
    _groupDescription ctrlSetFont "RobotoCondensedBold";
    _groupDescription ctrlSetPosition [PX(3.5), PY(0), PX(28), PY(3)];
    _groupDescription ctrlSetText toUpper _groupDescriptionTxt;
    _groupDescription ctrlCommit 0;

    private _groupType = _display ctrlCreate ["RscTitle", -1, _ctrlGroup];
    _groupType ctrlSetFontHeight PY(2.2);
    _groupType ctrlSetFont "RobotoCondensed";
    _groupType ctrlSetTextColor [0.8, 0.8, 0.8, 1];
    _groupType ctrlSetPosition [PX(32), PY(0), PX(16), PY(3)];
    _groupType ctrlSetText ([format [QEGVAR(Squad,GroupTypes_%1_displayName), _group getVariable [QEGVAR(Squad,Type), ""]], ""] call CFUNC(getSettingOld));
    _groupType ctrlCommit 0;

    {
        private _playerGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlGroup];
        _playerGroup ctrlSetPosition [0, _groupHeight, PX(79), PY(4)];
        _playerGroup ctrlCommit 0;

        private _uid = getPlayerUID _x;

        private _numberOfKills = {
            params ["_serverTime", "_killedUnitUid", "_friendlyFire"];
            !_friendlyFire;
        } count (GVAR(ScoreNamespace) getVariable [_uid+"_KILLS", []]);

        private _numberOfFFKills = {
            params ["_serverTime", "_killedUnitUid", "_friendlyFire"];
            _friendlyFire;
        } count (GVAR(ScoreNamespace) getVariable [_uid+"_KILLS", []]);

        private _numberOfDeaths = count (GVAR(ScoreNamespace) getVariable [_uid+"_DEATHS", []]);

        private _medicalTreatments = (GVAR(ScoreNamespace) getVariable [_uid+"_MEDICALTREATMENTS", []]);
        private _numberOfRevives = {_uid != (_x select 1) && {(_x select 2) == "REVIVED"}} count _medicalTreatments;
        private _numberOfHeals = {_uid != (_x select 1) && {(_x select 2) == "HEALED"}} count _medicalTreatments;

        private _captureScore = count (GVAR(ScoreNamespace) getVariable [_uid+"SECTORCAPTURES", []]);

        private _selectedKit = _x getVariable [QEGVAR(Kit,kit), ""];
        private _kitIcon = ([_selectedKit, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;

        private _ctrlKitIcon = _display ctrlCreate ["RscPicture", -1, _playerGroup];
        _ctrlKitIcon ctrlSetPosition [PX(0.5), PY(1), PX(2), PY(2)];
        _ctrlKitIcon ctrlSetText _kitIcon;
        _ctrlKitIcon ctrlCommit 0;

        private _ctrlPlayerName = _display ctrlCreate ["RscTitle", -1, _playerGroup];
        _ctrlPlayerName ctrlSetFontHeight PY(2.2);
        _ctrlPlayerName ctrlSetFont "RobotoCondensed";
        _ctrlPlayerName ctrlSetTextColor [1, 1, 1, 1];
        _ctrlPlayerName ctrlSetPosition [PX(3.5), PY(0.5), PX(28), PY(3)];
        _ctrlPlayerName ctrlSetText ([_x] call CFUNC(name));
        _ctrlPlayerName ctrlCommit 0;

        private _ctrlPlayerKills = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
        _ctrlPlayerKills ctrlSetFontHeight PY(2.2);
        _ctrlPlayerKills ctrlSetFont "RobotoCondensed";
        _ctrlPlayerKills ctrlSetPosition [PX(49), PY(0.5), PX(6), PY(3)];
        _ctrlPlayerKills ctrlSetText str _numberOfKills;
        _ctrlPlayerKills ctrlCommit 0;

        private _ctrlPlayerDeaths = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
        _ctrlPlayerDeaths ctrlSetFontHeight PY(2.2);
        _ctrlPlayerDeaths ctrlSetFont "RobotoCondensed";
        _ctrlPlayerDeaths ctrlSetPosition [PX(55), PY(0.5), PX(6), PY(3)];
        _ctrlPlayerDeaths ctrlSetText str _numberOfDeaths;
        _ctrlPlayerDeaths ctrlCommit 0;

        private _ctrlPlayerMedical = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
        _ctrlPlayerMedical ctrlSetFontHeight PY(2.2);
        _ctrlPlayerMedical ctrlSetFont "RobotoCondensed";
        _ctrlPlayerMedical ctrlSetPosition [PX(61), PY(0.5), PX(6), PY(3)];
        _ctrlPlayerMedical ctrlSetText str (_numberOfRevives*10 + _numberOfHeals*2);
        _ctrlPlayerMedical ctrlCommit 0;

        private _ctrlPlayerCaptured = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
        _ctrlPlayerCaptured ctrlSetFontHeight PY(2.2);
        _ctrlPlayerCaptured ctrlSetFont "RobotoCondensed";
        _ctrlPlayerCaptured ctrlSetPosition [PX(67), PY(0.5), PX(6), PY(3)];
        _ctrlPlayerCaptured ctrlSetText str (10*_captureScore);
        _ctrlPlayerCaptured ctrlCommit 0;

        private _ctrlPlayerScore = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
        _ctrlPlayerScore ctrlSetFontHeight PY(2.2);
        _ctrlPlayerScore ctrlSetFont "RobotoCondensed";
        _ctrlPlayerScore ctrlSetPosition [PX(73), PY(0.5), PX(6), PY(3)];
        _ctrlPlayerScore ctrlSetText str (_numberOfRevives*5 + _numberOfHeals*1 + _numberOfKills*10 - _numberOfFFKills*20 + _captureScore*10);
        _ctrlPlayerScore ctrlCommit 0;

        _groupHeight = _groupHeight + PY(4);
        nil;
    } count ([_group] call CFUNC(groupPlayers));
    //} count units _group;

    _playerBg ctrlSetPosition [0, 0, PX(79), _groupHeight];
    _playerBg ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.2)";;
    _playerBg ctrlCommit 0;

    _groupHeight;
};

DFUNC(updateSimplePlayerList) = {
    params ["_ctrlListGroup", "_side"];

    // Copy old Positon and parent control
    private _oldPosition = ctrlPosition _ctrlListGroup;
    private _parentCtrl = ctrlParentControlsGroup _ctrlListGroup;
    private _display = ctrlParent _ctrlListGroup;
    ctrlDelete _ctrlListGroup;

    // create new one
    private _ctrlListGroup = _display ctrlCreate ["RscControlsGroupNoHScrollbars", -1, _parentCtrl];
    _ctrlListGroup ctrlSetPosition _oldPosition;
    _ctrlListGroup ctrlCommit 0;

    private _playerBg = _display ctrlCreate ["RscPicture", -1, _ctrlListGroup];

    private _verticalPosition = 0;
    {
        if (side _x == _side && groupId _x in EGVAR(Squad,squadIds)) then {
            {
                private _playerGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlListGroup];
                _playerGroup ctrlSetPosition [0, _verticalPosition, PX(39), PY(4)];
                _playerGroup ctrlCommit 0;

                private _uid = getPlayerUID _x;

                private _numberOfKills = {
                    params ["_serverTime", "_killedUnitUid", "_friendlyFire"];
                    !_friendlyFire;
                } count (GVAR(ScoreNamespace) getVariable [_uid+"_KILLS", []]);

                private _numberOfFFKills = {
                    params ["_serverTime", "_killedUnitUid", "_friendlyFire"];
                    _friendlyFire;
                } count (GVAR(ScoreNamespace) getVariable [_uid+"_KILLS", []]);

                private _numberOfDeaths = count (GVAR(ScoreNamespace) getVariable [_uid+"_DEATHS", []]);

                private _captureScore = count (GVAR(ScoreNamespace) getVariable [_uid+"_SECTORCAPTURES", []]);

                private _medicalTreatments = (GVAR(ScoreNamespace) getVariable [_uid+"_MEDICALTREATMENTS", []]);
                private _numberOfRevives = {_uid != (_x select 1) && {(_x select 2) == "REVIVED"}} count _medicalTreatments;
                private _numberOfHeals = {_uid != (_x select 1) && {(_x select 2) == "HEALED"}} count _medicalTreatments;


                private _ctrlPlayerName = _display ctrlCreate ["RscTitle", -1, _playerGroup];
                _ctrlPlayerName ctrlSetFontHeight PY(2.2);
                _ctrlPlayerName ctrlSetFont "RobotoCondensed";
                _ctrlPlayerName ctrlSetTextColor [1, 1, 1, 1];
                _ctrlPlayerName ctrlSetPosition [PX(1), PY(0.5), PX(38), PY(3)];
                _ctrlPlayerName ctrlSetText ([_x] call CFUNC(name));
                _ctrlPlayerName ctrlCommit 0;


                private _ctrlPlayerScore = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
                _ctrlPlayerScore ctrlSetFontHeight PY(2.2);
                _ctrlPlayerScore ctrlSetFont "RobotoCondensed";
                _ctrlPlayerScore ctrlSetPosition [PX(33), PY(0.5), PX(6), PY(3)];
                _ctrlPlayerScore ctrlSetText str (_numberOfRevives*5 + _numberOfHeals*1 + _numberOfKills*10 - _numberOfFFKills*20 + _captureScore*10);
                _ctrlPlayerScore ctrlCommit 0;
                _verticalPosition = _verticalPosition + PY(4);
                nil;
            //} count units _x;
            } count ([_x] call CFUNC(groupPlayers));
        };
        nil;
    } count allGroups;

    _playerBg ctrlSetPosition [0, 0, PX(39), _verticalPosition];
    _playerBg ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.2)";;
    _playerBg ctrlCommit 0;
};

DFUNC(updateExtendedPlayerList) = {
    params ["_ctrlListGroup", "_side"];

    // Copy old Positon and parent control
    private _oldPosition = ctrlPosition _ctrlListGroup;
    private _parentCtrl = ctrlParentControlsGroup _ctrlListGroup;
    private _display = ctrlParent _ctrlListGroup;
    ctrlDelete _ctrlListGroup;

    // create new one
    private _ctrlListGroup = _display ctrlCreate ["RscControlsGroupNoHScrollbars", -1, _parentCtrl];
    _ctrlListGroup ctrlSetPosition _oldPosition;
    _ctrlListGroup ctrlCommit 0;

    private _verticalPosition = 0;
    {
        if (side _x == _side && groupId _x in EGVAR(Squad,squadIds)) then {
            private _groupGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlListGroup];
            private _groupGroupHeight = [_groupGroup, _x] call FUNC(createGroupEntry);

            _groupGroup ctrlSetPosition [0, _verticalPosition, PX(80), _groupGroupHeight];
            _groupGroup ctrlCommit 0;
            _verticalPosition = _verticalPosition + _groupGroupHeight + PY(1);
        };
        nil;
    } count allGroups;
};

DFUNC(updateUI) = {
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


};

DFUNC(buildStaticUI) = {
    params ["_display"];

    private _headerBg = _display ctrlCreate ["RscPicture", -1];
    _headerBg ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, PY(15.5)];
    _headerBg ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.2)";
    _headerBg ctrlCommit 0;

    /*
    private _vsep = _display ctrlCreate ["RscPicture", -1];
    _vsep ctrlSetPosition [0, PY(15), safeZoneW, PY(0.5)];
    _vsep ctrlSetText "#(argb,8,8,3)color(1,1,1,1)";
    _vsep ctrlCommit 0;
    */

    private _globalGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
    _globalGroup ctrlSetPosition [0.5-PX(60), safeZoneY, safeZoneW, safeZoneH];
    _globalGroup ctrlCommit 0;


    private _title = _display ctrlCreate ["RscTitle", -1, _globalGroup];
    _title ctrlSetFontHeight PY(3.2);
    _title ctrlSetFont "RobotoCondensedBold";
    _title ctrlSetPosition [0, PY(10.5), PX(20), PY(4)];
    _title ctrlSetText "SCOREBOARD";
    _title ctrlCommit 0;

    private _friendlyHeaderBg = _display ctrlCreate ["RscPicture", -1, _globalGroup];
    _friendlyHeaderBg ctrlSetPosition [0, PY(17), PX(79), PY(7)];
    _friendlyHeaderBg ctrlSetText "#(argb,8,8,3)color(0.0,0.4,0.8,1)";
    _friendlyHeaderBg ctrlCommit 0;


    private _friendlyFlag = _display ctrlCreate ["RscPictureKeepAspect", -1, _globalGroup];
    _friendlyFlag ctrlSetPosition [PX(0.5), PY(17.5), PX(6), PY(6)];
    _friendlyFlag ctrlSetText "";
    _friendlyFlag ctrlCommit 0;
    uiNamespace setVariable [QGVAR(ctrlFriendlyFlag), _friendlyFlag];

    private _friendlySideName = _display ctrlCreate ["RscTitle", -1, _globalGroup];
    _friendlySideName ctrlSetFontHeight PY(3.3);
    _friendlySideName ctrlSetFont "RobotoCondensedBold";
    _friendlySideName ctrlSetPosition [PX(7), PY(17), PX(30), PY(4)];
    _friendlySideName ctrlSetText "FriendlySideName";
    _friendlySideName ctrlCommit 0;
    uiNamespace setVariable [QGVAR(ctrlFriendlySideName), _friendlySideName];

    private _friendlyTicketCount = _display ctrlCreate ["RscTextNoShadow", -1, _globalGroup];
    _friendlyTicketCount ctrlSetFontHeight PY(3.3);
    _friendlyTicketCount ctrlSetFont "RobotoCondensedBold";
    _friendlyTicketCount ctrlSetPosition [PX(72), PY(17), PX(6), PY(4)];
    _friendlyTicketCount ctrlSetText "TICKETS";
    _friendlyTicketCount ctrlCommit 0;
    uiNamespace setVariable [QGVAR(ctrlFriendlyTicketCount), _friendlyTicketCount];

    private _friendlyPlayerCount = _display ctrlCreate ["RscTitle", -1, _globalGroup];
    _friendlyPlayerCount ctrlSetFontHeight PY(2.2);
    _friendlyPlayerCount ctrlSetFont "RobotoCondensed";
    _friendlyPlayerCount ctrlSetPosition [PX(7), PY(20), PX(30), PY(4)];
    _friendlyPlayerCount ctrlSetText "XX PLAYERS";
    _friendlyPlayerCount ctrlCommit 0;
    uiNamespace setVariable [QGVAR(ctrlFriendlyPlayerCount), _friendlyPlayerCount];

    private _friendlyKillHeader = _display ctrlCreate ["RscTextNoShadow", -1, _globalGroup];
    _friendlyKillHeader ctrlSetFontHeight PY(2.2);
    _friendlyKillHeader ctrlSetFont "RobotoCondensedBold";
    _friendlyKillHeader ctrlSetPosition [PX(49), PY(20), PX(6), PY(4)];
    _friendlyKillHeader ctrlSetText "KILLS";
    _friendlyKillHeader ctrlCommit 0;

    private _friendlyDeathHeader = _display ctrlCreate ["RscTextNoShadow", -1, _globalGroup];
    _friendlyDeathHeader ctrlSetFontHeight PY(2.2);
    _friendlyDeathHeader ctrlSetFont "RobotoCondensedBold";
    _friendlyDeathHeader ctrlSetPosition [PX(55), PY(20), PX(6), PY(4)];
    _friendlyDeathHeader ctrlSetText "DEATHS";
    _friendlyDeathHeader ctrlCommit 0;

    private _friendlyMedicalHeader = _display ctrlCreate ["RscPictureKeepAspect", -1, _globalGroup];
    _friendlyMedicalHeader ctrlSetFontHeight PY(2.2);
    _friendlyMedicalHeader ctrlSetFont "RobotoCondensedBold";
    _friendlyMedicalHeader ctrlSetPosition [PX(61), PY(21), PX(6), PY(2)];
    _friendlyMedicalHeader ctrlSetText "\A3\ui_f\data\igui\cfg\simpletasks\types\heal_ca.paa";
    _friendlyMedicalHeader ctrlCommit 0;

    private _friendlyCapturedHeader = _display ctrlCreate ["RscPictureKeepAspect", -1, _globalGroup];
    _friendlyCapturedHeader ctrlSetFontHeight PY(2.2);
    _friendlyCapturedHeader ctrlSetFont "RobotoCondensedBold";
    _friendlyCapturedHeader ctrlSetPosition [PX(67), PY(21), PX(6), PY(2)];
    _friendlyCapturedHeader ctrlSetText "\A3\ui_f\data\igui\cfg\simpletasks\types\attack_ca.paa";
    _friendlyCapturedHeader ctrlCommit 0;

    private _friendlyScoreHeader = _display ctrlCreate ["RscTextNoShadow", -1, _globalGroup];
    _friendlyScoreHeader ctrlSetFontHeight PY(2.2);
    _friendlyScoreHeader ctrlSetFont "RobotoCondensedBold";
    _friendlyScoreHeader ctrlSetPosition [PX(73), PY(20), PX(6), PY(4)];
    _friendlyScoreHeader ctrlSetText "SCORE";
    _friendlyScoreHeader ctrlCommit 0;

    private _friendlyPlayerListGroup = _display ctrlCreate ["RscControlsGroupNoHScrollbars", -1, _globalGroup];
    _friendlyPlayerListGroup ctrlSetPosition [0, PY(25), PX(80), PY(70)];
    _friendlyPlayerListGroup ctrlCommit 0;
    uiNamespace setVariable [QGVAR(ctrlFriendlyPlayerListGroup), _friendlyPlayerListGroup];

    private _enemyHeaderBg = _display ctrlCreate ["RscPicture", -1, _globalGroup];
    _enemyHeaderBg ctrlSetPosition [PX(81), PY(17), PX(39), PY(7)];
    _enemyHeaderBg ctrlSetText "#(argb,8,8,3)color(0.6,0,0,1)";
    _enemyHeaderBg ctrlCommit 0;

    private _enemyFlag = _display ctrlCreate ["RscPictureKeepAspect", -1, _globalGroup];
    _enemyFlag ctrlSetPosition [PX(81.5), PY(17.5), PX(6), PY(6)];
    _enemyFlag ctrlSetText "";
    _enemyFlag ctrlCommit 0;
    uiNamespace setVariable [QGVAR(ctrlEnemyFlag), _enemyFlag];

    private _enemySideName = _display ctrlCreate ["RscTitle", -1, _globalGroup];
    _enemySideName ctrlSetFontHeight PY(3.3);
    _enemySideName ctrlSetFont "RobotoCondensedBold";
    _enemySideName ctrlSetPosition [PX(88), PY(17), PX(30), PY(4)];
    _enemySideName ctrlSetText "EnemySide";
    _enemySideName ctrlCommit 0;
    uiNamespace setVariable [QGVAR(ctrlEnemySideName), _enemySideName];

    private _enemyPlayerCount = _display ctrlCreate ["RscTitle", -1, _globalGroup];
    _enemyPlayerCount ctrlSetFontHeight PY(2.2);
    _enemyPlayerCount ctrlSetFont "RobotoCondensed";
    _enemyPlayerCount ctrlSetPosition [PX(88), PY(20), PX(30), PY(4)];
    _enemyPlayerCount ctrlSetText "XX PLAYERS";
    _enemyPlayerCount ctrlCommit 0;
    uiNamespace setVariable [QGVAR(ctrlEnemyPlayerCount), _enemyPlayerCount];

    private _enemyPlayerListGroup = _display ctrlCreate ["RscControlsGroupNoHScrollbars", -1, _globalGroup];
    _enemyPlayerListGroup ctrlSetPosition [PX(81), PY(25), PX(40), PY(70)];
    _enemyPlayerListGroup ctrlCommit 0;
    uiNamespace setVariable [QGVAR(ctrlEnemyPlayerListGroup), _enemyPlayerListGroup];
};


["showScoreTable", {
    private _display = (findDisplay 46) createDisplay "RscDisplayEmpty";


    _display displayAddEventHandler ["KeyDown",  {
        params ["_display", "_dikCode", "_shift", "_ctrl", "_alt"];
        private _handled = false;
        if (_dikCode in actionKeys "networkStats" || _dikCode == 1) then {
            _display closeDisplay 1;
            _handled = true;
        };
        _handled;
    }];

    _display displayAddEventHandler ["Unload",  {
        params ["_display", "_exitCode"];
        GVAR(ppColor) ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [0.7, 0.2, 0.1, 0.0]];
        GVAR(ppColor) ppEffectCommit 0.3;
        GVAR(ppBlur) ppEffectAdjust [0];
        GVAR(ppBlur) ppEffectCommit 0.3;

    }];

    [_display] call FUNC(buildStaticUI);


    GVAR(ppColor) ppEffectEnable true;
    GVAR(ppColor) ppEffectAdjust [0.7, 0.7, 0.1, [0, 0, 0, 0], [1, 1, 1, 1], [0.7, 0.2, 0.1, 0.0]];
    GVAR(ppColor) ppEffectCommit 0.2;

    GVAR(ppBlur) ppEffectAdjust [8];
    GVAR(ppBlur) ppEffectEnable true;
    GVAR(ppBlur) ppEffectCommit 0.2;

    [] call FUNC(updateUI);

}] call CFUNC(addEventhandler);

["missionStarted", {
    (findDisplay 46) displayAddEventHandler ["KeyDown",  {
        params ["_display", "_dikCode", "_shift", "_ctrl", "_alt"];
        private _handled = false;
        if (_dikCode in actionKeys "networkStats" && !_shift && !_alt && !_ctrl) then {
            ["showScoreTable", [_display]] call CFUNC(localEvent);
            _handled = true;
        };
        _handled;
    }];
}] call CFUNC(addEventhandler);
