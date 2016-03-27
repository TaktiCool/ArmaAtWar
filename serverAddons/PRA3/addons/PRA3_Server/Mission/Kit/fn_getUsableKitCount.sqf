#include "macros.hpp"
/*
    Project Reality ArmA 3

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
params ["_kitName"];

private _kitDetails = [_kitName, [["kitGroup", ""], ["availableInGroups", []], ["isLeader", 0]]] call FUNC(getKitDetails);
_kitDetails params ["_kitGroupName", "_availableInGroups", "_isLeader"];

// Check leader
if (_isLeader && PRA3_Player != leader PRA3_Player) exitWith {0};

// Check squad type
private _squadType = (group PRA3_Player) getVariable [QGVAR(Type), ""];
if (!(_squadType in _availableInGroups)) exitWith {0};

// Check group member count
private _groupMembersCount = count units group PRA3_Player;
private _requiredGroupMembersPerKit = [format [QGVAR(KitGroups_%1_requiredGroupMembersPerKit), _kitGroupName], 1] call CFUNC(getSetting);
private _usedKitsFromGroup = {
    private _usedKitName = _x getVariable [QGVAR(kit), ""];
    private _usedKitGroupName = ([_usedKitName, [["kitGroup", ""]]] call FUNC(getKitDetails)) select 0;
    _usedKitGroupName != "Unlimited" && _usedKitGroupName == _kitGroupName
} count ((units group PRA3_Player) - [PRA3_Player]);

private _availableKits = floor (_groupMembersCount / _requiredGroupMembersPerKit);
[_availableKits - _usedKitsFromGroup, 1] select _isLeader
