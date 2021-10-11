#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Event handler for the HandleDamage event

    Parameter(s):
    0: Unit <Object>
    1: selectionName <String>
    2: damage <Number>
    3: source <Object>
    4: projectile <String>
    5: hitPartIndex <Number>

    Returns:
    0: resulting damage <Number>
*/

params ["_unit", "_selectionName", "_damage", "_source", "_projectile", "_hitPartIndex", "_instigator"];
if (!(local _unit) || !(alive _unit) || (_unit != CLib_Player)) exitWith {};
DUMP(_this);
//DUMP(getAllHitPointsDamage CLib_Player select 2);
//DUMP(damage CLib_Player);
private _returnedDamage = _damage;
private _damageReceived = 0;

if (_hitPartIndex >= 0) then {
    private _lastDamage = CLib_Player getHit _selectionName;
    _damageReceived = (_damage - _lastDamage) max 0;
    [_damageReceived] call FUNC(bloodEffect);
} else {
    _damageReceived = (_damage - damage CLib_Player) max 0;
};

if (_hitPartIndex <= 7) then {
    if (_damage >= 1) then {
        if (!(CLib_Player getVariable [QGVAR(isUnconscious), false])) then {
            ["playerKilled", [_unit, _instigator]] call CFUNC(serverEvent);
            [true] call FUNC(setUnconscious);

            CLib_Player setVariable [QGVAR(bleedingRate), (CLib_Player getVariable [QGVAR(bleedingRate), 0]) + _damage];
        };
    };
};

_returnedDamage min 0.95;
