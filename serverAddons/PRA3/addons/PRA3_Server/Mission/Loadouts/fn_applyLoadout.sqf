#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Apply Loadout to Unit

    Parameter(s):
    0: Loadout Name <String>
    1: Loadout Side <String>
    2: Unit <Object>

    Returns:
    None
*/
params ["_name", "_side", "_unit"];

private _loadoutVar = format ["%1_%2", _sideName, _name];
private _var = GVAR(LoadoutCache) getVariable _loadoutVar;

_var params ["", "_realLoadout", "_attributes"];
_realLoadout params [
    "_primaryWeapon", "_primaryAttachments", "_primaryMagazine", "_primaryMagazineTracer",
    "_primaryMagazineCount", "_primaryMagazineTracerCount","_secondaryWeapon",
    "_secondaryMagazine", "_secondaryMagazineCount", "_handgunWeapon","_handgunMagazine",
    "_handgunMagazineCount", "_uniform", "_vest", "_backpack", "_headGear","_assignedItems", "_items"
];
private _names = ["isMedic", "isEngineer", "isPilot", "isVehicleCrew", "isLeader"];
{
    _unit setVariable [format ["PRA3_Loadout_class_%1", _names select _forEachIndex], _x, true];
} forEach _attributes;

// add Uniform
[_unit, _uniform] call FUNC(addContainer);
[_unit, _vest] call FUNC(addContainer);
[_unit, _backpack] call FUNC(addContainer);
_unit addHeadgear _headGear;

// Primary Weapon
[_unit, _primaryWeapon, _primaryMagazine, _primaryMagazineCount] call FUNC(addWeapon);
[_unit, _primaryMagazineTracer, _primaryMagazineTracerCount] call FUNC(addMagazine);
{
    [_unit, _x] call FUNC(addPrimaryAttachment);
    nil
} count _primaryAttachments;

// Secondary Weapon
[_unit, _secondaryWeapon, _secondaryMagazine, _secondaryMagazineCount] call FUNC(addWeapon);

// Handgun Weapon
[_unit, _handgunWeapon, _handgunMagazine, _handgunMagazineCount] call FUNC(addWeapon);
{
    _unit linkItem _x;
    nil
} count _assignedItems;

{
    if (_x isEqualType "") then {
        [_unit, _x] call FUNC(addItem);
    } else {
        _x params ["_className", "_count"];
        [_unit, _className, _count] call FUNC(addItem);
    };
    nil
} count _items;
