#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Handle Damage Cached

    Parameter(s):
    0: Argument Name <>
    1:

    Returns:
    None
*/
params ["_selectionIndex", "_newDamage"];

private _damageArray = GVAR(cachedDamage) select _selectionIndex;
_damageArray pushBack _newDamage;
GVAR(cachedDamage) set [_selectionIndex, _damageArray];

if !(GVAR(damageWaitIsRunning)) then {
    [{

        private _previousDamage = PRA3_Player getVariable [QGVAR(selectionDamage), GVAR(selections) apply {0}];
        private _maxDamage = [QGVAR(Settings_maxDamage), 3] call CFUNC(getSetting);
        {
            // sort to get Highest Value
            _x sort false;
            _x params [["_newDamage", 0]];

            // Add the damage to the previous
            private _totalDamage = (_previousDamage select _forEachIndex) + _newDamage;
            _previousDamage set [_forEachIndex, _totalDamage min _maxDamage];
            [QGVAR(Hit), [PRA3_Player, GVAR(selections) select _forEachIndex, _newDamage, _totalDamage]] call CFUNC(localEvent);

            // Kill the player if the Damage is Higher than the Max Damage
            if (_totalDamage >= _maxDamage) then {
                GVAR(killPlayerInNextFrame) = true;
            };
        } forEach GVAR(cachedDamage);

        [PRA3_Player, QGVAR(selectionDamage), _previousDamage] call CFUNC(setVariablePublic); // Use setVariablePublic to improve performance and not publish multiple times

        // Reset Cached Damage Array
        GVAR(cachedDamage) = GVAR(cachedDamage) apply {[0]};
        GVAR(damageWaitIsRunning) = false;

        [{
            if (GVAR(killPlayerInNextFrame)) then {
                PRA3_Player setDamage 1;
            };
        }] call CFUNC(execNextFrame);

    }] call CFUNC(execNextFrame);
    GVAR(damageWaitIsRunning) = true;
};
