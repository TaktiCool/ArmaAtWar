#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas & LAxemann

    Description:
    Fired Event for Unit/Vehicles

    Parameter(s):
    FiredEH Return

    Returns:
    None
*/
params [
    "_unit",
    "_weapon",
    "",
    "",
    "_ammo",
    "",
    "_projectile"
];
if (toLower(_weapon) isEqualTo "put") exitWith {};
if (isNull _projectile) then { // Fixes a locality issue with slow projectiles. Thanks to killzone kid!
     _projectile = nearestObject [_unit, _ammo];
};
if ((player distance _unit) >= 2500) exitWith {};
if ((side effectiveCommander (vehicle _unit)) != (side player)) then {
    if ((_weapon in ["throw","put"])) exitWith {};

    private _hit = [(configFile >> "CfgAmmo" >> _ammo >> "hit"), format [QGVAR(cached_hit_%1), _ammo]] call FUNC(readCacheValues);
    if (_hit == 0) exitWith {};

    private _dDist = (7 + (_hit / 2)) min 28;                // Calculate the detectionDistance (dDist)

    GVAR(bulletArray) pushBack [_projectile, _dDist, _hit];
};
