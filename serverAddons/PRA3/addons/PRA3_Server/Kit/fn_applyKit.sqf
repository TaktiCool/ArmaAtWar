#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Apply Kit to player

    Parameter(s):
    0: Kit Name <String>

    Returns:
    None
*/
params ["_kitName"];

private _kitDetails = [_kitName, [
    ["uniform", ""], ["vest", ""], ["backpack", ""], ["headGear", ""],
    ["primaryWeapon", ""], ["primaryAttachments", []], ["primaryMagazine", ""], ["primaryMagazineCount", 0], ["primaryMagazineTracer", ""], ["primaryMagazineTracerCount", 0],
    ["secondaryWeapon", ""], ["secondaryMagazine", ""], ["secondaryMagazineCount", 0],
    ["handgunWeapon", ""], ["handgunMagazine", ""], ["handgunMagazineCount", 0],
    ["assignedItems", []],
    ["items", []],
    ["displayName", ""], ["icon", ""], ["mapIcon",""], ["compassIcon", ["", 1]],
    ["isLeader", 0], ["isMedic", 0], ["isEngineer", 0], ["isPilot", 0], ["isCrew", 0]
]] call FUNC(getKitDetails);
_kitDetails params [
    "_uniform", "_vest", "_backpack", "_headGear",
    "_primaryWeapon", "_primaryAttachments", "_primaryMagazine", "_primaryMagazineCount", "_primaryMagazineTracer", "_primaryMagazineTracerCount",
    "_secondaryWeapon", "_secondaryMagazine", "_secondaryMagazineCount",
    "_handgunWeapon", "_handgunMagazine", "_handgunMagazineCount",
    "_assignedItems",
    "_items",
    "_displayName", "_icon", "_mapIcon", "_compassIcon",
    "_isLeader", "_isMedic", "_isEngineer", "_isPilot", "_isCrew"
];

// remove all Items
removeAllAssignedItems PRA3_Player;
removeAllWeapons PRA3_Player;
removeHeadgear PRA3_Player;
removeGoggles PRA3_Player;

// add container
[PRA3_Player, _uniform] call CFUNC(addContainer);
[PRA3_Player, _vest] call CFUNC(addContainer);
[PRA3_Player, _backpack] call CFUNC(addContainer);
PRA3_Player addHeadgear _headGear;

// Primary Weapon
[_primaryMagazineTracer, _primaryMagazineTracerCount] call CFUNC(addMagazine);
[_primaryWeapon, _primaryMagazine, _primaryMagazineCount] call CFUNC(addWeapon);
{
    PRA3_Player addPrimaryWeaponItem _x;
    nil
} count (_primaryAttachments select {_x != ""});

// Secondary Weapon
[_secondaryWeapon, _secondaryMagazine, _secondaryMagazineCount] call CFUNC(addWeapon);

// Handgun Weapon
[_handgunWeapon, _handgunMagazine, _handgunMagazineCount] call CFUNC(addWeapon);

// Assigned items
{
    PRA3_Player linkItem _x;
    nil
} count _assignedItems;

// Items
{
    _x call CFUNC(addItem);
    nil
} count _items;
if (_icon == "") then {
    _icon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
};
if (_mapIcon == "") then {
    _mapIcon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
};

PRA3_Player setVariable [QGVAR(kit), _kitName, true];
PRA3_Player setVariable [QGVAR(kitDisplayName), _displayName, true];
PRA3_Player setVariable [QGVAR(kitIcon), _icon, true];
PRA3_Player setVariable [QGVAR(MapIcon), _mapIcon, true];
PRA3_Player setVariable [QGVAR(compassIcon), _compassIcon, true];

PRA3_Player setVariable [QGVAR(isLeader), _isLeader == 1, true];
PRA3_Player setVariable [QGVAR(isMedic), _isMedic == 1, true];
PRA3_Player setVariable [QGVAR(isEngineer), _isEngineer == 1, true];
PRA3_Player setVariable [QGVAR(isPilot), _isPilot == 1, true];
PRA3_Player setVariable [QGVAR(isCrew), _isCrew == 1, true];
