#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas, NetFusion

    Description:
    Every bloody shit

    Parameter(s):
    None

    Returns:
    None
*/
// Generate bleeding
[QGVAR(Hit), {
    (_this select 0) params ["_unit", "_selectionName", "_newDamage", "_totalDamage"];

    if (_newDamage <= 0.2 || _selectionName == "") exitWith {};

    private _bloodLoss = _unit getVariable [QGVAR(bloodLoss), 0];
    _bloodLoss = _bloodLoss + _newDamage;

    [20 * _newDamage] call FUNC(bloodEffect);
    [_unit, QGVAR(bloodLoss), _bloodLoss] call CFUNC(setVariablePublic);
}] call CFUNC(addEventHandler);

// You have to bleed when falling unconscious
["UnconsciousnessChanged", {
    (_this select 0) params ["_state"];

    if (_state) then {
        private _bloodLoss = Clib_Player getVariable [QGVAR(bloodLoss), 0];
        if (_bloodLoss < 1) then {
            [Clib_Player, QGVAR(bloodLoss), 1] call CFUNC(setVariablePublic);
        };
    };
}] call CFUNC(addEventHandler);

// Broadcast variable again on respawn
["Respawn", {
    (_this select 0) params ["_newUnit"];

    _newUnit setVariable [QGVAR(bloodLoss), _newUnit getVariable [QGVAR(bloodLoss), 0], true];
}] call CFUNC(addEventHandler);

// Reset values on death
[QGVAR(Killed), {
    (_this select 0) params ["_unit"];

    [_unit, QGVAR(bloodLoss), 0] call CFUNC(setVariablePublic);
    [_unit, QGVAR(bloodLossAmount), 0] call CFUNC(setVariablePublic);
}] call CFUNC(addEventHandler);

// Bandage
["stopBleeding", {
    [Clib_Player, QGVAR(bloodLoss), 0] call CFUNC(setVariablePublic);
    [Clib_Player, QGVAR(bloodLossAmount), 0] call CFUNC(setVariablePublic);
}] call CFUNC(addEventHandler);

// Bleeding
[{
    if (!(alive Clib_Player)) exitWith {};

    // Stop bleeding while treated
    if (Clib_Player getVariable [QGVAR(medicalActionRunning), ""] in ["BANDAGE", "REVIVE"]) exitWith {};

    private _bleedCoefficient = [QGVAR(Settings_bleedCoefficient), 1] call CFUNC(getSetting);
    private _bloodLoss = Clib_Player getVariable [QGVAR(bloodLoss), 0];

    private _timerVariable = [QGVAR(bloodLossAmount), QGVAR(unconsciousTimer)] select (Clib_Player getVariable [QGVAR(isUnconscious), false]);
    private _maxTimerSettingsName = [QGVAR(Settings_bleedOutValue), QGVAR(Settings_unconsciousDuration)] select (Clib_Player getVariable [QGVAR(isUnconscious), false]);

    private _maxTimer = [_maxTimerSettingsName, 300] call CFUNC(getSetting);

    private _currentValue = Clib_Player getVariable [_timerVariable, 0];
    _currentValue = _currentValue + (_bloodLoss * _bleedCoefficient * CGVAR(deltaTime));
    [Clib_Player, _timerVariable, _currentValue] call CFUNC(setVariablePublic);

    if (_currentValue >= _maxTimer) then {
        Clib_Player setDamage 1;
    };
}] call CFUNC(addPerFrameHandler);

// Visual bleeding effect
[{
    private _bloodLoss = Clib_Player getVariable [QGVAR(bloodLoss), 0];

    if (_bloodLoss > 0) then {
        [600 * _bloodLoss] call FUNC(bloodEffect);
    };
}, 3.5] call CFUNC(addPerFrameHandler);
