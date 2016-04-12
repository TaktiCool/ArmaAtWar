#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Initialize the Medical Actions

    Parameter(s):
    -

    Returns:
    -
*/

GVAR(MedicItemSelected) = "";
GVAR(MedicItemActivated) = -1;
GVAR(MedicItemHolder) = objNull;
GVAR(MedicItemProgress) = 0;
GVAR(CancelAction) = -1;
GVAR(beginTickTime) = -1;
GVAR(reviveKeyPressed) = false;

DFUNC(removeOldAction) = {
    if (GVAR(MedicItemSelected) != "" && !isNull GVAR(MedicItemHolder)) then {
        disableSerialization;

        GVAR(MedicItemSelected) = "";
        deleteVehicle GVAR(MedicItemHolder);
        PRA3_Player removeAction GVAR(CancelAction);
        GVAR(MedicItemActivated) = -1;
        GVAR(MedicItemProgress) = 0;
    };
};

private _fnc_itemAction = {

};

// @Todo write it Function based
[
    "First Aid Kit", PRA3_Player, 0, {
        "FirstAidKit" in (items PRA3_Player) && {GVAR(MedicItemSelected) != "FirstAidKit"} && !(PRA3_Player getVariable [QGVAR(isUnconscious), false]) && PRA3_Player isEqualTo vehicle PRA3_Player
    },
    FUNC(itemAction), ["FirstAidKit"]
] call CFUNC(addAction);

[
    "Medikit", PRA3_Player, 0, {
        "Medikit" in (items PRA3_Player) && {GVAR(MedicItemSelected) != "Medikit"} && !(PRA3_Player getVariable [QGVAR(isUnconscious), false]) && PRA3_Player isEqualTo vehicle PRA3_Player
    },
    FUNC(itemAction), ["Medikit"]
] call CFUNC(addAction);


// To exit the grenade mode if the weapon is changed use currentWeaponChanged EH.
["currentWeaponChanged", {
    (_this select 0) params ["_currentWeapon", "_oldWeapon"];

    if (_currentWeapon != "") then {
        ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutFadeOut 0;
        call FUNC(removeOldAction);
    };

}] call CFUNC(addEventhandler);

{
    [_x, {call FUNC(removeOldAction);}] call CFUNC(addEventhandler);
    nil
} count ["vehicleChanged", "assignedVehicleRoleChanged"];

["missionStarted", {
    // MOUSE EVENTS (FAK & Medikit)
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

    //SPACE REVIVE
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

}] call CFUNC(addEventhandler);
