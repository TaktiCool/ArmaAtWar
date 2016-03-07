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

["Killed", {
    params ["_args"];
    _args params ["_unit"];

    setPlayerRespawnTime 10e10;
    createDialog QEGVAR(UI,RespawnScreen);
    [QGVAR(updateTeamInfo)] call CFUNC(localEvent);
    [QGVAR(updateSquadList)] call CFUNC(localEvent);
    [QGVAR(updateRoleList)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[QGVAR(updateSquadMemberButtons), {
    disableSerialization;

    if (!dialog) exitWith {};

    private _currentSquadSelection = lnbCurSelRow 206;
    private _currentMemberSelection = lnbCurSelRow 209;

    if (_currentSquadSelection >= 0 && _currentMemberSelection >= 0) then {
        private _selectedGroup = groupFromNetId (lnbData [206, [_currentSquadSelection, 0]]);
        private _selectedUnit = objectFromNetId (lnbData [209, [_currentMemberSelection, 0]]);

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

    lnbClear 209;
    if (_currentSelection >= 0) then {
        private _selectedGroup = groupFromNetId (lnbData [206, [_currentSelection, 0]]);
        ctrlSetText [208, (_selectedGroup getVariable [QGVAR(Id), ""])];

        private _unitCount = {
            private _rowNumber = lnbAddRow [209, ["", name _x]]; //@todo what if player is dead?
            lnbSetData [209, [_rowNumber, 0], netId _x];
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
        _selectedGroup = groupFromNetId (lnbData [206, [_currentSelection, 0]]);
    };

    lnbClear 206;
    {
        if (side _x == side group PRA3_Player) then {
            private _groupId = _x getVariable [QGVAR(Id), ""];
            if (_groupId != "") then {
                private _rowNumber = lnbAddRow [206, [_groupId select [0, 1], _x getVariable [QGVAR(Description), str _x], str (count units _x) + " / 9"]];
                lnbSetData [206, [_rowNumber, 0], netId _x];
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
}] call CFUNC(addEventHandler);

[QGVAR(updateRoleList), {
    disableSerialization;

    if (!dialog) exitWith {};

    lnbClear 303;
    {
        private _loadout = GVAR(LoadoutCache) getVariable _x;
        private _rowNumber = lnbAddRow [303, ["", _loadout select 0 select 0, "? / ?"]];
        lnbSetPicture [303, [_rowNumber, 0], _loadout select 0 select 2];
        nil
    } count ([side group PRA3_Player] call FUNC(getAllLoadouts));

    //[QGVAR(updateSquadMemberList)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);