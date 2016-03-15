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
    ["primaryWeapon", ""], ["primaryAttachments", []], ["primaryMagazine", ""], ["primaryMagazineCount", 0], ["primaryMagazineTracer", ""], ["primaryMagazineCount", 0],
    ["secondaryWeapon", ""], ["secondaryMagazine", ""], ["secondaryMagazineCount", 0],
    ["handgunWeapon", ""], ["handgunMagazine", ""], ["handgunMagazineCount", 0],
    ["assignedItems", []],
    ["items", []]
]] call FUNC(getKitDetails);
_kitDetails params [
    "_uniform", "_vest", "_backpack", "_headGear",
    "_primaryWeapon", "_primaryAttachments", "_primaryMagazine", "_primaryMagazineCount", "_primaryMagazineTracer", "_primaryMagazineTracerCount",
    "_secondaryWeapon", "_secondaryMagazine", "_secondaryMagazineCount",
    "_handgunWeapon", "_handgunMagazine", "_handgunMagazineCount",
    "_assignedItems",
    "_items"
];

// remove all Items
removeAllAssignedItems PRA3_Player;
removeAllWeapons PRA3_Player;
removeHeadgear PRA3_Player;
removeGoggles PRA3_Player;

// add container
[PRA3_Player, _uniform] call FUNC(addContainer);
[PRA3_Player, _vest] call FUNC(addContainer);
[PRA3_Player, _backpack] call FUNC(addContainer);
PRA3_Player addHeadgear _headGear;

// Helper functions
private _addMagazineFnc = {
    params ["_className", "_count"];
    if (_className != "" && _count > 0) then {
        for "_i" from 1 to _count do {
            PRA3_Player addMagazine _className;
        };
    };
};

private _addWeaponFnc = {
    params ["_className", "_magazine", "_count"];
    if (_className != "") then {
        PRA3_Player addWeapon _className;
        [_magazine, _count] call _addMagazineFnc;
    };
};

private _addItemFnc = {
    params ["_className", ["_count", 1]];
    if (_className != "" && _count > 0) then {
        for "_i" from 1 to _count do {
            if (PRA3_Player canAdd _className) then {
                PRA3_Player addItem _className;
            } else {
                hint format ["Item %1 can't added because Gear is Full", _className];
            };
        };
    };
};

// Primary Weapon
[_primaryWeapon, _primaryMagazine, _primaryMagazineCount] call _addWeaponFnc;
[_primaryMagazineTracer, _primaryMagazineTracerCount] call _addMagazineFnc;
{
    PRA3_Player addPrimaryWeaponItem _x;
    nil
} count (_primaryAttachments select {_x != ""});

// Secondary Weapon
[_secondaryWeapon, _secondaryMagazine, _secondaryMagazineCount] call _addWeaponFnc;

// Handgun Weapon
[_handgunWeapon, _handgunMagazine, _handgunMagazineCount] call _addWeaponFnc;

// Assigned items
{
    PRA3_Player linkItem _x;
    nil
} count _assignedItems;

// Items
{
    _x call _addItemFnc;
    nil
} count _items;

// reload Weapon
reload PRA3_Player;
