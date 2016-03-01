/*
     Name: JK_Core_fnc_GetWeight

     Author(s):
        joko // Jonas
        NetFusion
     Description:
        Returns the weight of a crate.

    Parameters:
        OBJECT - Crate to get weight of

     Returns:
        NUMBER - Weight

     Example:
        _weight = Crate1 call JK_Core_fnc_GetWeight;
*/
private "_totalWeight";

// Initialize the total weight.
_totalWeight = 0;

// Cycle through all item types with their assigned config paths.
{
    _x params["_items","_getConfigCode"];

    // Cycle through all items and read their mass out of the config.
    {
        // Multiply mass with amount of items and add the mass to the total weight.
        _totalWeight = _totalWeight + (getNumber ((call _getConfigCode) >> "mass") * (_items select 1 select _forEachIndex));
    } forEach (_items select 0);
    true
} count [
    [getMagazineCargo _this, {configFile >> "CfgMagazines" >> _x}],
    [getBackpackCargo _this, {configFile >> "CfgVehicles" >> _x}],
    [getItemCargo _this, {configFile >> "CfgWeapons" >> _x >> "ItemInfo"}],
    [getWeaponCargo _this, {configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo"}]
];

// add Weight of create to totalWeight
_totalWeight = _totalWeight + (getNumber (configFile >> "CfgVehicles" >> _this >> "mass"));

// Mass in Arma isn't an exact amount but rather a volume/weight value. This attempts to work around that by making it a usable value. (sort of).
_totalWeight * 0.5
