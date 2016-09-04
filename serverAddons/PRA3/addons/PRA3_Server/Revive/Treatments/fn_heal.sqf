#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas, NetFusion

    Description:
    Handles healing

    Parameter(s):
    None

    Returns:
    None
*/
["Medikit", PRA3_Player, 0, {
    PRA3_Player == vehicle PRA3_Player && "Medikit" in (items PRA3_Player) && {PRA3_Player getVariable [QGVAR(fakeWeaponName), ""] != "Medikit"}
}, {
    [QGVAR(SwitchWeapon), "Medikit"] call CFUNC(localEvent);
},["ignoredCanInteractConditions",["isNotUnconscious"]]] call CFUNC(addAction);

[QGVAR(PrepareTreatment), {
    (_this select 0) params ["_unit", "_action"];

    // Only handle healing here
    if (_action != "HEAL") exitWith {};

    // How much does the healers progress move per second
    private _maxDamage = [QGVAR(Settings_maxDamage), 3] call CFUNC(getSetting);
    private _healingActionDuration= [QGVAR(Settings_healingActionDuration), 40] call CFUNC(getSetting);
    private _healingCoefficient = [QGVAR(Settings_healingCoefficient), 2] call CFUNC(getSetting);
    private _totalHealingActionAmount = 0;
    {
        _totalHealingActionAmount = _totalHealingActionAmount + 1/(_healingActionDuration * ([_healingCoefficient, 1] select (_x getVariable [QEGVAR(Kit,isMedic), false])));
        nil
    } count GVAR(currentTreatingUnits);


    // Publish start position for progress
    private _selectionDamage = PRA3_Player getVariable [QGVAR(selectionDamage), GVAR(selections) apply {0}];

    private _selectionDamageSorted = +_selectionDamage;
    _selectionDamageSorted sort false;
    private _highestDamage = _selectionDamageSorted select 0;

    PRA3_Player setVariable [QGVAR(treatmentAmount), _totalHealingActionAmount / _maxDamage, true];
    PRA3_Player setVariable [QGVAR(treatmentProgress), 1 - (_highestDamage / _maxDamage), true];

}] call CFUNC(addEventHandler);

[QGVAR(DeregisterTreatment), {
    (_this select 0) params ["_unit", "_action", "_finished"];

    if (_action != "HEAL") exitWith {};

    if (_finished) exitWith {
        PRA3_Player setVariable [QGVAR(selectionDamage), GVAR(selections) apply {0}];
    };

}] call CFUNC(addEventHandler);

// Handle incoming heal
[{
    // Handle only healing
    if (PRA3_Player getVariable [QGVAR(medicalActionRunning), ""] != "HEAL") exitWith {};

    GVAR(currentTreatingUnits) = GVAR(currentTreatingUnits) select {!isNull _x};

    if (GVAR(currentTreatingUnits) isEqualTo []) exitWith {};

    private _selectionDamage = PRA3_Player getVariable [QGVAR(selectionDamage), GVAR(selections) apply {0}];

    private _selectionDamageSorted = +_selectionDamage;
    _selectionDamageSorted sort false;
    private _highestDamage = _selectionDamageSorted select 0;

    private _maxDamage = [QGVAR(Settings_maxDamage), 3] call CFUNC(getSetting);
    private _totalHealingActionAmount = PRA3_Player getVariable [QGVAR(treatmentAmount), 0];
    private _startTime = PRA3_Player getVariable [QGVAR(treatmentStartTime), 0];
    _highestDamage = (_highestDamage - (CGVAR(deltaTime) * _totalHealingActionAmount * _maxDamage)) max 0;

    _selectionDamage = _selectionDamage apply {
        [_x, _highestDamage] select (_x > _highestDamage)
    };

    [PRA3_Player, QGVAR(selectionDamage), _selectionDamage] call CFUNC(setVariablePublic);
}] call CFUNC(addPerFrameHandler);

["missionStarted", {
    (findDisplay 46) displayAddEventHandler ["MouseButtonDown", {
        params ["_display", "_button"];

        // Only handle left and right mouse button
        if (_button > 1) exitWith {false};

        // Check if already doing something
        if (GVAR(medicalActionRunning) != "") exitWith {false};

        // Player has to have the FAK selected
        if (PRA3_Player getVariable [QGVAR(fakeWeaponName), ""] != "Medikit") exitWith {false};

        // Check the target
        private _target = [cursorTarget, PRA3_Player] select _button;
        if (!(_target isKindOf "CAManBase") || PRA3_Player distance _target > 3 || !alive _target) exitWith {false};

        private _noDamageValue = GVAR(selections) apply {0};
        if ((_target getVariable [QGVAR(selectionDamage), _noDamageValue] isEqualTo _noDamageValue) || _target getVariable [QGVAR(bloodLoss), 0] != 0) exitWith {false};

        [QGVAR(StartMedicalAction), ["HEAL", _target, "Healing %1 ..."]] call CFUNC(localEvent);

        true
    }];
    (findDisplay 46) displayAddEventHandler ["MouseButtonUp", {
        params ["_display", "_button"];

        if (_button <= 1 && GVAR(medicalActionRunning) == "HEAL") exitWith {
            [QGVAR(StopMedicalAction), false] call CFUNC(localEvent);
            true
        };
        false
    }];
}] call CFUNC(addEventHandler);
