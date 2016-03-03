#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Handling onLoad Event of RespawnDialog

    Parameter(s):
    0: RespawnDialog <Dialog>

    Returns:
    None
*/
params ["_dialog"];

disableSerialization;
private _teamFlag = _dialog displayCtrl 102;
private _teamName = _dialog displayCtrl 103;
private _squadList = _dialog displayCtrl 206;
private _squadName = _dialog displayCtrl 208;
private _squadMemberList = _dialog displayCtrl 209;
private _joinLeaveButton = _dialog displayCtrl 210;
private _kickButton = _dialog displayCtrl 211;
private _promoteButton = _dialog displayCtrl 212;


GVAR(respawnScreenPFH) = [{
    disableSerialization;
    (_this select 0) params["_teamFlag","_teamName","_squadList","_squadName","_squadMemberList", "_joinLeaveButton", "_kickButton", "_promoteButton"];

    _teamFlag ctrlSetText (missionNamespace getVariable [format ["%1_%2",QGVAR(Flag),playerSide], ""]);
    _teamName ctrlSetText (missionNamespace getVariable [format ["%1_%2",QGVAR(SideName),playerSide], ""]);

    private _currentSelection = lnbCurSelRow _squadList;
    private _selectedGroupName = "";
    private _selectedGroup = grpNull;
    if (_currentSelection >= 0) then {
        _selectedGroupName = _squadList lnbData [_currentSelection,0];
    };

    lnbClear _squadList;
    private _currentGroups = [];
    {
        if (side _x == playerSide) then {
            private _groupId = _x getVariable ["PRA3_GroupId",""];
            if (_groupId != "") then {
                private _rowNumber = _squadList lnbAddRow [_groupId select [0,1], _x getVariable ["PRA3_description",""], format ["%1 / 9",count units _x]];
                _squadList lnbSetData [ [_rowNumber,0],_groupId];
                if (_selectedGroupName == _groupId) then {
                    _squadList lnbSetCurSelRow _rowNumber;
                    _selectedGroup = _x;
                };
            };
        };
        nil;
    } count allGroups;

    lnbClear _squadMemberList;
    if (!isNull _selectedGroup) then {
        _squadName ctrlSetText (_selectedGroup getVariable ["PRA3_GroupId",groupId _selectedGroup]);

        {

            private _rowNumber = _squadMemberList lnbAddRow [name _x];
            nil;
        } count units _selectedGroup;
        private _isLeader = (PRA3_player == leader _selectedGroup);

        _kickButton ctrlShow _isLeader;
        _promoteButton ctrlShow _isLeader;


        _joinLeaveButton ctrlSetText (["JOIN","LEAVE"] select (_selectedGroup == group PRA3_player));
        _joinLeaveButton ctrlShow true;
    } else {
        _squadName ctrlSetText "SELECT A SQUAD";

        _kickButton ctrlShow false;
        _promoteButton ctrlShow false;
        _joinLeaveButton ctrlShow false;

    };



}, 0, [_teamFlag, _teamName, _squadList, _squadName, _squadMemberList, _joinLeaveButton, _kickButton, _promoteButton]] call CFUNC(addPerFrameHandler);;
