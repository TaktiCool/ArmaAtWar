#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Handles the Register Healer Event on PRA3_Player

    Parameter(s):
    0: [_healer] (ARRAY)
    1: -

    Returns:
    -
*/
(_this select 0) params ["_healer"];
GVAR(currentHealers) pushBackUnique _healer;

call FUNC(updateHealingStatus);

if (GVAR(healingPFH) < 0) then {
    GVAR(healingPFH) = [{

        if (objNull in GVAR(currentHealers)) then {
            GVAR(currentHealers) = GVAR(currentHealers) select {!isNull _x};
        };

        private _damageSelection = PRA3_Player getVariable QGVAR(DamageSelection);
        private _lastTimestamp = PRA3_Player getVariable [QGVAR(healingTimestamp),-1];

        if (_lastTimestamp < 0) exitWith {};

        private _healingRate = PRA3_Player getVariable [QGVAR(healingRate),-1];
        private _maxDamage = 0;
        {
            if (_x > _maxDamage) then {
                _maxDamage = _x;
            };
            nil;
        } count _damageSelection;

        if ((serverTime - _lastTimestamp) <= 0) exitWith {};

        _maxDamage = _maxDamage - (serverTime - _lastTimestamp) * _healingRate * GVAR(maxDamage);

        _maxDamage = _maxDamage max 0;

        _damageSelection = _damageSelection apply {
            [_x, _maxDamage] select (_x > _maxDamage);
        };

        [PRA3_Player, QGVAR(DamageSelection), _damageSelection] call CFUNC(setVariablePublic);

        if (_maxDamage < 0.7) then {
            PRA3_Player forceWalk false;
        };

        if (count GVAR(currentHealers) == 0 || _maxDamage == 0) exitWith {
            GVAR(healingPFH) = -1;
            PRA3_Player setVariable [QGVAR(healingProgress), 1 - _maxDamage / GVAR(maxDamage), true];
            PRA3_Player setVariable [QGVAR(healingRate), 0, true];
            PRA3_Player setVariable [QGVAR(healingTimestamp), serverTime, true];
            [_this select 1] call CFUNC(removePerFrameHandler);
        };
        PRA3_Player setVariable [QGVAR(healingProgress), 1 - _maxDamage / GVAR(maxDamage)];
        PRA3_Player setVariable [QGVAR(healingTimestamp), serverTime];



    }, 0.1, []] call CFUNC(addPerFrameHandler);
};
