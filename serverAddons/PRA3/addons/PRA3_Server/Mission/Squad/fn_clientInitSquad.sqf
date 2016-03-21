#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(GroupTypes), missionConfigFile >> "PRA3" >> "GroupTypes"] call CFUNC(loadSettings);

GVAR(squadIds) = [
    "ALPHA",
    "BRAVO",
    "CHARLIE",
    "DELTA",
    "ECHO",
    "FOXTROTT",
    "GOLF",
    "HOTEL",
    "INDIA",
    "JULIET",
    "KILO",
    "LIMA",
    "MIKE",
    "NOVEMBER",
    "OSCAR",
    "PAPA",
    "QUEBEC",
    "ROMEO",
    "SIERRA",
    "TANGO",
    "UNIFORM",
    "VICTOR",
    "WHISKEY",
    "XRAY",
    "YANKEE",
    "ZULU"
];

/*
 * UI STUFF
 */
GVAR(lastSquadManagementUIUpdateFrame) = 0;

// TeamInfo
[UIVAR(RespawnScreen_TeamInfo_update), {
    if (!dialog) exitWith {};

    disableSerialization;

    // TeamFlag
#define IDC 102
    ctrlSetText [IDC, (missionNamespace getVariable [format [QGVAR(Flag_%1), playerSide], ""])];

    // TeamName
#define IDC 103
    ctrlSetText [IDC, (missionNamespace getVariable [format [QGVAR(SideName_%1), playerSide], ""])];
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_ChangeSideBtn_onButtonClick), {
    call FUNC(changeSide);
}] call CFUNC(addEventHandler);

