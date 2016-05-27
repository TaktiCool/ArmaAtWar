#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas, NetFusion

    Description:
    Initializes UI for treatments

    Parameter(s):
    None

    Returns:
    None
*/
/*
 * WEAPON SWITCHING
 */
[QGVAR(SwitchWeapon), {
    params ["_item"];

    [{
        params ["_params", "_id"];

         disableSerialization;

        private _fakeWeaponName = PRA3_Player getVariable [QGVAR(fakeWeaponName), ""];

        if (_fakeWeaponName == "") exitWith {
            ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutFadeOut 0;
            _id call CFUNC(removePerFrameHandler);
        };

        _display = uiNamespace getVariable [UIVAR(MedicalProgress), displayNull];
        if (isNull _display) then {
            ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutRsc [UIVAR(MedicalProgress), "PLAIN", 0.2];
            _display = uiNamespace getVariable [UIVAR(MedicalProgress), displayNull];

            {
                (_display displayCtrl _x) ctrlSetFade 1;
                (_display displayCtrl _x) ctrlCommit 0;
                nil
            } count [3001, 3002, 3003];

            (_display displayCtrl 3004) ctrlSetFade 0;
            (_display displayCtrl 3004) ctrlCommit 0;
        };

        private _actionName = switch (_fakeWeaponName) do {
            case "FirstAidKit": {"bandage"};
            case "Medikit": {"heal"};
            default {"Dafug?"};
        };

        _text = "";
        {
            _x params ["_weaponName", "_condition"];

            if (_fakeWeaponName == _weaponName) exitWith {
                {
                    _x params ["_unit", "_additionalText"];

                    if (PRA3_Player distance _unit < 3 && _unit call _condition) then {
                        _text = _text + _additionalText;
                    };
                    nil
                } count [
                    [cursorTarget, "<img size='1.5' image='\a3\3DEN\Data\Displays\Display3DEN\Hint\lmb_ca.paa'/> to %1 a comrade<br />"],
                    [PRA3_Player, "<img size='1.5' image='\a3\3DEN\Data\Displays\Display3DEN\Hint\rmb_ca.paa'/> to %1 yourself"]
                ];
            };
            nil
        } count [
            ["FirstAidKit", {_this getVariable [QGVAR(bloodLoss), 0] != 0}],
            ["Medikit", {_this getVariable [QGVAR(bloodLoss), 0] == 0 && !(_this getVariable [QGVAR(selectionDamage), GVAR(selections) apply {0}] isEqualTo (GVAR(selections) apply {0}))}]
        ];

        (_display displayCtrl 3004) ctrlSetStructuredText parseText (format [_text, _actionName]);
        (_display displayCtrl 3004) ctrlCommit 0;
    }, 0] call CFUNC(addPerFrameHandler);
}] call CFUNC(addEventHandler);

[QGVAR(RestoreWeapon), {
    PRA3_Player setVariable [QGVAR(fakeWeaponName), ""];
}] call CFUNC(addEventHandler);


/*
 * TREATMENTS
 */
[QGVAR(StartMedicalAction), {
    (_this select 0) params ["_action", "_target", "_displayText"];

    disableSerialization;

    private _display = uiNamespace getVariable [UIVAR(MedicalProgress), displayNull];
    if (isNull _display) then {
        ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutRsc [UIVAR(MedicalProgress), "PLAIN", 0.2];
        _display = uiNamespace getVariable [UIVAR(MedicalProgress), displayNull];
    };

    (_display displayCtrl 3003) ctrlSetStructuredText parseText format [_displayText, _target call CFUNC(name)];
    (_display displayCtrl 3002) progressSetPosition 0;

    {
        (_display displayCtrl _x) ctrlSetFade 0;
        (_display displayCtrl _x) ctrlCommit 0;
        nil
    } count [3001, 3002, 3003];

    // Track the progress
    [{
        params ["_params", "_id"];
        _params params ["_display", "_target"];

        disableSerialization;

        if (!(_target in [PRA3_Player, cursorTarget]) || PRA3_Player distance _target > 3 || !alive _target) then {
            [QGVAR(StopMedicalAction), false] call CFUNC(localEvent);
        };

        if (GVAR(medicalActionRunning) == "") exitWith {
            {
                (_display displayCtrl _x) ctrlSetFade 1;
                (_display displayCtrl _x) ctrlCommit 0.5;
                nil
            } count [3001, 3002, 3003];
            _id call CFUNC(removePerFrameHandler);
        };

        private _treatmentAmount = _target getVariable [QGVAR(treatmentAmount), 0];
        private _treatmentProgress = _target getVariable [QGVAR(treatmentProgress), 0];
        private _treatmentStartTime = _target getVariable [QGVAR(treatmentStartTime), serverTime];
        _treatmentProgress = _treatmentProgress + (serverTime - _treatmentStartTime) * _treatmentAmount;

        if (_treatmentProgress >= 1) then {
            [QGVAR(StopMedicalAction), true] call CFUNC(localEvent);
        };

        (_display displayCtrl 3002) progressSetPosition _treatmentProgress;
    }, 0, [_display, _target]] call CFUNC(addPerFrameHandler);
}] call CFUNC(addEventHandler);

[QGVAR(StopMedicalAction), {
    if (PRA3_Player getVariable [QGVAR(fakeWeaponName), ""] == "") then {
        ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutFadeOut 0;
    };
}] call CFUNC(addEventHandler);

[{
    private _action = PRA3_Player getVariable [QGVAR(medicalActionRunning), ""];

    if (_action == "") exitWith {
        if (!isNull (uiNamespace getVariable [UIVAR(MedicalInfo), displayNull])) then {
            ([UIVAR(MedicalInfo)] call bis_fnc_rscLayer) cutFadeOut 0.1;
        };
    };

    private _display = uiNamespace getVariable [UIVAR(MedicalInfo), displayNull];
    if (isNull _display) then {
        ([UIVAR(MedicalInfo)] call bis_fnc_rscLayer) cutRsc [UIVAR(MedicalInfo), "PLAIN", 0];
        _display = uiNamespace getVariable [UIVAR(MedicalInfo), displayNull];
    };

    private _actionName = switch (_action) do {
        case "BANDAGE": {"bandaged"};
        case "HEAL": {"healed"};
        case "REVIVE": {"revived"};
        default {"Dafug?"};
    };

    private _text = format ["<img size='1' color='#ffffff' image='\A3\UI_f\data\IGUI\Cfg\Actions\heal_ca.paa'/><br />You are being %1!", _actionName];

    (_display displayCtrl 5000) ctrlSetStructuredText parseText _text;
    (_display displayCtrl 5000) ctrlSetFade 0;
    (_display displayCtrl 5000) ctrlCommit 0;
}, 0.2] call CFUNC(addPerFrameHandler);
