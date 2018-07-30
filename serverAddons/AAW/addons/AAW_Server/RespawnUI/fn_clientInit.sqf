#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Init of respawn UI stuff.

    Parameter(s):
    None

    Returns:
    None
*/
if (side CLib_player == sideLogic && {CLib_player isKindOf "VirtualSpectator_F"}) exitWith {};

DFUNC(createSquadListItem) = {
    private _groupId = groupId _this;

    private _squadDesignator = _groupId select [0, 1];
    private _description = _x getVariable [QEGVAR(Squad,Description), str _x];
    private _groupType = _x getVariable [QEGVAR(Squad,Type), ""];
    private _groupTypeName = [format [QUOTE(PREFIX/CfgGroupTypes/%1/displayName), _groupType], ""] call CFUNC(getSetting);
    private _groupSize = [format [QUOTE(PREFIX/CfgGroupTypes/%1/groupSize), _groupType], 0] call CFUNC(getSetting);
    private _groupCountText = format ["%1 / %2", count ([_x] call CFUNC(groupPlayers)), _groupSize];

    if (_description == "") then {
        _description = _groupId;
    };

    private _grpSquadItem = GUI_NEWGROUP(0, 0, PX(41), PY(17));
    _grpSquadItem setVariable [QGVAR(Group), _this];
    GUI_FIX_MOUSEENTER;
    GUI_LASTCTRL setVariable ["MouseEnterEH", [{
        params ["_ctrl"];
        private _group = _ctrl getVariable [QGVAR(Group), grpNull];
        if !(group CLib_player isEqualTo _group) then {
            private GUI_LASTCTRL = _ctrl getVariable [QGVAR(Background), controlNull];
            GUI_BACKGROUNDCOLOR(C_A_BRIGHT_TEXT);
            GUI_COMMIT(0);
            {
                private _data = _ctrl getVariable [_x, controlNull];
                if !(_data isEqualType []) then {
                    _data = [_data];
                };
                {
                    GUI_LASTCTRL = _x;
                    GUI_TEXTCOLOR(C_A_DARK_TEXT);
                    GUI_COMMIT(0);
                } count _data;
                nil;
            } count [QGVAR(SquadName), QGVAR(SquadType), QGVAR(SquadLeader), QGVAR(PlayerCount)];
            GUI_LASTCTRL setVariable [QGVAR(Action), "JOIN"];
            (_ctrl getVariable [QGVAR(BtnJoinLeave), controlNull]) ctrlShow true;
        } else {
            private GUI_LASTCTRL = (_ctrl getVariable [QGVAR(BtnJoinLeave), controlNull]);
            GUI_LASTCTRL setVariable [QGVAR(Action), "LEAVE"];
            GUI_LASTCTRL ctrlShow true;
            private GUI_LASTCTRL = GUI_LASTCTRL getVariable ["GUI_ICON", controlNull];
            GUI_TEXTURE(I_P_LEAVE);
            GUI_COMMIT(0);
        };

    }]];
    GUI_LASTCTRL setVariable ["MouseExitEH", [{
        params ["_ctrl"];

        private _group = _ctrl getVariable [QGVAR(Group), grpNull];
        if !(group CLib_player isEqualTo _group) then {
            private GUI_LASTCTRL = _ctrl getVariable [QGVAR(Background), controlNull];
            GUI_BACKGROUNDCOLOR(C_A_DARK);
            GUI_COMMIT(0);
            {
                private _data = _ctrl getVariable [_x, controlNull];
                if !(_data isEqualType []) then {
                    _data = [_data];
                };
                {
                    GUI_LASTCTRL = _x;
                    GUI_TEXTCOLOR(C_A_BRIGHT_TEXT);
                    GUI_COMMIT(0);
                } count _data;
                nil;
            } count [QGVAR(SquadName), QGVAR(SquadType), QGVAR(SquadLeader), QGVAR(PlayerCount)];
        };
        (_ctrl getVariable [QGVAR(BtnJoinLeave), controlNull]) ctrlShow false;
    }]];
    AAWUI_PANELBACKGROUND(0,PY(0),PX(41),PY(100));
    private _grpSquadItemHeader = GUI_NEWGROUP(0, 0, PX(41), PY(4));GUI_COMMIT(0);

    private _grpSquadItemHeaderBackground = AAWUI_BUTTONBACKGROUND(0, 0, PX(41), PY(4));
    if (group CLib_player isEqualTo _this) then {
        GUI_BACKGROUNDCOLOR(C_A_BRIGHT_TEXT);
    };
    _grpSquadItem setVariable [QGVAR(Background), _grpSquadItemHeaderBackground];
    GUI_COMMIT(0);

    private _designatorColor = [C_A_FRIENDLY, C_A_SQUAD] select (_this == group CLib_player);
    private _ctrlSquadDesignator = AAWUI_SQUAD_DESIGNATOR(_squadDesignator, _designatorColor, PX(0.5), PY(0.5));GUI_COMMIT(0);
    _grpSquadItem setVariable [QGVAR(SquadDesignator), _ctrlSquadDesignator];
    _grpSquadItem setVariable [QGVAR(SquadName), GUI_NEWCTRL_TEXT_LEFT];
    AAWUI_TEXTSTYLE_NORMAL_BOLD_SMALL;
    GUI_POSITION(PX(4), PY(0.2), PX(16), PY(1.8));
    GUI_TEXT(_description);
    if (group CLib_player isEqualTo _this) then {
        GUI_TEXTCOLOR(C_A_DARK);
    };
    GUI_COMMIT(0);

    _grpSquadItem setVariable [QGVAR(SquadType), GUI_NEWCTRL_TEXT_LEFT];
    AAWUI_TEXTSTYLE_NORMAL_REGULAR_SMALL;
    GUI_POSITION(PX(4), PY(2), PX(16), PY(1.8));
    if (group CLib_player isEqualTo _this) then {
        GUI_TEXTCOLOR(C_A_DARK);
    };
    GUI_TEXT(_groupTypeName);
    GUI_COMMIT(0);

    private _squadLeaderKit = leader _this getVariable [QEGVAR(Kit,kit), ""];
    private _squadLeaderKitIcon = ([_squadLeaderKit, side _this, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;

    private _squadLeaderName = [leader _this] call CFUNC(name);
    private _squadLeaderControls = AAWUI_PLAYERNAME(_squadLeaderName, _squadLeaderKitIcon, 3/4, PX(20), PY(0.5));
    if (group CLib_player isEqualTo _this) then {
        {
            GUI_LASTCTRL = _x;
            GUI_TEXTCOLOR(C_A_DARK);
            GUI_COMMIT(0);
        } count _squadLeaderControls;
    };
    _grpSquadItem setVariable [QGVAR(SquadLeader), _squadLeaderControls];

    _grpSquadItem setVariable [QGVAR(PlayerCount), GUI_NEWCTRL_TEXT_CENTERED];
    AAWUI_TEXTSTYLE_NORMAL_BOLD_SMALL;
    GUI_POSITION(PX(35), 0, PX(6), PY(4));
    GUI_TEXT(_groupCountText);
    if (group CLib_player isEqualTo _this) then {
        GUI_TEXTCOLOR(C_A_DARK);
    };
    GUI_COMMIT(0);

    private _btnJoinLeave = AAWUI_ICONBUTTON_ENTER(PX(37), 0, PX(4), PY(4));
    GUI_COMMIT(0);
    _grpSquadItem setVariable [QGVAR(BtnJoinLeave), _btnJoinLeave];
    _btnJoinLeave ctrlShow false;

    GUI_POPGRP;

    private _xPos = 0;
    private _yPos = 4.5;
    private _nbrPlayers = {
        if (_x != leader _this) then {
            private _selectedKit = _x getVariable [QEGVAR(Kit,kit), ""];
            private _kitIcon = ([_selectedKit, side group _x, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;
            private _pName = [_x] call CFUNC(name);
            AAWUI_PLAYERNAME(_pName, _kitIcon, 3/4, PX(_xPos), PY(_yPos));
            _xPos = _xPos + 20;
            if (_xPos > 20) then {
                _xPos = 0;
                _yPos = _yPos + 3;
            };
        };

        true;
    } count ([_this] call CFUNC(groupPlayers));

    GUI_LASTCTRL = GUI_POPGRP;
    if (_nbrPlayers > 1) then {
        GUI_POSITION(0,0,PX(41), PY(1 + (floor (_nbrPlayers/2))*30));
    } else {
        GUI_POSITION(0,0,PX(41), PY(4));
    };
    GUI_COMMIT(0);
};

DFUNC(updateGroupTypeSelection) = {
    params ["_display"];

    private _grpGroupTypeSelection = _display getVariable [QGVAR(GroupTypeSelection), controlNull];

    GUI_INIT(_display);

    GUI_PUSHGRP(ctrlParent _grpGroupTypeSelection);
    GUI_PUSHGRP(_grpGroupTypeSelection);

    private _posX = 0;
    private _posY = 0;

    {
        private _squadType = _x;
        private _prefix = format [QUOTE(PREFIX/CfgGroupTypes/%1/), _squadType];
        private _requiredGroups = [_prefix + "requiredGroups", 1] call CFUNC(getSetting);

        if (_requiredGroups > 0) then {
            private _groupCount = count allGroups;
            _availableSquadCount = _groupCount / _requiredGroups;
        };

        private _requiredPlayers = [_prefix + "requiredPlayers", 1] call CFUNC(getSetting);
        if (_requiredPlayers > 0) then {
            private _playerCount = count allPlayers; // TODO use allPlayers when no AI needed
            _availableSquadCount = _availableSquadCount min (_playerCount / _requiredPlayers);
        };

        private _nbrSquads = {
            (_x getVariable [QEGVAR(Squad,Type), ""]) == _squadType;
        } count allGroups;

        private _squadTypeName = ([format [QUOTE(PREFIX/CfgGroupTypes/%1/displayName), _squadType], ""] call CFUNC(getSetting));
        AAWUI_TEXTBUTTON(toUpper _squadTypeName, F_S_SMALL, _posX, _posY, PX(24), PY(3)); GUI_COMMIT(0);

        _posX = _posX + PX(24.5);
        if (_posX > PX(50)) then {
            _posX = 0;
            _posY = _posY + PY(3.5);
        };
        nil
    } count ([QUOTE(PREFIX/CfgGroupTypes/activeGroupTypes), []] call CFUNC(getSetting));

};

DFUNC(createRespawnScreen) = {
    // ---------------------------------------------------
    // CREATE RESPAWN UI
    // ---------------------------------------------------
    private _display = (findDisplay 46) createDisplay "RscDisplayEmpty";
    GUI_INIT(_display);
    //MAIN GROUP
    private _grpMain = GUI_NEWGROUP(safeZoneX, safezoneY, safeZoneW, safeZoneH);GUI_COMMIT(0);

    // HEADER BACKGROUND
    private _grpHeader = GUI_NEWGROUP(0, 0, safeZoneW, PY(9)); GUI_COMMIT(0);
    private _grpHeaderBg = AAWUI_PANELBACKGROUND(0, 0, safeZoneW, PY(9));GUI_COMMIT(0);

    // OWNTEAM
    private _grpHeaderFriendlyTeam =  GUI_NEWGROUP(PX(2), PY(2), PX(40), PY(5)); GUI_COMMIT(0);
    AAWUI_FRIENDLYBACKGROUND(0, 0, PX(5), PY(5)); GUI_COMMIT(0);
    private _ctrlTextFriendlyTeam = GUI_NEWCTRL_TEXT_LEFT;
    GUI_TEXT("NATO");
    AAWUI_TEXTSTYLE_DISPLAY_REGULAR_LARGE;
    GUI_POSITION(GUI_RIGHT+PX(1), 0, PX(30), PY(5));
    GUI_COMMIT(0);
    private _ctrlIconFriendlyTeam = GUI_NEWCTRL("RscPicture");
    GUI_TEXTURECOLOR(C_A_BRIGHT_TEXT);
    GUI_TEXTURE("\a3\ui_f_orange\Data\CfgOrange\Missions\orange_airdrop_ca.paa");
    GUI_POSITION_CENTERED(PX(2.5), PY(2.5), PX(4), PY(4));
    GUI_COMMIT(0);
    GUI_POPGRP; // Close _grpHeaderFriendlyTeam

    GUI_POPGRP; // Close _grpHeader



    private _grpSquadSelection = GUI_NEWGROUP(PX(2), PY(10), PX(42), PY(98));GUI_COMMIT(0);
    private _ctrlUiHintSquad = GUI_NEWGROUP(0, 0, PX(41), PY(5)); GUI_COMMIT(0);
    AAWUI_SPECIALBACKGROUND(0, 0, PX(41), PY(5)); GUI_COMMIT(0);
     GUI_NEWCTRL_TEXT_CENTERED;
    GUI_TEXT("SELECT YOUR SQUAD");
    AAWUI_TEXTSTYLE_UIHINT;
    GUI_POSITION(0, 0, PX(41.5), PY(5));
    GUI_COMMIT(0);
    GUI_POPGRP; //Close UI Hint

    private _grpSquadList = GUI_NEWGROUP_VSCROLL(0, PY(6), PX(42), PY(83));GUI_COMMIT(0);
    _display setVariable [QGVAR(SquadSelection), _grpSquadSelection];
    _display setVariable [QGVAR(SquadList), _grpSquadList];

    GUI_POPGRP;//Close Squad List
    private _btnYourSquad = AAWUI_TEXTBUTTONLARGE("YOUR SQUAD", 0, PY(98-7), PX(25)); GUI_COMMIT(0);


    private _grpCreateSquad = GUI_NEWGROUP(0, PY(8), PX(41), PY(4)); GUI_COMMIT(0);
    AAWUI_PANELBACKGROUND(0, 0, PX(41), PY(4)); GUI_COMMIT(0);
    private _ctrlSquadDesignator = AAWUI_SQUAD_DESIGNATOR("", C_A_SQUAD, PX(0.5), PY(0.5));GUI_COMMIT(0);
    private _btnCreateSquad = AAWUI_TEXTBUTTON("CREATE YOUR SQUAD", F_S_MEDIUM, PX(4), 0, PX(37), PY(4)); GUI_COMMIT(0);

    _display setVariable [QGVAR(CreateSquadGroup), _grpCreateSquad];
    _display setVariable [QGVAR(CreateSquadDesignator), _ctrlSquadDesignator];
    GUI_POPGRP;//Close Create Squad
    GUI_POPGRP;//Close Squad Selection



    private _grpOwnSquad = GUI_NEWGROUP(PX(2), PY(16), PX(42), PY(92));GUI_COMMIT(0);
    _display setVariable [QGVAR(OwnSquad), _grpOwnSquad];
    private _grpSquadItem = _grpOwnSquad;

    private _grpSquadItemHeader = GUI_NEWGROUP(0, 0, PX(41), PY(4));GUI_COMMIT(0);
    _grpSquadItemHeader setVariable [QGVAR(Group), _this];
    GUI_FIX_MOUSEENTER;
    GUI_LASTCTRL setVariable ["MouseEnterEH", [{
        params ["_ctrl"];
        private _group = group CLib_player;

        (_ctrl getVariable [QGVAR(BtnJoinLeave), controlNull]) ctrlShow true;

    }]];
    GUI_LASTCTRL setVariable ["MouseExitEH", [{
        params ["_ctrl"];

        (_ctrl getVariable [QGVAR(BtnJoinLeave), controlNull]) ctrlShow false;
    }]];


    private _grpSquadItemHeaderBackground = AAWUI_BUTTONBACKGROUND(0, 0, PX(41), PY(4));
    GUI_BACKGROUNDCOLOR(C_A_BRIGHT_TEXT);
    _grpSquadItemHeader setVariable [QGVAR(Background), _grpSquadItemHeaderBackground];
    GUI_COMMIT(0);

    private _squadDesignator = groupId group CLib_player select [0, 1];
    private _ctrlSquadDesignator = AAWUI_SQUAD_DESIGNATOR(_squadDesignator, C_A_SQUAD, PX(0.5), PY(0.5));GUI_COMMIT(0);
    _grpSquadItemHeader setVariable [QGVAR(SquadDesignator), _ctrlSquadDesignator];
    _grpSquadItemHeader setVariable [QGVAR(SquadName), GUI_NEWCTRL_TEXT_LEFT];
    AAWUI_TEXTSTYLE_NORMAL_BOLD_SMALL;
    GUI_TEXTCOLOR(C_A_DARK);
    GUI_POSITION(PX(4), PY(0.2), PX(16), PY(1.8));
    GUI_TEXT(toUpper groupId group CLib_player);
    GUI_COMMIT(0);

    _grpSquadItemHeader setVariable [QGVAR(SquadType), GUI_NEWCTRL_TEXT_LEFT];
    AAWUI_TEXTSTYLE_NORMAL_REGULAR_SMALL;
    GUI_TEXTCOLOR(C_A_DARK);
    GUI_POSITION(PX(4), PY(2), PX(16), PY(1.8));
    GUI_TEXT(_groupTypeName);
    GUI_COMMIT(0);

    private _squadLeaderKit = leader group CLib_player getVariable [QEGVAR(Kit,kit), ""];
    private _squadLeaderKitIcon = ([_squadLeaderKit, side CLib_player, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;

    private _squadLeaderName = [leader group CLib_player] call CFUNC(name);
    private _squadLeaderControls = AAWUI_PLAYERNAME(_squadLeaderName, _squadLeaderKitIcon, 3/4, PX(20), PY(0.5));
    {
        GUI_LASTCTRL = _x;
        GUI_TEXTCOLOR(C_A_DARK);
        GUI_COMMIT(0);
    } count _squadLeaderControls;
    _grpSquadItemHeader setVariable [QGVAR(SquadLeader), _squadLeaderControls];

    _grpSquadItemHeader setVariable [QGVAR(PlayerCount), GUI_NEWCTRL_TEXT_CENTERED];
    AAWUI_TEXTSTYLE_NORMAL_BOLD_SMALL;
    GUI_TEXTCOLOR(C_A_DARK);
    GUI_POSITION(PX(35), 0, PX(6), PY(4));
    GUI_TEXT(_groupCountText);
    GUI_COMMIT(0);

    private _btnJoinLeave = AAWUI_ICONBUTTON_LEAVE(PX(37), 0, PX(4), PY(4));
    GUI_COMMIT(0);
    _grpSquadItemHeader setVariable [QGVAR(BtnJoinLeave), _btnJoinLeave];
    _btnJoinLeave ctrlShow false;

    GUI_POPGRP;

    private _xPos = 0;
    private _yPos = 4.5;
    private _nbrPlayers = {
        if (_x != leader group CLib_player) then {
            private _selectedKit = _x getVariable [QEGVAR(Kit,kit), ""];
            private _kitIcon = ([_selectedKit, side group _x, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;
            private _pName = [_x] call CFUNC(name);
            AAWUI_PLAYERNAME(_pName, _kitIcon, 3/4, PX(_xPos), PY(_yPos));
            _xPos = _xPos + 20;
            if (_xPos > 20) then {
                _xPos = 0;
                _yPos = _yPos + 3;
            };
        };

        true;
    } count ([group CLib_player] call CFUNC(groupPlayers));


    private _btnSquads = AAWUI_TEXTBUTTONLARGE("SQUADS", 0, PY(92-7), PX(25)); GUI_COMMIT(0);

    GUI_POPGRP; //Close Own Squad Header

    private _grpRoleSelection = GUI_NEWGROUP(safeZoneW - PX(36), PY(10), PX(34), PY(98));GUI_COMMIT(0);
    private _ctrlUiHintRole = GUI_NEWGROUP(0, 0, PX(34), PY(5)); GUI_COMMIT(0);
    AAWUI_SPECIALBACKGROUND(0, 0, PX(34), PY(5)); GUI_COMMIT(0);
    GUI_NEWCTRL_TEXT_CENTERED;
    GUI_TEXT("SELECT YOUR ROLE");
    AAWUI_TEXTSTYLE_UIHINT;
    GUI_POSITION(0, 0, PX(34), PY(5));
    GUI_COMMIT(0);
    GUI_POPGRP; //Close UI Hint

    GUI_POPGRP; // Close Role Selection

    private _btnDeploy = AAWUI_TEXTBUTTONLARGE("DEPLOY", safeZoneW-PX(27), safeZoneH - PY(7), PX(25)); GUI_COMMIT(0);

    private _grpCreateSquadDialog = GUI_NEWGROUP(0, PY(9), safeZoneW, safeZoneH - PY(9));GUI_COMMIT(0);
    AAWUI_PANELBACKGROUND(0, 0, safeZoneW, safeZoneH - PY(9));GUI_COMMIT(0);
    private _grpCreateSquadDialogContent = GUI_NEWGROUP(safeZoneW/2 - PX(40), PY(7), PX(80), safeZoneH - PY(9+7));GUI_COMMIT(0);
    GUI_NEWCTRL("RscPicture");
    GUI_POSITION_CENTERED(PX(3),PY(3),PX(6),PY(6))
    GUI_TEXTURE(I_P_CIRCLEFILLED);
    GUI_TEXTURECOLOR(C_A_SQUAD);
    GUI_COMMIT(0);
    private _ctrlCreateSquadDesignator = GUI_NEWCTRL_TEXT_CENTERED;
    GUI_POSITION(0,0,PX(3),PY(3));
    AAWUI_TEXTSTYLE_DISPLAY_BOLD_SMALL;
    GUI_TEXT(D);
    GUI_COMMIT(0);

    GUI_NEWCTRL_TEXT_LEFT;
    GUI_POSITION(PX(7),0,PX(73),PY(6))
    AAWUI_TEXTSTYLE_DISPLAY_BOLD_LARGE;
    GUI_TEXT("CREATE YOUR SQUAD");
    GUI_COMMIT(0);

    GUI_NEWCTRL_TEXT_LEFT;
    GUI_POSITION(PX(7),PY(7),PX(73),PY(3))
    AAWUI_TEXTSTYLE_DISPLAY_BOLD_MEDIUM;
    GUI_TEXT("SQUAD NAME");
    GUI_COMMIT(0);

    private _ctrlSquadName = GUI_NEWCTRL("RscEdit");
    AAWUI_TEXTSTYLE_NORMAL_REGULAR_MEDIUM;
    GUI_POSITION(PX(7),PY(10.5),PX(20),PY(3));
    GUI_BACKGROUNDCOLOR(C_A_DARK);
    GUI_COMMIT(0);

    GUI_NEWCTRL_TEXT_LEFT;
    GUI_POSITION(PX(7),PY(16),PX(73),PY(3))
    AAWUI_TEXTSTYLE_DISPLAY_BOLD_MEDIUM;
    GUI_TEXT("CHOOSE A SQUAD TYPE");
    GUI_COMMIT(0);


    private _grpSquadTypeSelection = GUI_NEWGROUP(PX(7),PY(19.5),PX(73),PY(10));GUI_COMMIT(0);
    _display setVariable [QGVAR(SquadTypeSelection), _grpSquadTypeSelection];

    GUI_POPGRP;

    private _btnCreateSquadDialog = AAWUI_TEXTBUTTONSMALL("CREATE", PX(69), PY(22), PX(12)); GUI_COMMIT(0);

    [_display] call FUNC(updateGroupTypeSelection);
    [_display] call {
        params ["_display"];

        GUI_INIT(_display);

        private _grpOwnSquad = _display getVariable [QGVAR(OwnSquad), controlNull];
        if (isNull _grpOwnSquad) exitWith {};


    };

    [_display] call {
        params ["_display"];

        GUI_INIT(_display);

        private _grpSquadList = _display getVariable [QGVAR(SquadList), controlNull];
        if (isNull _grpSquadList) exitWith {};

        GUI_PUSHGRP(ctrlParent _grpSquadList);
        GUI_PUSHGRP(_grpSquadList);

        private _squadListItems = _grpSquadList getVariable [QGVAR(Items), []];

        {
            ctrlDelete _x;
        } count _squadListItems;
        private _yPos = 0;
        private _spacing = PY(1);
        private _allSquads = (allGroups select {side _x == playerSide && groupId _x in EGVAR(Squad,squadIds) && count units _x > 0});
        _squadListItems = _allSquads apply {
            _x call FUNC(createSquadListItem);
            private _position = ctrlPosition GUI_LASTCTRL;
            _position set [1, _yPos];
            _yPos = _yPos + (_position select 3) + _spacing;
            GUI_LASTCTRL ctrlSetPosition _position;
            GUI_COMMIT(0);
            _LASTCTRL;
        };
        _yPos = _yPos - _spacing;

        GUI_LASTCTRL = GUI_POPGRP;
        _yPos = PY(83) min _yPos;
        GUI_POSITION(0, PY(6), PX(42), _yPos);

        _grpSquadList setVariable [QGVAR(Items), _squadListItems];

        _grpCreateSquad = _display getVariable [QGVAR(CreateSquadGroup), controlNull];
        _ctrlSquadDesignator = _display getVariable [QGVAR(CreateSquadDesignator), controlNull];
        (_ctrlSquadDesignator select 1) ctrlSetText ((call EFUNC(Squad,getNextSquadId)) select [0, 1]);
        private _position = ctrlPosition _grpCreateSquad;
        _position set [1, _yPos + _spacing + PY(6)];
        _grpCreateSquad ctrlSetPosition _position;
        _grpCreateSquad ctrlCommit(0);

    };





};

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
    showHUD [true, true, true, true, true, true, true, true];
    [UIVAR(RespawnScreen), false] call CFUNC(blurScreen);
}] call CFUNC(addEventHandler);

// Wait for the mission start first.
["missionStarted", {
    // Choose the initial side for the player before showing the respawn screen.
    [QGVAR(SideSelection)] call BIS_fnc_startLoadingScreen;

    // We need a mutex to ensure the player detects the side with fewest players correctly
    [{
        50 call BIS_fnc_progressLoadingScreen;

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

        // Open the respawn UI
        [{
            [QGVAR(SideSelection)] call BIS_fnc_endLoadingScreen;

            private _welcomeScreenDisplay = (findDisplay 46) createDisplay "RscDisplayLoadMission";
            [UIVAR(WelcomeScreen_onLoad), _welcomeScreenDisplay] call CFUNC(localEvent);
        }] call CFUNC(execNextFrame);

    }, [], "respawn"] call CFUNC(mutex);
}] call CFUNC(addEventHandler);

[UIVAR(WelcomeScreen_onLoad), {
    (_this select 0) params ["_display"];
    uiNamespace setVariable [QGVAR(welcomeDisplay), _display];

    // Disable esc button
    _display displayAddEventHandler ["KeyDown", {_this select 1 == 1}];

    // Hide the mission info and chat
    (_display displayCtrl 2300) ctrlShow false;
    showChat false;

    // Create welcome controls
    private _background = _display ctrlCreate ["RscText", 6000];
    _background ctrlSetPosition [0.5 - PX(40), 0.5 - PY(20), PX(80), PY(40)];
    _background ctrlSetBackgroundColor [0, 0, 0, 0.7];
    _background ctrlCommit 0;
    private _content = _display ctrlCreate ["RscHTML", 6001];
    _content ctrlSetPosition [0.5 - PX(39), 0.5 - PY(19), PX(78), PY(38)];
    _content ctrlCommit 0;
    _content htmlLoad format ["https://www.atwar-mod.com/popup/%1/%2", EGVAR(Common,VersionInfo) select 1 select 0, CLib_Player call CFUNC(name)];
    private _continueButton = _display ctrlCreate ["RscButtonMenu", 6002];
    _continueButton ctrlSetPosition [0.5 - PX(40), 0.5 + PY(20.5), PX(80), (((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25];
    _continueButton ctrlSetText "CONTINUE";
    _continueButton ctrlAddEventHandler ["ButtonClick", {
        [{
            showChat true;
            (findDisplay 46) createDisplay UIVAR(RespawnScreen);
        }] call CFUNC(execNextFrame);
        false
    }];
    _continueButton ctrlCommit 0;
    ctrlSetFocus _continueButton;
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onLoad), {
    (_this select 0) params ["_display"];
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
        [_display, [-PX(40), 0]] call EFUNC(Common,registerDisplayNotification);

        if (!(alive CLib_Player) || (CLib_Player getVariable [QEGVAR(Common,tempUnit), false])) then {
            // Catch the escape key
            _display displayAddEventHandler ["KeyDown", FUNC(showDisplayInterruptEH)];
        };

        // Update the MissionName Text
        (_display displayCtrl 501) ctrlSetStructuredText parseText (getText (missionConfigFile >> "onLoadMission"));

        // Update Tickets
        private _startTickets = getNumber (missionConfigFile >> QPREFIX >> "tickets");
        private _firstSide = EGVAR(Common,competingSides) select 0;
        private _secondSide = EGVAR(Common,competingSides) select 1;

        (_display displayCtrl 601) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,Flag_%1), _firstSide], "#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);

        (_display displayCtrl 603) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,sideName_%1), _firstSide], ""]);
        private _pos = ctrlPosition (_display displayCtrl 603);
        _pos set [1, PY(3.875)];
        (_display displayCtrl 603) ctrlSetPosition _pos;
        (_display displayCtrl 603) ctrlCommit 0;

        (_display displayCtrl 605) ctrlSetText str ({_firstSide == side group _x} count allPlayers);
        _pos = ctrlPosition (_display displayCtrl 605);
        _pos set [1, PY(7.5)];
        (_display displayCtrl 605) ctrlSetPosition _pos;
        (_display displayCtrl 605) ctrlCommit 0;

        (_display displayCtrl 602) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,Flag_%1), _secondSide], "#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);

        (_display displayCtrl 604) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,sideName_%1), _secondSide], ""]);
        _pos = ctrlPosition (_display displayCtrl 604);
        _pos set [1, PY(3.875)];
        (_display displayCtrl 604) ctrlSetPosition _pos;
        (_display displayCtrl 604) ctrlCommit 0;

        (_display displayCtrl 606) ctrlSetText str ({_secondSide == side group _x} count allPlayers);
        _pos = ctrlPosition (_display displayCtrl 606);
        _pos set [1, PY(7.5)];
        (_display displayCtrl 606) ctrlSetPosition _pos;
        (_display displayCtrl 606) ctrlCommit 0;

        private _captionPlayer = _display ctrlCreate ["RscTextNoShadow", 607, (_display displayCtrl 600)];
        _captionPlayer ctrlSetFontHeight PY(2);
        _captionPlayer ctrlSetFont "PuristaMedium";
        _captionPlayer ctrlSetText "PLAYER";
        _captionPlayer ctrlSetPosition [PX(20-4), PY(7.5), PX(8), PY(2)];
        _captionPlayer ctrlCommit 0;

        private _captionTickets = _display ctrlCreate ["RscTextNoShadow", 608, (_display displayCtrl 600)];
        _captionTickets ctrlSetFontHeight PY(2);
        _captionTickets ctrlSetFont "PuristaSemiBold";
        _captionTickets ctrlSetText (str (missionNamespace getVariable [format [QEGVAR(Tickets,sideTickets_%1), playerSide], _startTickets]) + " TICKETS AVAILABLE");
        _captionTickets ctrlSetPosition [PX(20-10), PY(9.5), PX(20), PY(2)];
        _captionTickets ctrlCommit 0;


        {
            private _pos = ctrlPosition (_display displayCtrl _x);
            _pos set [1, (_pos select 1) - PY(2)];
            (_display displayCtrl _x) ctrlSetPosition _pos;
            (_display displayCtrl _x) ctrlCommit 0;
            nil
        } count [601, 602, 603, 604, 605, 606, 607, 608];

        [{
            private _display = uiNamespace getVariable [QGVAR(respawnDisplay), displayNull];

            if (isNull _display) exitWith {
                (_this select 1) call CFUNC(removePerFrameHandler);
            };

            private _firstSide = EGVAR(Common,competingSides) select 0;
            private _secondSide = EGVAR(Common,competingSides) select 1;

            private _startTickets = getNumber (missionConfigFile >> QPREFIX >> "tickets");
            (_display displayCtrl 605) ctrlSetText str ({_firstSide == side group _x} count allPlayers);
            (_display displayCtrl 606) ctrlSetText str ({_secondSide == side group _x} count allPlayers);

            {
                (_display displayCtrl _x) ctrlCommit 0;
                nil;
            } count [605, 606];
        }, 1] call CFUNC(addPerFrameHandler);

        (_display displayCtrl 500) call FUNC(fadeControl); // MissionName
        (_display displayCtrl 600) call FUNC(fadeControl); // Tickets
    }, _display] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

