#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas, NetFusion

    Description:
    Handles reviving

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(PrepareTreatment), {
    (_this select 0) params ["_unit", "_action"];

    // Only handle revive here
    if (_action != "REVIVE") exitWith {};

    // How much does the healers progress move per second
    private _reviveActionDuration = [QGVAR(Settings_reviveActionDuration), 20] call CFUNC(getSetting);
    private _reviveCoefficient = [QGVAR(Settings_reviveCoefficient), 2] call CFUNC(getSetting);
    if (!(_unit getVariable [QEGVAR(Kit,isMedic), false])) then {
        _reviveActionDuration = _reviveActionDuration * _reviveCoefficient;
    };
    PRA3_Player setVariable [QGVAR(treatmentAmount), 1 / _reviveActionDuration, true];

    // Publish start position for progress
    PRA3_Player setVariable [QGVAR(treatmentProgress), 0, true];
}] call CFUNC(addEventHandler);

[QGVAR(DeregisterTreatment), {
    (_this select 0) params ["_unit", "_action", "_finished"];

    // Only handle revive here
    if (_action != "REVIVE") exitWith {};

    if (_finished) then {
        ["UnconsciousnessChanged", false] call CFUNC(localEvent);
    };
}] call CFUNC(addEventHandler);

["missionStarted", {
    (findDisplay 46) displayAddEventHandler ["KeyDown", {
        params ["_ctrl", "_key"];

        // Only handle space bar
        if (_key != 57) exitWith {false};

        // Check if already doing something
        if (GVAR(medicalActionRunning) != "") exitWith {false};

        // Check the target
        private _target = cursorTarget;
        if (!(_target isKindOf "CAManBase") || PRA3_Player distance _target > 3 || !alive _target) exitWith {false};

        // Only one player can use revive on a target at a time
        if (!(_target getVariable [QGVAR(isUnconscious), false]) || _target getVariable [QGVAR(medicalActionRunning), ""] != "") exitWith {false};

        // Check bleeding too
        if (_target getVariable [QGVAR(bloodLoss), 0] != 0) exitWith {
            systemChat "You have to bandage the casualty before you can revive him!";
            false
        };

        [QGVAR(StartMedicalAction), ["REVIVE", _target, "Reviving %1 ..."]] call CFUNC(localEvent);

        true
    }];
    (findDisplay 46) displayAddEventHandler ["KeyUp", {
        params ["_ctrl", "_key"];

        if (GVAR(medicalActionRunning) == "REVIVE" && _key == 57) exitWith {
            [QGVAR(StopMedicalAction), false] call CFUNC(localEvent);
            true
        };
        false
    }];
}] call CFUNC(addEventHandler);