#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Apply Kit to Unit

    Parameter(s):
    0: Kit Name <String>
    1: Kit Side <String>
    2: Unit <Object>

    Returns:
    None
*/
params ["_name", "_side", "_unit"];

private _KitVar = format ["%1_%2", _side, _name];
private _var = GVAR(KitCache) getVariable _KitVar;

if (isNil "_var") exitWith {};

_var params ["_display", "_realKit", "_attributes"];
_display params ["_displayName", "_icon"];
_realKit params [
    "_primaryWeapon", "_primaryAttachments", "_primaryMagazine", "_primaryMagazineTracer",
    "_primaryMagazineCount", "_primaryMagazineTracerCount","_secondaryWeapon",
    "_secondaryMagazine", "_secondaryMagazineCount", "_handgunWeapon","_handgunMagazine",
    "_handgunMagazineCount", "_uniform", "_vest", "_backpack", "_headGear","_assignedItems", "_items"
];

// remove all Items
removeAllAssignedItems _unit;
removeallWeapons _unit;
removeHeadgear _unit;
{_unit removeMagazine _x; nil} count magazines _unit;

_unit setVariable ["PRA3_Kit_className", _displayName, true];
_unit setVariable ["PRA3_Kit_classIcon", _icon, true];
_unit setVariable ["PRA3_Kit_class", _KitVar, true];

private _names = ["isMedic", "isEngineer", "isPilot", "isVehicleCrew", "isLeader"];
{
    _unit setVariable [format ["PRA3_Kit_classInfo_%1", _names select _forEachIndex], _x, true];
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

// reload Weapon
reload _unit;