// SquadManagement
[UIVAR(RespawnScreen_SquadManagement_update), {
    if (!dialog || GVAR(lastSquadManagementUIUpdateFrame) == diag_frameNo) exitWith {};
    GVAR(lastSquadManagementUIUpdateFrame) = diag_frameNo;

    disableSerialization;

    // NewSquadDesignator
#define IDC 203
    ctrlSetText [IDC, (call FUNC(getNextSquadId)) select [0, 1]];

    // SquadTypeCombo
#define IDC 205
    private _selectedGroupType = lbData [IDC, lbCurSel IDC];
    private _visibleGroupTypes = "true" configClasses (missionConfigFile >> "PRA3" >> "GroupTypes") apply {configName _x} select {[_x] call FUNC(canUseSquadType)};
    lbClear IDC;
    {
        private _rowNumber = lbAdd [IDC, [format [QGVAR(GroupTypes_%1_displayName), _x], ""] call CFUNC(getSetting)];
        lbSetData [IDC, _rowNumber, _x];
        if (_x == _selectedGroupType) then {
            lbSetCurSel [IDC, _rowNumber];
        };
        nil
    } count _visibleGroupTypes;
    if (lbSize IDC == 0) then {
        lbSetCurSel [IDC, -1];
        _selectedGroupType = "";
    } else {
        if (_selectedGroupType == "" || !(_selectedGroupType in _visibleGroupTypes)) then {
            lbSetCurSel [IDC, 0];
            _selectedGroupType = lbData [IDC, 0];
        };
    };

    // SquadList
#define IDC 207
    private _selectedLnbRow = lnbCurSelRow IDC;
    private _selectedGroup = [[IDC, [lnbCurSelRow IDC, 0]] call CFUNC(lnbLoad), grpNull] select (_selectedLnbRow == -1);
    private _visibleGroups = allGroups select {side _x == playerSide && _x getVariable [QGVAR(Id), ""] != ""};
    lnbClear IDC;
    {
        private _groupId = _x getVariable [QGVAR(Id), ""];
        private _description = _x getVariable [QGVAR(Description), str _x];
        private _groupType = _x getVariable [QGVAR(Type), ""];
        private _groupTypeName = [format [QGVAR(GroupTypes_%1_displayName), _groupType], ""] call CFUNC(getSetting);
        private _groupSize = [format [QGVAR(GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting);

        private _rowNumber = lnbAddRow [IDC, [_groupId select [0, 1], _description, _groupTypeName, format ["%1 / %2", count units _x, _groupSize]]];
        [IDC, [_rowNumber, 0], _x] call CFUNC(lnbSave);

        if (_x == group PRA3_Player) then {
            for "_i" from 0 to 4 do {
                lnbSetColor [IDC, [_rowNumber, _i], [1, 0.4, 0, 1]];
            };
        };

        if (_x == _selectedGroup) then {
            lnbSetCurSelRow [IDC, _rowNumber];
        };
        nil
    } count _visibleGroups;
    if ((lnbSize IDC select 0) == 0) then {
        lnbSetCurSelRow [IDC, -1];
        _selectedGroup = grpNull;
    } else {
        if (isNull _selectedGroup || !(_selectedGroup in _visibleGroups)) then {
            lnbSetCurSelRow [IDC, 0];
            _selectedGroup = [IDC, [0, 0]] call CFUNC(lnbLoad);
        };
    };

    // HeadingSquadDetails
#define IDC 209
    if (isNull _selectedGroup) then {
        ctrlSetText [IDC, "SELECT A SQUAD"];
    } else {
        ctrlSetText [IDC, _selectedGroup getVariable [QGVAR(Id), ""]];
    };

    // SquadMemberList
#define IDC 210
    _selectedLnbRow = lnbCurSelRow IDC;
    private _selectedGroupMember = [[IDC, [lnbCurSelRow IDC, 0]] call CFUNC(lnbLoad), objNull] select (_selectedLnbRow == -1);
    private _visibleGroupMembers = units _selectedGroup;
    lnbClear IDC;
    {
        private _rowNumber = lnbAddRow [IDC, [[_x] call CFUNC(name)]];
        [IDC, [_rowNumber, 0], _x] call CFUNC(lnbSave);

        private _selectedKit = _x getVariable [QGVAR(kit), ""];
        private _kitIcon = ([_selectedKit, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call FUNC(getKitDetails)) select 0;
        lnbSetPicture [IDC, [_rowNumber, 0], _kitIcon];

        if (_x == _selectedGroupMember) then {
            lnbSetCurSelRow [IDC, _rowNumber];
        };
    } count _visibleGroupMembers;
    if ((lnbSize IDC select 0) == 0) then {
        lnbSetCurSelRow [IDC, -1];
        _selectedGroupMember = objNull;
    } else {
        if (isNull _selectedGroupMember || !(_selectedGroupMember in _visibleGroupMembers)) then {
            lnbSetCurSelRow [IDC, 0];
            _selectedGroupMember = [IDC, [0, 0]] call CFUNC(lnbLoad);
        };
    };

    // JoinLeaveBtn
#define IDC 211
    if (isNull _selectedGroup) then {
        ctrlShow [IDC, false];
    } else {
        if (_selectedGroup == group PRA3_Player) then {
            ctrlSetText [IDC, "LEAVE"];
            ctrlShow [IDC, true];
        } else {
            private _groupType = _selectedGroup getVariable [QGVAR(Type), ""];
            private _groupSize = [format [QGVAR(GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting);

            ctrlSetText [IDC, "JOIN"];
            ctrlShow [IDC, (count units _selectedGroup) < _groupSize];
        };
    };

    // KickBtn
#define IDC 212
    if (isNull _selectedGroupMember) then {
        ctrlShow [IDC, false];
    } else {
        ctrlShow [IDC, PRA3_Player == leader _selectedGroupMember && PRA3_Player != _selectedGroupMember];
    };

    // PromoteBtn
#define IDC 213
    if (isNull _selectedGroupMember) then {
        ctrlShow [IDC, false];
    } else {
        ctrlShow [IDC, PRA3_Player == leader _selectedGroupMember && PRA3_Player != _selectedGroupMember];
    };
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_CreateSquadBtn_onButtonClick), {
    disableSerialization;

    private _description = ctrlText 204;
    private _type = lbData [205, lbCurSel 205];

    [_description, _type] call FUNC(createSquad);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_JoinLeaveBtn_onButtonClick), {
    disableSerialization;

    private _selectedGroup = [207, [lnbCurSelRow 207, 0]] call CFUNC(lnbLoad);

    if (_selectedGroup == group PRA3_Player) then {
        call FUNC(leaveSquad);
    } else {
        [_selectedGroup] call FUNC(joinSquad);
    };
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_KickBtn_onButtonClick), {
    disableSerialization;

    private _selectedGroupMember = [210, [lnbCurSelRow 210, 0]] call CFUNC(lnbLoad);

    [_selectedGroupMember] call FUNC(kickMember);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_PromoteBtn_onButtonClick), {
    disableSerialization;

    private _selectedGroupMember = [210, [lnbCurSelRow 210, 0]] call CFUNC(lnbLoad);

    [_selectedGroupMember] call FUNC(promoteMember);
}] call CFUNC(addEventHandler);