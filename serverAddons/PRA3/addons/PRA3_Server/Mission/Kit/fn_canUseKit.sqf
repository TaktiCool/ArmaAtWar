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
    is Selectable <Bool>
*/
params ["_kitName"];

private _kitDetails = [_kitName, [["kitGroup", ""], ["availableInGroups", []], ["isLeader", 0]]] call FUNC(getKitDetails);
_kitDetails params ["_kitGroupName", "_availableInGroups", "_isLeader"];

// Check squad type
private _squadType = (group PRA3_Player) getVariable [QGVAR(Type), ""];
if (!(_squadType in _availableInGroups)) exitWith {false};

// Check group member count
private _groupMembersCount = count units group PRA3_Player;
private _requiredGroupMembersPerKit = [format [QGVAR(KitGroups_%1_requiredGroupMembersPerKit), _kitGroupName], 1] call CFUNC(getSetting);

private _availableKits = [floor (_groupMembersCount / _requiredGroupMembersPerKit), 1] select _isLeader;
private _usedKits = {(_x getVariable [QGVAR(Kit), ""]) == _kitName} count units group PRA3_Player;

_availableKits > _usedKits