["ticketsChanged", {
    private _display = uiNamespace getVariable [QGVAR(respawnDisplay), displayNull];
    if (isNull _display || EGVAR(Tickets,deactivateTicketSystem)) exitWith {};

    private _startTickets = getNumber (missionConfigFile >> QPREFIX >> "tickets");
    (_display displayCtrl 608) ctrlSetText (str (missionNamespace getVariable [format [QEGVAR(Tickets,sideTickets_%1), playerSide], _startTickets]) + " TICKETS AVAILABLE");
    (_display displayCtrl 608) ctrlCommit 0;

}] call CFUNC(addEventHandler);

["playerSideChanged", {
    private _display = uiNamespace getVariable [QGVAR(respawnDisplay), displayNull];
    if (isNull _display) exitWith {};

    private _firstSide = EGVAR(Common,competingSides) select 0;
    private _secondSide = EGVAR(Common,competingSides) select 1;

    private _startTickets = getNumber (missionConfigFile >> QPREFIX >> "tickets");
    (_display displayCtrl 605) ctrlSetText str ({_firstSide == side group _x} count allPlayers);
    (_display displayCtrl 606) ctrlSetText str ({_secondSide == side group _x} count allPlayers);

    {
        (_display displayCtrl _x) ctrlCommit 0;
        nil;
    } count [605, 606];
}] call CFUNC(addEventHandler);

["endMission", {
    private _display = uiNamespace getVariable [QGVAR(respawnDisplay), displayNull];
    _display closeDisplay 1;
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
    _controlText ctrlSetStructuredText parseText format ["%1", _text];
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
