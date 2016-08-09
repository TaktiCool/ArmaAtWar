#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas, NetFusion

    Description:
    Handles bandages

    Parameter(s):
    None

    Returns:
    None
*/
// FAK as weapon
["First Aid Kit", PRA3_Player, 0, {
    PRA3_Player == vehicle PRA3_Player && "FirstAidKit" in (items PRA3_Player) && {PRA3_Player getVariable [QGVAR(fakeWeaponName), ""] != "FirstAidKit"}
}, {
    [QGVAR(SwitchWeapon), "FirstAidKit"] call CFUNC(localEvent);
},["ignoredCanInteractConditions",["isNotUnconscious"]]] call CFUNC(addAction);

[QGVAR(PrepareTreatment), {
    (_this select 0) params ["_unit", "_action"];

    // Only handle bandage here
    if (_action != "BANDAGE") exitWith {};

    // How much does the healers progress move per second
    private _bandageActionDuration = [QGVAR(Settings_bandageActionDuration)] call CFUNC(getSetting);
    if (!(_unit getVariable [QEGVAR(Kit,isMedic), false])) then {
        private _bandageCoefficient = [QGVAR(Settings_bandageCoefficient)] call CFUNC(getSetting);
        _bandageActionDuration = _bandageActionDuration * _bandageCoefficient;
    };
    PRA3_Player setVariable [QGVAR(treatmentAmount), 1 / _bandageActionDuration, true];

    // Publish start position for progress
    PRA3_Player setVariable [QGVAR(treatmentProgress), 0, true];
}] call CFUNC(addEventHandler);

[QGVAR(DeregisterTreatment), {
    (_this select 0) params ["_unit", "_action", "_finished"];

    // Only handle healing here
    if (_action != "BANDAGE") exitWith {};

    if (_finished) then {
        ["stopBleeding"] call CFUNC(localEvent);
        _unit removeItem "FirstAidKit";
    };
}] call CFUNC(addEventHandler);

// Action as mouse button
["missionStarted", {
    (findDisplay 46) displayAddEventHandler ["MouseButtonDown", {
        params ["_display", "_button"];

        // Only handle left and right mouse button
        if (_button > 1) exitWith {false};

        // Check if already doing something
        if (GVAR(medicalActionRunning) != "") exitWith {false};

        // Player has to have the FAK selected
        if (PRA3_Player getVariable [QGVAR(fakeWeaponName), ""] != "FirstAidKit") exitWith {false};

        // Check the target
        private _target = [cursorTarget, PRA3_Player] select _button;
        if (!(_target isKindOf "CAManBase") || PRA3_Player distance _target > 3 || !alive _target) exitWith {false};

        // Only one player can use an specific item on a target at a time
        if (_target getVariable [QGVAR(bloodLoss), 0] == 0 || _target getVariable [QGVAR(medicalActionRunning), ""] != "") exitWith {false};

        [QGVAR(StartMedicalAction), ["BANDAGE", _target, "Bandaging %1 ..."]] call CFUNC(localEvent);

        true
    }];
    (findDisplay 46) displayAddEventHandler ["MouseButtonUp", {
        params ["_display", "_button"];

        if (_button <= 1 && GVAR(medicalActionRunning) == "BANDAGE") exitWith {
            [QGVAR(StopMedicalAction), false] call CFUNC(localEvent);
            true
        };
        false
    }];
}] call CFUNC(addEventHandler);
