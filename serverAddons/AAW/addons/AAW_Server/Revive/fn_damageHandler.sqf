#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy

    Description:
    Event handler for the HandleDamage event

    Parameter(s):
    0: Unit <Object> (Default: objNull)
    1: SelectionName <String> (Default: "")
    2: Damage <Number> (Default: 0)
    3: Source <Object> (Default: objNull)
    4: Projectile <String> (Default: "")
    5: HitPartIndex <Number> (Default: 0)

    Returns:
    0: resulting damage <Number>
*/

params [
    ["_unit", objNull, [objNull]],
    ["_selectionName", "", [""]],
    ["_damage", 0, [0]],
    ["_source", objNull, [objNull]],
    ["_projectile", "", [""]],
    ["_hitPartIndex", 0, [0]]
];

if !(local _unit && alive _unit && _unit == CLib_Player) exitWith {};
//DUMP(_this);
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
        if (CLib_Player getVariable [QGVAR(isUnconscious), false] && GVAR(UnconsciousFrame) != diag_frameNo) then {
            CLib_Player setVariable [QGVAR(bleedingRate), (CLib_Player getVariable [QGVAR(bleedingRate), 0]) + (_damageReceived max 0.7)];
        } else {
            GVAR(UnconsciousFrame) = diag_frameNo;
            [true] call FUNC(setUnconscious);
            CLib_Player setVariable [QGVAR(bleedingRate), (CLib_Player getVariable [QGVAR(bleedingRate), 0]) + (_damageReceived min 0.3)];
        };
    };
};

_returnedDamage min 0.95;
