#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Add Eventhandler to Display 46 for Healing Action

    Parameter(s):
    None

    Returns:
    None
*/
(findDisplay 46) displayAddEventHandler ["MouseButtonDown", {
    if (GVAR(MedicItemSelected) == "") exitWith {false};
    params ["_display", "_button"];
    if (_button > 1) exitWith {false};
    scopeName "MAIN";
    if (GVAR(MedicItemActivated) < 0) then {
        GVAR(MedicItemActivated) = _button;

        private _target = if (_button == 0) then {
            if (!(typeOf cursorTarget isKindOf "CAManBase") || (PRA3_Player distance cursorTarget) > 3 || !alive cursorTarget) then {breakTo "MAIN"};
            cursorTarget
        } else {
            PRA3_Player
        };

        // exit Only One Player can Bandage a Bleeding Unit
        if (_target getVariable [QGVAR(medicalActionInProgress), ""] != "" && GVAR(MedicItemSelected) == "FirstAidKit") exitWith {};


        if (GVAR(MedicItemSelected) == "FirstAidKit" && {_target getVariable [QGVAR(bloodLoss), 0] == 0}) exitWith {};
        if (GVAR(MedicItemSelected) == "Medikit" && {(_target getVariable [QGVAR(DamageSelection), [0,0,0,0,0,0,0]] isEqualTo [0,0,0,0,0,0,0]) || (_target getVariable [QGVAR(bloodLoss), 0] != 0)}) exitWith {};
        GVAR(beginTickTime) = diag_tickTime;

        disableSerialization;

        private _display = uiNamespace getVariable [UIVAR(MedicalProgress),displayNull];

        private _progressText = ["Bandaging %1 ...", "Healing %1 ..."] select (GVAR(MedicItemSelected) == "Medikit");


        (_display displayCtrl 3003) ctrlSetStructuredText parseText format [_progressText, _target call CFUNC(name)];
        (_display displayCtrl 3002) progressSetPosition 0;

        {
            (_display displayCtrl _x) ctrlSetFade 0;
            (_display displayCtrl _x) ctrlCommit 0;
            false;
        } count [3001, 3002, 3003];

        if (GVAR(MedicItemSelected) == "Medikit") then {
            ["registerHealer", [_target], PRA3_Player] call CFUNC(targetEvent);
        };

        _target setVariable [QGVAR(medicalActionInProgress), ["BANDAGE", "HEAL"] select (GVAR(MedicItemSelected) == "Medikit"), true];
        [{
            (_this select 0) params ["_target"];

            private _display = uiNamespace getVariable [UIVAR(MedicalProgress),displayNull];
            if (!(_target in [cursorTarget, PRA3_Player]) || GVAR(MedicItemActivated) < 0 || GVAR(MedicItemSelected) == "" || PRA3_Player getVariable [QGVAR(isUnconscious), false]) exitWith {
                GVAR(MedicItemProgress) = 0;
                ["unregisterHealer", [_target], [PRA3_Player]] call CFUNC(targetEvent);
                {
                    (_display displayCtrl _x) ctrlSetFade 1;
                    (_display displayCtrl _x) ctrlCommit 0.5;
                    false;
                } count [3001, 3002, 3003];
                [_this select 1] call CFUNC(removePerFrameHandler);
                _target setVariable [QGVAR(medicalActionInProgress), "", true];
            };


            if (GVAR(MedicItemSelected) == "Medikit") then {

                private _healingProgress = _target getVariable [QGVAR(healingProgress),0];
                private _healingRate = _target getVariable [QGVAR(healingRate),0];
                private _timestamp = _target getVariable [QGVAR(healingTimestamp),-1];

                if (_timestamp > 0) then {
                    GVAR(MedicItemProgress) = _healingProgress + (serverTime - _timestamp) * _healingRate;
                    if (_healingProgress>=1) then {
                        GVAR(MedicItemActivated) = -1;
                    };
                };

            } else {
                private _healSpeed = GVAR(bandageSpeed);
                if !(PRA3_Player getVariable [QGVAR(isMedic), false]) then {
                    _healSpeed = _healSpeed / GVAR(bandageCoef);
                };

                GVAR(MedicItemProgress) = (diag_tickTime - GVAR(beginTickTime)) / _healSpeed;

                if (GVAR(MedicItemProgress)>= 1) then {
                    ["stopBleeding", _target] call CFUNC(targetEvent);
                    PRA3_Player removeItem GVAR(MedicItemSelected);
                    GVAR(MedicItemActivated) = -1;
                };
            };


            (_display displayCtrl 3002) progressSetPosition GVAR(MedicItemProgress);


        }, 0, [_target]] call CFUNC(addPerFrameHandler);

        true;
    };
    false;
}];

(findDisplay 46) displayAddEventHandler ["MouseButtonUp", {
    if (GVAR(MedicItemSelected) == "") exitWith {};
    params ["_display", "_button"];
    if (_button == GVAR(MedicItemActivated)) exitWith {
        GVAR(MedicItemActivated) = -1;
    };
    false;
}];
