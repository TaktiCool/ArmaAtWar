#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Add Eventhandler to Display 46 for Space Revive

    Parameter(s):
    None

    Returns:
    None
*/

(findDisplay 46) displayAddEventHandler ["KeyDown", {
    params ["_ctrl","_key"];
    if (_key != 57 || GVAR(reviveKeyPressed)) exitWith {false};

    private _target = cursorTarget;

    if (!(typeOf _target isKindOf "CAManBase") || {(PRA3_Player distance _target) > 3}) exitWith {false};

    if (_target getVariable [QGVAR(bloodLoss), 0] != 0) exitWith {
        systemChat "You must First Bandage the Unit to Revive him!";
        false
    };

    if !(_target getVariable [QGVAR(isUnconscious), false]) exitWith {false};

    GVAR(reviveKeyPressed) = true;

    GVAR(beginTickTime) = diag_tickTime;

    disableSerialization;

    ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutRsc [UIVAR(MedicalProgress),"PLAIN",0.2];
    private _display = uiNamespace getVariable [UIVAR(MedicalProgress),displayNull];

    (_display displayCtrl 3003) ctrlSetStructuredText parseText format ["Reviving %1 ...", name _target];


    {
        (_display displayCtrl _x) ctrlSetFade 0;
        (_display displayCtrl _x) ctrlCommit 0;
        false;
    } count [3001, 3002, 3003];

    (_display displayCtrl 3004) ctrlSetFade 1;
    (_display displayCtrl 3004) ctrlCommit 0;



    _target setVariable [QGVAR(medicalActionInProgress), "REVIVE", true];
    [{
        (_this select 0) params ["_target"];

        if (cursorTarget != _target || !GVAR(reviveKeyPressed) || PRA3_Player getVariable [QGVAR(isUnconscious), false]) exitWith {
            ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutFadeOut 0;
            [_this select 1] call CFUNC(removePerFrameHandler);
            _target setVariable [QGVAR(medicalActionInProgress), "", true];
        };

        private _reviveSpeed = GVAR(reviveSpeed);
        if !(PRA3_Player getVariable [QGVAR(isMedic), false]) then {
            _reviveSpeed = _reviveSpeed / GVAR(reviveCoef);
        };

        GVAR(MedicItemProgress) = (diag_tickTime - GVAR(beginTickTime)) / _reviveSpeed;

        if (GVAR(MedicItemProgress) >= 1) then {
            _target setVariable [QGVAR(isUnconscious), false, true];
            ["UnconsciousnessChanged", _target, [false, _target]] call CFUNC(targetEvent);
            GVAR(reviveKeyPressed) = false;
        };
        disableSerialization;
        private _display = uiNamespace getVariable [UIVAR(MedicalProgress), displayNull];

        (_display displayCtrl 3002) progressSetPosition GVAR(MedicItemProgress);

    }, 0, [_target]] call CFUNC(addPerFrameHandler);

    true;
}];

(findDisplay 46) displayAddEventHandler ["KeyUp", {
    params ["_ctrl","_key"];

    if (_key == 57) then {
        GVAR(reviveKeyPressed) = false;
    };
    false;
}];
