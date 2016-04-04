#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Updates current Healing Status on PRA3_Player

    Parameter(s):
    -

    Returns:
    -
*/

private _damageSelection = PRA3_Player getVariable QGVAR(DamageSelection);
private _maxDamage = 0;
{
    if (_x > _maxDamage) then {
        _maxDamage = _x;
    };
    nil;
} count _damageSelection;

private _healingRate = 0;
{
    private _healingTime = GVAR(healingTime);
    if !(_x getVariable [QGVAR(isMedic), false]) then {
        _healingTime = _healingTime * GVAR(healCoef);
    };
    _healingRate = _healingRate + 1 / _healingTime;

    nil;
} count GVAR(currentHealers);

private _healingProgress = 1 - _maxDamage / GVAR(maxDamage);

PRA3_Player setVariable [QGVAR(healingProgress), _healingProgress, true];
PRA3_Player setVariable [QGVAR(healingRate), _healingRate, true];
PRA3_Player setVariable [QGVAR(healingTimestamp), serverTime, true];
