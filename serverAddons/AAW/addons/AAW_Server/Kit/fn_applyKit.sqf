#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, NetFusion

    Description:
    Apply Kit to player

    Parameter(s):
    0: Kit Name <String>

    Returns:
    None
*/
params ["_unit", "_kitName"];

private _kitDetails = [_kitName, side group _unit, [
    ["uniform", ""], ["vest", ""], ["backpack", ""], ["headGear", ""],
    ["primaryWeapon", ""], ["primaryAttachments", []], ["primaryMagazine", ""], ["primaryMagazineCount", 0], ["primaryMagazineTracer", ""], ["primaryMagazineTracerCount", 0],
    ["secondaryWeapon", ""], ["secondaryMagazine", ""], ["secondaryMagazineCount", 0],
    ["handgunWeapon", ""], ["handgunMagazine", ""], ["handgunMagazineCount", 0],
    ["assignedItems", []],
    ["items", []],
    ["displayName", ""], ["icon", ""], ["mapIcon", ""], ["compassIcon", ["", 1]],
    ["isLeader", 0], ["isMedic", 0], ["isEngineer", 0], ["isPilot", 0], ["isCrew", 0], ["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]
]] call FUNC(getKitDetails);
_kitDetails params [
    "_uniform", "_vest", "_backpack", "_headGear",
    "_primaryWeapon", "_primaryAttachments", "_primaryMagazine", "_primaryMagazineCount", "_primaryMagazineTracer", "_primaryMagazineTracerCount",
    "_secondaryWeapon", "_secondaryMagazine", "_secondaryMagazineCount",
    "_handgunWeapon", "_handgunMagazine", "_handgunMagazineCount",
    "_assignedItems",
    "_items",
    "_displayName", "_icon", "_mapIcon", "_compassIcon",
    "_isLeader", "_isMedic", "_isEngineer", "_isPilot", "_isCrew", "_uiIcon"
];

// remove all Items
removeAllAssignedItems _unit;
removeAllWeapons _unit;
removeHeadgear _unit;
removeGoggles _unit;

// add container
[_unit, _uniform, 0] call CFUNC(addContainer);
[_unit, _vest, 1] call CFUNC(addContainer);
[_unit, _backpack, 2] call CFUNC(addContainer);

_unit addHeadgear _headGear;

// Primary Weapon
[_unit, [_primaryMagazineTracer, _primaryMagazineTracerCount]] call CFUNC(addMagazine);
[_unit, _primaryWeapon, [_primaryMagazine, _primaryMagazineCount]] call CFUNC(addWeapon);
{
    _unit addPrimaryWeaponItem _x;
    nil
} count (_primaryAttachments select {_x != ""});

// Secondary Weapon
[_unit, _secondaryWeapon, [_secondaryMagazine, _secondaryMagazineCount]] call CFUNC(addWeapon);

// Handgun Weapon
[_unit, _handgunWeapon, [_handgunMagazine, _handgunMagazineCount]] call CFUNC(addWeapon);

// Assigned items
{
    _unit linkItem _x;
    nil
} count _assignedItems;

// Items
{
    [_unit, _x] call CFUNC(addItem);
    nil
} count _items;
if (_icon == "") then {
    _icon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
};
if (_mapIcon == "") then {
    _mapIcon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
};
if (_uiIcon == "") then {
    _uiIcon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
};

_unit setVariable [QGVAR(kit), _kitName, true];
_unit setVariable [QGVAR(kitDisplayName), _displayName, true];
_unit setVariable [QGVAR(kitIcon), _icon, true];
_unit setVariable [QGVAR(MapIcon), _mapIcon, true];
_unit setVariable [QGVAR(UIIcon), _uiIcon, true];
_unit setVariable [QGVAR(compassIcon), _compassIcon, true];

_unit setVariable [QGVAR(isLeader), _isLeader == 1, true];
_unit setVariable [QGVAR(isMedic), _isMedic == 1, true];
_unit setVariable [QGVAR(isEngineer), _isEngineer == 1, true];
_unit setVariable [QGVAR(isPilot), _isPilot == 1, true];
_unit setVariable [QGVAR(isCrew), _isCrew == 1, true];

if (_isMedic == 1) then {
    _unit setUnitTrait ["medic", true];
} else {
    _unit setUnitTrait ["medic", false];
};
if (_isEngineer == 1) then {
    _unit setUnitTrait ["engineer", true];
} else {
    _unit setUnitTrait ["engineer", false];
};
