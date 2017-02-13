#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas

    Description:
    Returns number of kits with a given name available

    Parameter(s):
    0: Kit name <String> (Default: "")

    Remarks:
    _kitName: Current Kit

    Returns:
    availableKits <Number>
*/

params [
    ["_kitName", "", [""]]
];

private _kitDetails = [_kitName, [["kitGroup", ""], ["availableInGroups", []], ["isLeader", 0]]] call FUNC(getKitDetails);
_kitDetails params ["_kitGroupName", "_availableInGroups", "_isLeader"];

// Check leader
if (_isLeader == 1 && CLib_Player != leader CLib_Player) exitWith {0};

// Check squad type
private _squadType = (group CLib_Player) getVariable [QEGVAR(Squad,Type), ""];
if !(_squadType in _availableInGroups) exitWith {0};

// Check group member count
private _groupMembersCount = count ([group CLib_Player] call CFUNC(groupPlayers));
private _requiredGroupMembersPerKit = [format [QGVAR(KitGroups_%1_requiredGroupMembersPerKit), _kitGroupName], 1] call CFUNC(getSetting);
private _usedKitsFromGroup = {
    private _usedKitName = _x getVariable [QGVAR(kit), ""];
    private _usedKitGroupName = ([_usedKitName, [["kitGroup", ""]]] call FUNC(getKitDetails)) select 0;
    _usedKitGroupName != "Unlimited" && _usedKitGroupName == _kitGroupName
} count (([group CLib_Player] call CFUNC(groupPlayers)) - [CLib_Player]);

private _availableKits = floor (_groupMembersCount / _requiredGroupMembersPerKit);
[_availableKits - _usedKitsFromGroup, 1] select _isLeader
