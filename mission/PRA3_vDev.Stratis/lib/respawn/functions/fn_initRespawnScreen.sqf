#include "script_macros.hpp"

params ["_dialog"];

disableSerialization;
private _squadList = _dialog displayCtrl 206;
private _squadName = _dialog displayCtrl 208;
private _squadMemberList = _dialog displayCtrl 209;
private _joinLeaveButton = _dialog displayCtrl 210;
private _kickButton = _dialog displayCtrl 211;
private _promoteButton = _dialog displayCtrl 212;


GVAR(respawnScreenPFH) = [{
    disableSerialization;
    (_this select 0) params["_squadList","_squadName","_squadMemberList", "_joinLeaveButton", "_kickButton", "_promoteButton"];

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
            private _groupId = _x getVariable ["BG_GroupId",""];
            if (_groupId != "") then {
                private _rowNumber = _squadList lnbAddRow [_groupId select [0,1], _x getVariable ["BG_description",""], format["Ch. %1", _x getVariable ["BG_RadioChannel",""]], format ["%1 / 9",_x getVariable ["BG_Size",0]]];
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
        _squadName ctrlSetText (_selectedGroup getVariable ["BG_GroupId",groupId _selectedGroup]);

        {

            private _rowNumber = _squadMemberList lnbAddRow [name _x];
            nil;
        } count units _selectedGroup;
        private _isLeader = (player == leader _selectedGroup);

        _kickButton ctrlShow _isLeader;
        _promoteButton ctrlShow _isLeader;


        _joinLeaveButton ctrlSetText (["JOIN","LEAVE"] select (_selectedGroup == group player));
        _joinLeaveButton ctrlShow true;
    } else {
        _squadName ctrlSetText "SELECT A SQUAD";

        _kickButton ctrlShow false;
        _promoteButton ctrlShow false;
        _joinLeaveButton ctrlShow false;

    };



}, 0, [_squadList, _squadName, _squadMemberList, _joinLeaveButton, _kickButton, _promoteButton]] call CBA_fnc_addPerFrameHandler;
