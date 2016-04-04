#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    [Description]

    Parameter(s):
    None

    Returns:
    None
*/

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
    [{
        params ["_group"];

        private _sidePlayerCount = EGVAR(Mission,competingSides) apply {
            private _side = call compile _x;
            [{side group _x == _side} count (allPlayers), _side]
        };
        _sidePlayerCount sort true;
        private _newSide = _sidePlayerCount select 0 select 1;

        PRA3_Player setVariable [CGVAR(tempUnit), true];
        [_newSide, createGroup _newSide, [-1000, -1000, 10], true] call CFUNC(respawn);
    }, []] call CFUNC(mutex);

    createDialog UIVAR(RespawnScreen);
    (findDisplay 1000) displayAddEventHandler ["KeyDown", FUNC(escapeFnc)];

    ["Killed", {
        setPlayerRespawnTime 10e10;
        createDialog UIVAR(RespawnScreen);
        (findDisplay 1000) displayAddEventHandler ["KeyDown", FUNC(escapeFnc)];
    }] call CFUNC(addEventHandler);

    ["Respawn Screen", PRA3_Player, 0, {!dialog}, {
        createDialog UIVAR(RespawnScreen);
    }] call CFUNC(addAction);
}] call CFUNC(addEventHandler);


["playerSideChanged", {
    [UIVAR(RespawnScreen_TeamInfo_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

["leaderChanged", {
    [UIVAR(RespawnScreen_SquadManagement_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

["groupChanged", {
    _this select 0 params ["_newGroup", "_oldGroup"];

    [UIVAR(RespawnScreen_SquadManagement_update)] call CFUNC(globalEvent);
    [UIVAR(RespawnScreen_RoleManagement_update), [_newGroup, _oldGroup]] call CFUNC(targetEvent);
    [UIVAR(RespawnScreen_DeploymentManagement_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

/*
 * Respawn
 */
[UIVAR(RespawnScreen_onLoad), {
    showHUD [true,true,true,true,true,true,false,true];
    [UIVAR(RespawnScreen), true] call CFUNC(blurScreen);

    // The dialog needs one frame until access to controls via IDC is possible
    [{

        [UIVAR(RespawnScreen_TeamInfo_update)] call CFUNC(localEvent);
        [UIVAR(RespawnScreen_SquadManagement_update)] call CFUNC(localEvent);
        [UIVAR(RespawnScreen_RoleManagement_update)] call CFUNC(localEvent);
        [UIVAR(RespawnScreen_DeploymentManagement_update)] call CFUNC(localEvent);
    }, _display] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onUnload), {
    showHUD [true,true,true,true,true,true,true,true];

    [UIVAR(RespawnScreen), false] call CFUNC(blurScreen);
}] call CFUNC(addEventHandler);

GVAR(lastRespawnFrame) = 0;
[UIVAR(RespawnScreen_DeployButton_action), {
    // Check squad
    if (!((groupId group PRA3_Player) in GVAR(squadIds))) exitWith {
        ["Join a squad!"] call CFUNC(displayNotification);
    };

    // Check role
    [{
        if (diag_frameNo == GVAR(lastRespawnFrame)) exitWith {};

        // Check kit
        private _currentRoleSelection = lnbCurSelRow 303;
        if (_currentRoleSelection < 0) exitWith {
            ["Select a role!"] call CFUNC(displayNotification);
        };

        // Check deployment
        private _currentDeploymentPointSelection = lnbCurSelRow 403;
        if (_currentDeploymentPointSelection < 0) exitWith {
            ["Select spawn point!"] call CFUNC(displayNotification);
        };
        _currentDeploymentPointSelection = [403, [_currentDeploymentPointSelection, 0]] call CFUNC(lnbLoad);
        GVAR(deploymentPoints) params ["_pointIds", "_pointData"];
        private _pointDetails = _pointData select (_pointIds find _currentDeploymentPointSelection);
        private _tickets = _pointDetails select 2;
        private _deployPosition = _pointDetails select 3;
        if (_tickets == 0) exitWith {
            ["Spawn point has no tickets left!"] call CFUNC(displayNotification);
        };
        if (_tickets > 0) then {
            _tickets = _tickets - 1;
            _pointDetails set [2, _tickets];
            if (_tickets == 0) then {
                [group PRA3_Player] call EFUNC(Deployment,destroyRally);
            } else {
                publicVariable QEGVAR(Deployment,deploymentPoints);
            };
            [UIVAR(RespawnScreen_DeploymentManagement_update), group PRA3_Player] call CFUNC(targetEvent);
        };

        // Spawn
        [playerSide, group PRA3_Player, _deployPosition] call CFUNC(respawn);

        // fix issue that player spawn Prone
        ["switchMove",[PRA3_Player, ""]] call CFUNC(globalEvent);

        // Apply selected kit
        private _currentKitName = PRA3_Player getVariable [QEGVAR(Kit,kit), ""];
        [_currentKitName] call EFUNC(Kit,applyKit);

        GVAR(lastRespawnFrame) = diag_frameNo;

        closeDialog 2;
    }] call CFUNC(mutex);
}] call CFUNC(addEventHandler);

/*
 * Role managment
 */
GVAR(lastRoleManagementUIUpdateFrame) = 0;

[UIVAR(RespawnScreen_RoleManagement_update), {
    if (!dialog || GVAR(lastRoleManagementUIUpdateFrame) == diag_frameNo) exitWith {};
    GVAR(lastRoleManagementUIUpdateFrame) = diag_frameNo;

    disableSerialization;

    // RoleList
#define IDC 303
    private _selectedLnbRow = lnbCurSelRow IDC;
    private _previousSelectedKit = PRA3_Player getVariable [QEGVAR(Kit,kit), ""];
    private _selectedKit = [[IDC, [lnbCurSelRow IDC, 0]] call CFUNC(lnbLoad), _previousSelectedKit] select (_selectedLnbRow == -1);
    PRA3_Player setVariable [QEGVAR(Kit,kit), _selectedKit, true];
    private _visibleKits = call EFUNC(Kit,getAllKits) select {[_x] call EFUNC(Kit,getUsableKitCount) > 0};

    if (_visibleKits isEqualTo []) then {
        lnbSetCurSelRow [IDC, -1];
        _selectedKit = "";
        PRA3_Player setVariable [QEGVAR(Kit,kit), _selectedKit, true];
    } else {
        if (_selectedKit == "" || !(_selectedKit in _visibleKits)) then {
            _selectedKit = _visibleKits select 0;
            PRA3_Player setVariable [QEGVAR(Kit,kit), _selectedKit, true];
        };
    };

    if (_previousSelectedKit != _selectedKit) then {
        [UIVAR(RespawnScreen_SquadManagement_update), group PRA3_Player] call CFUNC(targetEvent);
        [UIVAR(RespawnScreen_RoleManagement_update), group PRA3_Player] call CFUNC(targetEvent);
    };

    lnbClear IDC;
    {
        private _kitName = _x;
        private _kitDetails = [_kitName, [["displayName", ""], ["UIIcon", ""]]] call EFUNC(Kit,getKitDetails);
        _kitDetails params ["_displayName", "_UIIcon"];

        private _usedKits = {(_x getVariable [QEGVAR(Kit,kit), ""]) == _kitName} count units group PRA3_Player;

        private _rowNumber = lnbAddRow [IDC, [_displayName, format ["%1 / %2", _usedKits, [_kitName] call EFUNC(Kit,getUsableKitCount)]]];
        [IDC, [_rowNumber, 0], _x] call CFUNC(lnbSave);

        lnbSetPicture [IDC, [_rowNumber, 0], _UIIcon];

        if (_x == _selectedKit) then {
            lnbSetCurSelRow [IDC, _rowNumber];
        };

        nil
    } count _visibleKits;

    // WeaponTabs
#undef IDC
#define IDC 304
    private _index = (lbCurSel IDC);
    if !(_index in [0,1,2]) then {
        _index = 0;
    };
    private _selectedKitDetails = [_selectedKit, [[["primaryWeapon", "secondaryWeapon", "handGunWeapon"] select _index, ""]]] call EFUNC(Kit,getKitDetails);

    // WeaponPicture
#undef IDC
#define IDC 306
    ctrlSetText [IDC, getText (configFile >> "CfgWeapons" >> _selectedKitDetails select 0 >> "picture")];

    // WeaponName
#undef IDC
#define IDC 307
    ctrlSetText [IDC, getText (configFile >> "CfgWeapons" >> _selectedKitDetails select 0 >> "displayName")];
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_RoleList_onLBSelChanged), {
    [UIVAR(RespawnScreen_RoleManagement_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_WeaponTabs_onToolBoxSelChanged), {
    [UIVAR(RespawnScreen_RoleManagement_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);



/*
 * Deployment
 */
GVAR(lastDeploymentManagementUIUpdateFrame) = 0;

[UIVAR(RespawnScreen_DeploymentManagement_update), {
    if (!dialog || GVAR(lastDeploymentManagementUIUpdateFrame) == diag_frameNo) exitWith {};
    GVAR(lastDeploymentManagementUIUpdateFrame) = diag_frameNo;

    disableSerialization;

    // SpawnPointList
#undef IDC
#define IDC 403
    private _selectedLnbRow = lnbCurSelRow IDC;
    private _selectedPoint = [[IDC, [lnbCurSelRow IDC, 0]] call CFUNC(lnbLoad), ""] select (_selectedLnbRow == -1);
    GVAR(deploymentPoints) params ["_pointIds", "_pointData"];
    private _visiblePoints = _pointIds select {
        private _pointDetails = _pointData select (_pointIds find _x);
        (_pointDetails select 5) call (_pointDetails select 4)
    };
    lnbClear IDC;
    {
        private _pointDetails = _pointData select (_pointIds find _x);
        _pointDetails params ["_name", "_icon", "_tickets"];
        if (_tickets > 0) then {
            _name = format ["%1 (%2)", _name, _tickets];
        };

        private _rowNumber = lnbAddRow [IDC, [_name]];
        [IDC, [_rowNumber, 0], _x] call CFUNC(lnbSave);

        lnbSetPicture [IDC, [_rowNumber, 0], _icon];

        if (_x == _selectedPoint) then {
            lnbSetCurSelRow [IDC, _rowNumber];
        };
    } count _visiblePoints;
    if ((lnbSize IDC select 0) == 0) then {
        lnbSetCurSelRow [IDC, -1];
        _selectedPoint = "";
    } else {
        if (_selectedPoint == "" || !(_selectedPoint in _visiblePoints)) then {
            lnbSetCurSelRow [IDC, 0];
            _selectedPoint = [IDC, [0, 0]] call CFUNC(lnbLoad);
        };
    };

    // Map
#undef IDC
#define IDC 700
    if (_selectedPoint != "") then {
        private _map = (findDisplay 1000) displayCtrl IDC;
        private _pointDetails = _pointData select (_pointIds find _selectedPoint);

        _map ctrlMapAnimAdd [0.5, 0.15, _pointDetails select 3]; //@todo check if dialog syntax can be used
        ctrlMapAnimCommit _map;
    };
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_SpawnPointList_onLBSelChanged), {
    [UIVAR(RespawnScreen_DeploymentManagement_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

/*
 * Squad Managemant
 */
GVAR(lastSquadManagementUIUpdateFrame) = 0;

// TeamInfo
[UIVAR(RespawnScreen_TeamInfo_update), {
    if (!dialog) exitWith {};

    disableSerialization;

    // TeamFlag
#undef IDC
#define IDC 102
    ctrlSetText [IDC, (missionNamespace getVariable [format [QEGVAR(Mission,Flag_%1), playerSide], ""])];

    // TeamName
#undef IDC
#define IDC 103
    ctrlSetText [IDC, (missionNamespace getVariable [format [QEGVAR(Mission,SideName_%1), playerSide], ""])];
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_ChangeSideBtn_onButtonClick), {
    call EFUNC(Squad,switchSide);
}] call CFUNC(addEventHandler);

// SquadManagement
[UIVAR(RespawnScreen_SquadManagement_update), {
    if (!dialog || GVAR(lastSquadManagementUIUpdateFrame) == diag_frameNo) exitWith {};
    GVAR(lastSquadManagementUIUpdateFrame) = diag_frameNo;

    disableSerialization;

    // NewSquadDesignator
#undef IDC
#define IDC 203
    ctrlSetText [IDC, (call EFUNC(Squad,getNextSquadId)) select [0, 1]];

    // SquadTypeCombo
#undef IDC
#define IDC 205
    private _selectedGroupType = lbData [IDC, lbCurSel IDC];
    private _visibleGroupTypes = ("true" configClasses (missionConfigFile >> "PRA3" >> "GroupTypes") apply {configName _x}) select {[_x] call EFUNC(Squad,canUseSquadType)};
    lbClear IDC;
    {
        private _rowNumber = lbAdd [IDC, [format [QEGVAR(Squad,GroupTypes_%1_displayName), _x], ""] call CFUNC(getSetting)];
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
#undef IDC
#define IDC 207
    private _selectedLnbRow = lnbCurSelRow IDC;
    private _selectedGroup = [[IDC, [lnbCurSelRow IDC, 0]] call CFUNC(lnbLoad), grpNull] select (_selectedLnbRow == -1);
    private _visibleGroups = allGroups select {side _x == playerSide && (groupId _x) in GVAR(squadIds)};
    lnbClear IDC;
    {
        private _description = _x getVariable [QEGVAR(Squad,Description), str _x];
        private _groupType = _x getVariable [QEGVAR(Squad,Type), ""];
        private _groupTypeName = [format [QEGVAR(Squad,GroupTypes_%1_displayName), _groupType], ""] call CFUNC(getSetting);
        private _groupSize = [format [QEGVAR(Squad,GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting);

        private _rowNumber = lnbAddRow [IDC, [(groupId _x) select [0, 1], _description, _groupTypeName, format ["%1 / %2", count units _x, _groupSize]]];
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
#undef IDC
#define IDC 209
    if (isNull _selectedGroup) then {
        ctrlSetText [IDC, "SELECT A SQUAD"];
    } else {
        ctrlSetText [IDC, groupId _selectedGroup];
    };

    // SquadMemberList
#undef IDC
#define IDC 210
    _selectedLnbRow = lnbCurSelRow IDC;
    private _selectedGroupMember = [[IDC, [lnbCurSelRow IDC, 0]] call CFUNC(lnbLoad), objNull] select (_selectedLnbRow == -1);
    private _visibleGroupMembers = units _selectedGroup;
    lnbClear IDC;
    {
        private _rowNumber = lnbAddRow [IDC, [[_x] call CFUNC(name)]];
        [IDC, [_rowNumber, 0], _x] call CFUNC(lnbSave);

        private _selectedKit = _x getVariable [QEGVAR(kit,kit), ""];
        private _kitIcon = ([_selectedKit, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;
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
#undef IDC
#define IDC 211
    if (isNull _selectedGroup) then {
        ctrlShow [IDC, false];
    } else {
        if (_selectedGroup == group PRA3_Player) then {
            ctrlSetText [IDC, "LEAVE"];
            ctrlShow [IDC, true];
        } else {
            private _groupType = _selectedGroup getVariable [QEGVAR(Squad,Type), ""];
            private _groupSize = [format [QEGVAR(Squad,GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting);

            ctrlSetText [IDC, "JOIN"];
            ctrlShow [IDC, (count units _selectedGroup) < _groupSize];
        };
    };

    // KickBtn
#undef IDC
#define IDC 212
    if (isNull _selectedGroupMember) then {
        ctrlShow [IDC, false];
    } else {
        ctrlShow [IDC, PRA3_Player == leader _selectedGroupMember && PRA3_Player != _selectedGroupMember];
    };

    // PromoteBtn
#undef IDC
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

    [_description, _type] call EFUNC(Squad,createSquad);
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
