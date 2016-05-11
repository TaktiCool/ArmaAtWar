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
params ["_selectionIndex", "_newDamage", "_unit"];
if (isNull _unit) exitWith {};
DUMP("HandleDamage Cached: "+ str _this);
private _damageArray = (_unit getVariable [QGVAR(cachedDamage), GVAR(selections) apply {[0]}]);
private _handleDamageArray = _damageArray select _selectionIndex;

_handleDamageArray pushBack _newDamage;
_damageArray set [_selectionIndex, _handleDamageArray];
_unit setVariable [QGVAR(cachedDamage), _damageArray];

if !(_unit getVariable [QGVAR(damageWaitIsRunning), false]) then {
    // wait 3 Frames and execute the Damage Handling. to Get sure every external Damage Handling reach the Client
    [{
        params ["_unit"];
        if (isNull _unit) exitWith {};
        [{
            params ["_unit"];
            if (isNull _unit) exitWith {};
            [{
                params ["_unit"];
                if (isNull _unit) exitWith {};
                private _previousDamage = _unit getVariable [QGVAR(selectionDamage), GVAR(selections) apply {0}];
                private _maxDamage = [QGVAR(Settings_maxDamage), 3] call CFUNC(getSetting);
                {
                    // sort to get Highest Value
                    _x sort false;
                    _x params [["_newDamage", 0]];

                    // Add the damage to the previous
                    private _totalDamage = (_previousDamage select _forEachIndex) + _newDamage;
                    _previousDamage set [_forEachIndex, _totalDamage min _maxDamage];
                    [QGVAR(Hit), [_unit, GVAR(selections) select _forEachIndex, _newDamage, _totalDamage]] call CFUNC(localEvent);

                    // Kill the player if the Damage is Higher than the Max Damage
                    if ((GVAR(selections) select _forEachIndex) in ["", "head", "body"]) then {
                        if (_totalDamage >= _maxDamage) then {
                            _unit setVariable [QGVAR(killPlayerInNextFrame), true];
                        };
                    };
                } forEach (_unit getVariable [QGVAR(cachedDamage), GVAR(selections) apply {[0]}]);

                [_unit, QGVAR(selectionDamage), _previousDamage] call CFUNC(setVariablePublic); // Use setVariablePublic to improve performance and not publish multiple times

                // Reset Cached Damage Array
                _unit setVariable [QGVAR(cachedDamage), GVAR(selections) apply {[0]}];
                _unit setVariable [QGVAR(damageWaitIsRunning), false];
                if (_unit getVariable [QGVAR(killPlayerInNextFrame), false]) then {
                    [{
                        params ["_unit"];
                        if (_unit getVariable [QGVAR(killPlayerInNextFrame), false]) then {
                            _unit setDamage 1;
                            _unit setVariable [QGVAR(killPlayerInNextFrame), false];
                        };
                    }, _unit] call CFUNC(execNextFrame);
                };

            }, _unit] call CFUNC(execNextFrame);
        }, _unit] call CFUNC(execNextFrame);
    }, _unit] call CFUNC(execNextFrame);
    _unit setVariable [QGVAR(damageWaitIsRunning), true];
};
