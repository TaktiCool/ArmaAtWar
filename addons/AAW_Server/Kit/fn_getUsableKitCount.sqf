#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    Check if Kit is usable or all Kits are away(in Group)

    Parameter(s):
    0: Kit name

    Remarks:
    _kitName: Current Kit

    Returns:
    availableKits <Number>
*/
params ["_unit", "_kitName"];

private _group = group _unit;
private _side = side _group;

private _kitDetails = [_kitName, _side, [["kitGroup", ""], ["availableInGroups", []], ["isLeader", 0]]] call FUNC(getKitDetails);
_kitDetails params ["_kitGroupName", "_availableInGroups", "_isLeader"];

// Check leader
if (_isLeader == 1 && _unit != leader _unit) exitWith {nil};

// Check squad type
private _squadType = _group getVariable [QEGVAR(Squad,Type), ""];
if (!(_squadType in _availableInGroups)) exitWith {nil};

// Check group member count
private _groupMembers = [_group] call CFUNC(groupPlayers);
private _groupMembersCount = count _groupMembers;
private _requiredGroupMembersPerKit = [format [QUOTE(PREFIX/CfgKitGroups/%1/requiredGroupMembersPerKit), _kitGroupName], 1] call CFUNC(getSetting);
private _usedKitsFromGroup = {
    private _usedKitName = _x getVariable [QGVAR(kit), ""];
    private _usedKitGroupName = ([_usedKitName, _side, [["kitGroup", ""]]] call FUNC(getKitDetails)) select 0;
    _usedKitGroupName != "Unlimited" && _usedKitGroupName == _kitGroupName
} count (_groupMembers - [_unit]);

private _availableKits = floor (_groupMembersCount / _requiredGroupMembersPerKit);
[_availableKits - _usedKitsFromGroup, 1] select _isLeader
