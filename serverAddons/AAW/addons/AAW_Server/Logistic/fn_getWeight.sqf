#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas && NetFusion

    Description:
    Returns the weight of a crate.

    Parameter(s):
    0: Crate to get weight of <Object>

    Returns:
    Weight <Number>
*/

params ["_object"];

// Initialize the total weight.
private _totalWeight = 0;

// Cycle through all item types with their assigned config paths.
{
    _x params["_items","_getConfigCode"];
    _items params ["_item", "_count"];
    // Cycle through all items and read their mass out of the config.
    {
        // Multiply mass with amount of items and add the mass to the total weight.
        _totalWeight = _totalWeight + (getNumber ((call _getConfigCode) >> "mass") * (_count select _forEachIndex));
    } forEach _item;
    nil
} count [
    [getMagazineCargo _object, {configFile >> "CfgMagazines" >> _x}],
    [getBackpackCargo _object, {configFile >> "CfgVehicles" >> _x}],
    [getItemCargo _object, {configFile >> "CfgWeapons" >> _x >> "ItemInfo"}],
    [getWeaponCargo _object, {configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo"}]
];

// add Weight of create to totalWeight
_totalWeight = _totalWeight + (getNumber (configFile >> "CfgVehicles" >> typeOf _object >> "mass"));

// Mass in Arma isn't an exact amount but rather a volume/weight value. This attempts to work around that by making it a usable value. (sort of).
_totalWeight * 0.5
