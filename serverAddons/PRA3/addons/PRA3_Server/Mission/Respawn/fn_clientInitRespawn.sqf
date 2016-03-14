#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    -

    Returns:
    -
*/
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

["Respawn", {
    setPlayerRespawnTime 10e10;
}] call CFUNC(addEventHandler);

["Killed", {
    setPlayerRespawnTime 10e10;

    createDialog QEGVAR(UI,RespawnScreen);
    [QGVAR(updateTeamInfo)] call CFUNC(localEvent);
    [QGVAR(updateRoleList)] call CFUNC(localEvent);
    [QGVAR(updateDeploymentList)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[QGVAR(updateSquadMemberButtons), {
    disableSerialization;

    if (!dialog) exitWith {};

    private _currentSquadSelection = lnbCurSelRow 206;
    private _currentMemberSelection = lnbCurSelRow 209;

    if (_currentSquadSelection >= 0 && _currentMemberSelection >= 0) then {
        private _selectedGroup = [206, [_currentSquadSelection, 0]] call CFUNC(lnbLoad);
        private _selectedUnit = [209, [_currentMemberSelection, 0]] call CFUNC(lnbLoad);

        private _isVisible = (PRA3_Player == leader _selectedGroup && PRA3_Player != _selectedUnit);
        ctrlShow [211, _isVisible];
        ctrlShow [212, _isVisible];
    } else {
        ctrlShow [211, false];
        ctrlShow [212, false];
    };
}] call CFUNC(addEventHandler);

[QGVAR(updateSquadMemberList), {
    disableSerialization;

    if (!dialog) exitWith {};

    private _currentSelection = lnbCurSelRow 206;
    private _selectedGroup = grpNull;
    if (_currentSelection >= 0) then {
        _selectedGroup = [206, [_currentSelection, 0]] call CFUNC(lnbLoad);
    };

    lnbClear 209;
    if (!isNull _selectedGroup) then {
        ctrlSetText [208, (_selectedGroup getVariable [QGVAR(Id), ""])];

        private _unitCount = {
            private _rowNumber = lnbAddRow [209, ["", (_x call CFUNC(name))]];
            [209, [_rowNumber, 0], _x] call CFUNC(lnbSave);
            true
        } count units _selectedGroup;

        ctrlSetText [210, (["JOIN","LEAVE"] select (_selectedGroup == group PRA3_Player))];
        ctrlShow [210, (_unitCount < 9 || _selectedGroup == group PRA3_Player)];
    } else {
        ctrlSetText [208, "SELECT A SQUAD"];
        ctrlShow [210, false];
    };

    [QGVAR(updateSquadMemberButtons)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[QGVAR(updateSquadList), {
    disableSerialization;

    if (!dialog) exitWith {};

    private _currentSelection = lnbCurSelRow 206;
    private _selectedGroup = grpNull;
    if (_currentSelection >= 0) then {
        _selectedGroup = [206, [_currentSelection, 0]] call CFUNC(lnbLoad);
    };

    lnbClear 206;
    {
        if (side _x == side group PRA3_Player) then {
            private _groupId = _x getVariable [QGVAR(Id), ""];
            if (_groupId != "") then {
                private _rowNumber = lnbAddRow [206, [_groupId select [0, 1], _x getVariable [QGVAR(Description), str _x], str (count units _x) + " / 9"]];
                [206, [_rowNumber, 0], _x] call CFUNC(lnbSave);
                if (_x == group PRA3_Player) then {
                    lnbSetColor [206, [_rowNumber, 0], [1, 0.4, 0, 1]];
                };
                if (_x == _selectedGroup) then {
                    lnbSetCurSelRow [206, _rowNumber];
                };
            };
        };
        nil
    } count allGroups;

    ctrlSetText [203, (GVAR(squadIds) - (allGroups select {side _x == side group PRA3_Player} apply {_x getVariable QGVAR(Id)})) select 0 select [0, 1]];

    [QGVAR(updateSquadMemberList)] call CFUNC(localEvent); //@todo may be called twice due to lnbSetCurSelRow
}] call CFUNC(addEventHandler);

[QGVAR(updateTeamInfo), {
    disableSerialization;

    if (!dialog) exitWith {};

    private _currentSide = side group PRA3_Player;
    ctrlSetText [102, (missionNamespace getVariable [format [QGVAR(Flag_%1), _currentSide], ""])];
    ctrlSetText [103, (missionNamespace getVariable [format [QGVAR(SideName_%1), _currentSide], ""])];

    [QGVAR(updateSquadList)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[QGVAR(updateWeaponList), {
    disableSerialization;

    if (!dialog) exitWith {};

    private _currentSelection = lnbCurSelRow 303;

    if (_currentSelection >= 0) then {
        private _kitName = [303, [_currentSelection, 0]] call CFUNC(lnbLoad);
        DUMP(ctrlText 304)
        private _kitDetails = [_kitName, [["primaryWeapon", ""]]] call FUNC(getKitDetails);
        ctrlSetText [306, getText (configFile >> "CfgWeapons" >> _kitDetails select 0 >> "picture")];
        ctrlSetText [307, getText (configFile >> "CfgWeapons" >> _kitDetails select 0 >> "displayName")];
    };
}] call CFUNC(addEventHandler);

[QGVAR(updateRoleList), {
    disableSerialization;

    if (!dialog) exitWith {};

    private _requiredKitDetails = [["displayName", ""], ["groupMaxCount", -1], ["UIIcon", ""]];

    lnbClear 303;
    {
        private _kitDetails = [_x, _requiredKitDetails] call FUNC(getKitDetails);
        private _rowNumber = lnbAddRow [303, ["", _kitDetails select 0, format ["%1 / %2", 0, _kitDetails select 1]]];
        lnbSetPicture [303, [_rowNumber, 0], _kitDetails select 2];
        [303, [_rowNumber, 0], _x] call CFUNC(lnbSave);
        nil
    } count (call FUNC(getAllKits));

    lnbSetCurSelRow [303, 0];

    [QGVAR(updateWeaponList)] call CFUNC(localEvent); //@todo may be called twice due to lnbSetCurSelRow
}] call CFUNC(addEventHandler);

[QGVAR(updateMapControl), {
    disableSerialization;

    if (!dialog) exitWith {};

    private _map = (findDisplay 1000) displayCtrl 700;
    private _currentSelection = lnbCurSelRow 403;

    if (_currentSelection >= 0) then {
        _map ctrlMapAnimAdd [0.5, 0.15, [403, [_currentSelection, 0]] call CFUNC(lnbLoad)];
        ctrlMapAnimCommit _map;
    };
}] call CFUNC(addEventHandler);

[QGVAR(updateDeploymentList), {
    disableSerialization;

    if (!dialog) exitWith {};

    lnbClear 403;

    private _base = ["base_" + (str side group PRA3_Player)] call FUNC(getSector);
    private _rowNumber = lnbAddRow [403, ["BASE"]];
    [403, [_rowNumber, 0], getPos _base] call CFUNC(lnbSave);

    private _rallyPoint = (group PRA3_Player) getVariable [QGVAR(rallyPoint), [0, [], [], 0]];
    _rallyPoint params ["_placedTime", "_position", "_objects", "_spawnCount"];
    if (!(_position isEqualTo []) && _spawnCount > 0) then { // if spawnCount is zero the rally point should not exist (handle this on spawn)
        _rowNumber = lnbAddRow [403, ["RALLYPOINT " + ((group PRA3_Player) getVariable [QGVAR(Id), ""])]];
        [403, [_rowNumber, 0], _position] call CFUNC(lnbSave);
    };

    lnbSetCurSelRow [403, 0];

    [QGVAR(updateMapControl)] call CFUNC(localEvent); //@todo may be called twice due to lnbSetCurSelRow
}] call CFUNC(addEventHandler);

[QGVAR(requestSpawn), {
    disableSerialization;

    if (!dialog) exitWith {};

    // Check squad
    if ((group PRA3_Player) getVariable [QGVAR(Id), ""] == "") exitWith {systemChat "Join a squad!"};

    // Check role
    private _currentRoleSelection = lnbCurSelRow 303;
    if (_currentRoleSelection < 0) exitWith {systemChat "Select a role!"};
    private _kitName = [303, [_currentRoleSelection, 0]] call CFUNC(lnbLoad);
    if (!([_kitName] call FUNC(canUseKit))) exitWith {systemChat "Select another role!"};

    // Check deployment
    private _currentDeploymentSelection = lnbCurSelRow 403;
    if (_currentDeploymentSelection < 0) exitWith {systemChat "Select spawn point!"};
    private _deployPosition = [403, [_currentDeploymentSelection, 0]] call CFUNC(lnbLoad);

    [{
        PRA3_Player setPos _this; //@todo randomize position
    }, _deployPosition] call CFUNC(execNextFrame);

    setPlayerRespawnTime 0;
    closeDialog 2;
}] call CFUNC(addEventHandler);