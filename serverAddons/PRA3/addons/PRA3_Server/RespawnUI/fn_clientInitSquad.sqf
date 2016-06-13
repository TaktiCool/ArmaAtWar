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
/*
 * #### TEAM INFO SCREEN ####
 * TEAM INFO
 */
[UIVAR(TeamInfoScreen_onLoad), {
    // The dialog needs one frame until access to controls is possible
    [{
        // Update the values of the UI elements
        UIVAR(RespawnScreen_TeamInfo_update) call CFUNC(localEvent);

        // Fade the control in
        100 call FUNC(fadeControl);
    }] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

// When the player side changes update the team info
["playerSideChanged", {
    UIVAR(RespawnScreen_TeamInfo_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_TeamInfo_update), {
    if (!dialog) exitWith {};

    disableSerialization;

    // Update the flag and text
    ctrlSetText [102, (missionNamespace getVariable [format [QEGVAR(Mission,Flag_%1), playerSide], ""])];
    ctrlSetText [103, (missionNamespace getVariable [format [QEGVAR(Mission,SideName_%1), playerSide], ""])];
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_ChangeSideBtn_onButtonClick), {
    call EFUNC(Squad,switchSide);
}] call CFUNC(addEventHandler);

/*
 * #### SQUAD SCREEN ####
 */
[UIVAR(SquadScreen_onLoad), {
    // The dialog needs one frame until access to controls is possible
    [{
        // Update the values of the UI elements
        UIVAR(RespawnScreen_NewSquadDesignator_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_SquadTypeCombo_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_SquadManagement_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_SquadMemberManagement_update) call CFUNC(localEvent);

        // Fade the control in
        200 call FUNC(fadeControl);
    }] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

/*
 * NEW SQUAD DESIGNATOR
 */
// This should update on side change and when a new squad is created
["playerSideChanged", {
    (_this select 0) params ["_newSide", "_oldSide"];
    [UIVAR(RespawnScreen_NewSquadDesignator_update), _oldSide] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

["groupChanged", {
    [UIVAR(RespawnScreen_NewSquadDesignator_update), playerSide] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_NewSquadDesignator_update), {
    if (!dialog) exitWith {};

    disableSerialization;

    ctrlSetText [203, (call EFUNC(Squad,getNextSquadId)) select [0, 1]];
}] call CFUNC(addEventHandler);

// Create Squad Description Limit
[UIVAR(RespawnScreen_SquadDescriptionInput_TextChanged), {
    private _description = ctrlText 204;
    if (count _description > 14) then {

        (findDisplay 1000 displayCtrl 204) ctrlSetBackgroundColor [0.77, 0.51, 0.08, 1];
        (findDisplay 1000 displayCtrl 204) ctrlCommit 0;
        [{
            (findDisplay 1000 displayCtrl 204) ctrlSetBackgroundColor [0.4, 0.4, 0.4, 1];
            (findDisplay 1000 displayCtrl 204) ctrlCommit 0;
        }, 1] call CFUNC(wait);

        ctrlSetText [204, (_description select [0, 14])];
    };
}] call CFUNC(addEventHandler);

/*
 * SQUAD TYPE COMBO
 */
// This should update on side change and when a new squad is created
["playerSideChanged", {
    (_this select 0) params ["_newSide", "_oldSide"];
    [UIVAR(RespawnScreen_SquadTypeCombo_update), _oldSide] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

["groupChanged", {
    [UIVAR(RespawnScreen_SquadTypeCombo_update), playerSide] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_SquadTypeCombo_update), {
    if (!dialog) exitWith {};

    disableSerialization;

    // SquadTypeCombo @todo restore focus if necessary
    private _selectedGroupType = lbData [205, lbCurSel 205];
    lbClear 205;

    private _visibleGroupTypes = [];
    {
        private _groupTypeName = configName _x;
        if ([_groupTypeName] call EFUNC(Squad,canUseSquadType)) then {
            private _rowNumber = lbAdd [205, [format [QEGVAR(Squad,GroupTypes_%1_displayName), _groupTypeName], ""] call CFUNC(getSetting)];
            lbSetData [205, _rowNumber, _groupTypeName];
            _visibleGroupTypes pushBack _groupTypeName;

            if (_groupTypeName == _selectedGroupType) then {
                lbSetCurSel [205, _rowNumber];
            };
        };
        nil
    } count ("true" configClasses (missionConfigFile >> "PRA3" >> "GroupTypes"));
    if (lbSize 205 == 0) then {
        lbSetCurSel [205, -1];
    } else {
        if (_selectedGroupType == "" || !(_selectedGroupType in _visibleGroupTypes)) then {
            lbSetCurSel [205, 0];
        };
    };
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_CreateSquadBtn_onButtonClick), {
    disableSerialization;
    private _description = ctrlText 204;
    if (count _description > 14) then {
        _description = _description select [0, 14];
    };

    private _type = lbData [205, lbCurSel 205];

    [_description, _type] call EFUNC(Squad,createSquad);
}] call CFUNC(addEventHandler);

/*
 * SQUAD LIST
 */
// When the group changes update the squad list for new squad member count
// This needs to be global cause it triggers on side change too
["playerSideChanged", {
    (_this select 0) params ["_newSIde", "_oldSide"];
    [UIVAR(RespawnScreen_SquadManagement_update), _oldSide] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

["groupChanged", {
    [UIVAR(RespawnScreen_SquadManagement_update), playerSide] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_SquadManagement_update), {
    if (!dialog) exitWith {};

    // Prepare the data for the lnb
    private _lnbData = [];
    {
        private _groupId = groupId _x;
        if (side _x == playerSide && _groupId in EGVAR(Squad,squadIds)) then {
            private _squadDesignator = _groupId select [0, 1];
            private _description = _x getVariable [QEGVAR(Squad,Description), str _x];
            private _groupType = _x getVariable [QEGVAR(Squad,Type), ""];
            private _groupTypeName = [format [QEGVAR(Squad,GroupTypes_%1_displayName), _groupType], ""] call CFUNC(getSetting);
            private _groupSize = [format [QEGVAR(Squad,GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting);

            _lnbData pushBack [[_squadDesignator, _description, _groupTypeName, format ["%1 / %2", count ([_x] call CFUNC(groupPlayers)), _groupSize]], _x];
        };
        nil
    } count allGroups;

    // Update the lnb
    [207, _lnbData] call FUNC(updateListNBox); // This may trigger an lbSelChanged event

    //@todo highlight current squad
//    for "_i" from 0 to 4 do {
//        lnbSetColor [207, [_rowNumber, _i], [0.77, 0.51, 0.08, 1]];
//    };
}] call CFUNC(addEventHandler);

/*
 * SQUAD MEMBER LIST
 */
[QGVAR(KitChanged), {
    [UIVAR(RespawnScreen_SquadMemberManagement_update), group PRA3_Player] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_SquadList_onLBSelChanged), {
    UIVAR(RespawnScreen_SquadMemberManagement_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

// SquadManagement
[UIVAR(RespawnScreen_SquadMemberManagement_update), {
    // Get the selected value
    private _selectedEntry = lnbCurSelRow 207;
    if (_selectedEntry == -1) exitWith {
        ctrlSetText [209, "SELECT A SQUAD"];
        lnbClear 210;
        lnbSetCurSelRow [210, -1];
        ctrlShow [211, false];
    };
    private _selectedSquad = [207, [_selectedEntry, 0]] call CFUNC(lnbLoad);

    // HeadingSquadDetails
    ctrlSetText [209, groupId _selectedSquad];

    // SquadMemberList
    private _lnbData = ([_selectedSquad] call CFUNC(groupPlayers)) apply {
        private _selectedKit = _x getVariable [QEGVAR(Kit,kit), ""];
        private _kitIcon = ([_selectedKit, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;

        [[[_x] call CFUNC(name)], _x, _kitIcon]
    };
    [210, _lnbData] call FUNC(updateListNBox); // This may trigger an lbSelChanged event

    // JoinLeaveBtn
    if (_selectedSquad == group PRA3_Player) then {
        ctrlSetText [211, "LEAVE"];
        ctrlShow [211, true];
    } else {
        private _groupType = _selectedSquad getVariable [QEGVAR(Squad,Type), ""];
        private _groupSize = [format [QEGVAR(Squad,GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting);

        ctrlSetText [211, "JOIN"];
        ctrlShow [211, (count ([_selectedSquad] call CFUNC(groupPlayers))) < _groupSize];
    };
}] call CFUNC(addEventHandler);

/*
 * SQUAD MEMBER BUTTONS
 */
[UIVAR(RespawnScreen_SquadMemberList_onLBSelChanged), {
    UIVAR(RespawnScreen_SquadMemberButtons_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

["leaderChanged", {
    // Get the selected value
    private _selectedEntry = lnbCurSelRow 207;
    if (_selectedEntry == -1) exitWith {
        ctrlSetText [209, "SELECT A SQUAD"];
        lnbClear 210;
        ctrlShow [211, false];
    };
    private _selectedSquad = [207, [_selectedEntry, 0]] call CFUNC(lnbLoad);

    if (_selectedSquad == group PRA3_Player) then {
        UIVAR(RespawnScreen_SquadMemberButtons_update) call CFUNC(localEvent);
    };
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_SquadMemberButtons_update), {
    // Get the selected value
    private _selectedEntry = lnbCurSelRow 210;
    if (_selectedEntry == -1) exitWith {
        ctrlShow [212, false];
        ctrlShow [213, false];
    };
    private _selectedGroupMember = [210, [_selectedEntry, 0]] call CFUNC(lnbLoad);

    // KickBtn
    private _buttonsVisible = (PRA3_Player == leader _selectedGroupMember && PRA3_Player != _selectedGroupMember);
    ctrlShow [212, _buttonsVisible];

    // PromoteBtn
    ctrlShow [213, _buttonsVisible];
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_JoinLeaveBtn_onButtonClick), {
    disableSerialization;

    private _selectedGroup = [207, [lnbCurSelRow 207, 0]] call CFUNC(lnbLoad);

    if (_selectedGroup == group PRA3_Player) then {
        call EFUNC(Squad,leaveSquad);
    } else {
        [_selectedGroup] call EFUNC(Squad,joinSquad);
    };
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_KickBtn_onButtonClick), {
    disableSerialization;

    private _selectedGroupMember = [210, [lnbCurSelRow 210, 0]] call CFUNC(lnbLoad);

    [_selectedGroupMember] call EFUNC(Squad,kickMember);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_PromoteBtn_onButtonClick), {
    disableSerialization;

    private _selectedGroupMember = [210, [lnbCurSelRow 210, 0]] call CFUNC(lnbLoad);

    [_selectedGroupMember] call EFUNC(Squad,promoteMember);
}] call CFUNC(addEventHandler);
