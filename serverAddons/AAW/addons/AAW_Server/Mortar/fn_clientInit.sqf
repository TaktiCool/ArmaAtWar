#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Init for Mortars

    Parameter(s):
    None

    Returns:
    None
*/


GVAR(CalculatorInputBuffer) = "R00000 E+0000" splitString "";

GVAR(BufferPosition) = 1;
/*
// Old reloading approach. Need more ideas
private _iconIdle = "\A3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa";
private _iconProgress = "\A3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa";
private _condition = {
    vehicle CLib_player == CLib_player;
};

private _onStart = {
};

private _onProgress = {
    (diag_tickTime - CGVAR(Interaction_HoldActionStartTime)) / 2;
};

private _onComplete = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(charge), 1, true];
};

private _onInterruption = {};

["Mortar_01_base_F", "Load 1 Charge", _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress, _onComplete, _onInterruption] call CFUNC(addHoldAction);
private _onComplete = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(charge), 2, true];
};
["Mortar_01_base_F", "Load 2 Charges", _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress, _onComplete, _onInterruption] call CFUNC(addHoldAction);
private _onComplete = {
    params ["_target", "_caller"];

    _target setVariable [QGVAR(charge), 3, true];
};
["Mortar_01_base_F", "Load 3 Charges", _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress, _onComplete, _onInterruption] call CFUNC(addHoldAction);

// script based fire
["", CLib_player, 0, {vehicle CLib_player isKindOf "Mortar_01_base_F"}, {
    //CLib_player forceWeaponFire [muzzle, firemode]
    params ["_target", "_caller"];
    private _charge = (vehicle CLib_player) getVariable [QGVAR(charge),-1];
    if (_charge == -1) exitWith {};

    (vehicle CLib_player) setVariable [QGVAR(charge), -1, true];

    CLib_player forceWeaponFire [currentMuzzle CLib_player, "Single"+str _charge];
    vehicle CLib_player fire [currentMuzzle CLib_player, "Single"+str _charge];

}, [ "priority", 0, "showWindow", false, "hideOnUse", true, "shortcut", "DefaultAction", "ignoredCanInteractConditions", ["isNotInVehicle"]]] call CFUNC(addAction);
//
["", CLib_player, 0, {vehicle CLib_player isKindOf "Mortar_01_base_F"}, {
}, [ "priority", 0, "showWindow", false, "hideOnUse", true, "shortcut", "NextWeapon", "ignoredCanInteractConditions", ["isNotInVehicle"]]] call CFUNC(addAction);

*/

DFUNC(updateBuffer) = {
    private _spaces = "";
    for "_i" from 1 to GVAR(BufferPosition) do {
        _spaces = _spaces + " ";
    };
    GVAR(InputFieldBG) ctrlSetText (_spaces+"_");
    GVAR(InputField) ctrlSetText (GVAR(CalculatorInputBuffer) joinString "");
};

DFUNC(calcSolution) = {
    private _v = [70, 140, 200];
    private _g = 9.81;
    private _inStr = GVAR(CalculatorInputBuffer) joinString "";
    private _r = parseNumber (_inStr select [1, 5]);
    private _h = parseNumber (_inStr select [8, 5]);

    hint format ["r: %1<br>h: %2", _r,_h];
    private _aoe = [[0,0],[0,0],[0,0]];
    if (_r > 0) then {
        _aoe = _v apply {
             private _temp = atan ((_x^2 + sqrt (_x^4 - _g * (_g * _r^2 + 2 * _h * _x^2)))/(_g * _r));
             [_temp,  _r / (_x * cos _temp)]
        };
    };



    {
        (_aoe select _forEachIndex) params ["_angle", "_time"];
        if (_angle >= 45 && _angle <= 88) then {
            _x ctrlSetText format [" C%1 %2.%3%4/%5", _forEachIndex+1, floor _angle, floor ((_angle - floor _angle)*10), floor ((_angle*10 - floor (_angle*10))*10), round _time];
        } else {
            _x ctrlSetText format [" C%1 --/--", _forEachIndex+1];
        };

    } forEach [GVAR(AOESolutionField1), GVAR(AOESolutionField2), GVAR(AOESolutionField3)];
};

["vehicleChanged", {
    (_this select 0) params ["_newVehicle", "_oldVehicle"];


    if (_oldVehicle isKindOf "Mortar_01_base_F") exitWith {
        (findDisplay 46) displayRemoveEventHandler ["KeyDown", GVAR(KeyEventHandler)];
        nil;
    };

    if (!(_newVehicle isKindOf "Mortar_01_base_F")) exitWith {nil};

    if (isNil QGVAR(WeaponSightDisplay)) then {
        {
            if (ctrlIDD _x == 300) exitWith {
                GVAR(WeaponSightDisplay) = _x;
                0
            }
        } count (uiNamespace getVariable "IGUI_displays");
    };
    /*
    _ctrlDistance = GVAR(WeaponSightDisplay) displayCtrl 173;
    _ctrlDistanceText = GVAR(WeaponSightDisplay) displayCtrl 1010;

    _ctrlElevation = GVAR(WeaponSightDisplay) displayCtrl 175;
    _ctrlElevationSol = GVAR(WeaponSightDisplay) displayCtrl 176;
    _ctrlElevationText = GVAR(WeaponSightDisplay) displayCtrl 1013;
    _ctrlElevationSolText = GVAR(WeaponSightDisplay) displayCtrl 1014;

    _ctrlHeading = GVAR(WeaponSightDisplay) displayCtrl 156;
    _ctrlOpticsPitch = GVAR(WeaponSightDisplay) displayCtrl 182;
    _ctrlOpticsZoom = GVAR(WeaponSightDisplay) displayCtrl 180;
    _ctrlSolutionText = GVAR(WeaponSightDisplay) displayCtrl 1011;
    _ctrlTime = GVAR(WeaponSightDisplay) displayCtrl 174;
    _ctrlTimeText = GVAR(WeaponSightDisplay) displayCtrl 1012;
    _ctrlVisionMode = GVAR(WeaponSightDisplay) displayCtrl 179;

    _ctrlGroupRange = GVAR(WeaponSightDisplay) displayCtrl 177;
    */
    [{
        {
            (GVAR(WeaponSightDisplay) displayCtrl _x) ctrlSetFade 1;
            (GVAR(WeaponSightDisplay) displayCtrl _x) ctrlCommit 0;
            nil
        } count [173, 174, 176, 177, 1010, 1011, 1012, 1013, 1014, 1015];
        {
            (GVAR(WeaponSightDisplay) displayCtrl _x) ctrlSetTextColor [1,0.3,0.4,1];
            (GVAR(WeaponSightDisplay) displayCtrl _x) ctrlCommit 0;
            nil
        } count [156, 182, 180, 179, 175, 1013];
        private _ctrlGroup = GVAR(WeaponSightDisplay) displayCtrl 170;
        GVAR(InputField) = GVAR(WeaponSightDisplay) ctrlCreate ["RscTitle", -1, _ctrlGroup];
        GVAR(InputField) ctrlSetFont "EtelkaMonospacePro";
        GVAR(InputField) ctrlSetTextColor [1,0.3,0.4,1];
        GVAR(InputField) ctrlSetText (GVAR(CalculatorInputBuffer) joinString "");
        GVAR(InputField) ctrlSetPosition [11*(0.01875 * safeZoneH), 28*(0.025*safeZoneH), 8*(0.01875 * safeZoneH), (0.025 * safeZoneH)];
        GVAR(InputField) ctrlSetFontHeight (0.028*safeZoneH);

        GVAR(InputFieldBG) = GVAR(WeaponSightDisplay) ctrlCreate ["RscTitle", -1, _ctrlGroup];
        GVAR(InputFieldBG) ctrlSetFont "EtelkaMonospacePro";
        GVAR(InputFieldBG) ctrlSetTextColor [1,0.3,0.4,1];
        GVAR(InputFieldBG) ctrlSetText " _    ";
        GVAR(InputFieldBG) ctrlSetPosition [11*(0.01875 * safeZoneH), 28*(0.025*safeZoneH), 8*(0.01875 * safeZoneH), (0.025 * safeZoneH)];
        GVAR(InputFieldBG) ctrlSetFontHeight (0.028*safeZoneH);

        GVAR(AOESolutionField1) = GVAR(WeaponSightDisplay) ctrlCreate ["RscTitle", -1, _ctrlGroup];
        GVAR(AOESolutionField1) ctrlSetFont "EtelkaMonospacePro";
        GVAR(AOESolutionField1) ctrlSetTextColor [1,0.3,0.4,1];
        GVAR(AOESolutionField1) ctrlSetText " C1 --/--";
        GVAR(AOESolutionField1) ctrlSetPosition [11*(0.01875 * safeZoneH), 29*(0.025*safeZoneH), 7.5*(0.01875 * safeZoneH), (0.025 * safeZoneH)];
        GVAR(AOESolutionField1) ctrlSetFontHeight (0.028*safeZoneH);

        GVAR(AOESolutionField2) = GVAR(WeaponSightDisplay) ctrlCreate ["RscTitle", -1, _ctrlGroup];
        GVAR(AOESolutionField2) ctrlSetFont "EtelkaMonospacePro";
        GVAR(AOESolutionField2) ctrlSetTextColor [1,0.3,0.4,1];
        GVAR(AOESolutionField2) ctrlSetText " C2 --/--";
        GVAR(AOESolutionField2) ctrlSetPosition [11*(0.01875 * safeZoneH), 30*(0.025*safeZoneH), 7.5*(0.01875 * safeZoneH), (0.025 * safeZoneH)];
        GVAR(AOESolutionField2) ctrlSetFontHeight (0.028*safeZoneH);

        GVAR(AOESolutionField3) = GVAR(WeaponSightDisplay) ctrlCreate ["RscTitle", -1, _ctrlGroup];
        GVAR(AOESolutionField3) ctrlSetFont "EtelkaMonospacePro";
        GVAR(AOESolutionField3) ctrlSetTextColor [1,0.3,0.4,1];
        GVAR(AOESolutionField3) ctrlSetText " C3 --/--";
        GVAR(AOESolutionField3) ctrlSetPosition [11*(0.01875 * safeZoneH), 31*(0.025*safeZoneH), 7.5*(0.01875 * safeZoneH), (0.025 * safeZoneH)];
        GVAR(AOESolutionField3) ctrlSetFontHeight (0.028*safeZoneH);

        GVAR(ChargeInfo) = GVAR(WeaponSightDisplay) ctrlCreate ["RscTitle", -1, _ctrlGroup];
        GVAR(ChargeInfo) ctrlSetFont "EtelkaMonospacePro";
        GVAR(ChargeInfo) ctrlSetTextColor [1,0.3,0.4,1];
        GVAR(ChargeInfo) ctrlSetText " C1";
        GVAR(ChargeInfo) ctrlSetPosition [33.8*(0.01875 * safeZoneH), 29.3*(0.025*safeZoneH), 7.5*(0.01875 * safeZoneH), 1.2*(0.025 * safeZoneH)];
        GVAR(ChargeInfo) ctrlSetFontHeight (0.038*safeZoneH);

        GVAR(Range) = GVAR(WeaponSightDisplay) ctrlCreate ["RscTitle", -1, _ctrlGroup];
        GVAR(Range) ctrlSetFont "EtelkaMonospacePro";
        GVAR(Range) ctrlSetTextColor [1,0.3,0.4,1];
        GVAR(Range) ctrlSetText "00000";
        GVAR(Range) ctrlSetPosition [25.3*(0.01875 * safeZoneH), 32.6*(0.025*safeZoneH), 5.2*(0.01875 * safeZoneH), (0.025 * safeZoneH)];
        GVAR(Range) ctrlSetFontHeight (0.028*safeZoneH);
        GVAR(BIRange) = GVAR(WeaponSightDisplay) displayCtrl 173;

        [{
                if (!(vehicle player isKindOf "Mortar_01_base_F")) then {
                    [_this select 1] call CFUNC(removePerFrameHandler);
                };
                private _weaponMode = currentWeaponMode CLib_player;
                if (_weaponMode == "Single1") then {
                    GVAR(ChargeInfo) ctrlSetText "C1";
                };
                if (_weaponMode == "Single2") then {
                    GVAR(ChargeInfo) ctrlSetText "C2";
                };
                if (_weaponMode == "Single3") then {
                    GVAR(ChargeInfo) ctrlSetText "C3";
                };

        }, 0] call CFUNC(addPerFrameHandler);

        GVAR(InputField) ctrlCommit 0;
        GVAR(InputFieldBG) ctrlCommit 0;
        GVAR(AOESolutionField1) ctrlCommit 0;
        GVAR(AOESolutionField2) ctrlCommit 0;
        GVAR(AOESolutionField3) ctrlCommit 0;
        GVAR(ChargeInfo) ctrlCommit 0;
        GVAR(Range) ctrlCommit 0;
        GVAR(KeyEventHandler) = (findDisplay 46) displayAddEventHandler ["KeyDown",{
            params ["_display", "_dikCode", "_shift", "_ctrl", "_alt"];

            if (_shift || _ctrl || _alt) exitWith {};
            hint format ["%1",_this];
            private _char = "";
            switch (_dikCode) do {
                case (0x0b);
                case (0x52): {
                    _char = "0";
                };
                case (0x02);
                case (0x4f): {
                    _char = "1";
                };
                case (0x03);
                case (0x50): {
                    _char = "2";
                };
                case (0x04);
                case (0x51): {
                    _char = "3";
                };
                case (0x05);
                case (0x4b): {
                    _char = "4";
                };
                case (0x06);
                case (0x4c): {
                    _char = "5";
                };
                case (0x07);
                case (0x4d): {
                    _char = "6";
                };
                case (0x08);
                case (0x47): {
                    _char = "7";
                };
                case (0x09);
                case (0x48): {
                    _char = "8";
                };
                case (0x0A);
                case (0x49): {
                    _char = "9";
                };
                case (0x1b);
                case (0x4e): {
                    _char = "+";
                };
                case (0x35);
                case (0x0c);
                case (0x4a): {
                    _char = "-";
                };
                case (0x1c);
                case (0x9c): {
                    _char = "ENTER";
                };
            };



            if (_char == "") exitWith {
                if (_dikCode in actionKeys "lockTarget") then {
                    GVAR(Range) ctrlSetText ctrlText GVAR(BIRange);
                };

                if (_dikCode == 0xCB) then {
                    GVAR(BufferPosition) = GVAR(BufferPosition) - 1;
                };

                if (_dikCode == 0xCD) then {
                    GVAR(BufferPosition) = GVAR(BufferPosition) + 1;
                };

                if (GVAR(BufferPosition) == -1) then {
                    GVAR(BufferPosition) = 12;
                };

                if (GVAR(BufferPosition) == 8) then {
                    GVAR(BufferPosition) = 5;
                };

                if (GVAR(BufferPosition) == 6) then {
                    GVAR(BufferPosition) = 9;
                };

                if (GVAR(BufferPosition) == 13) then {
                    GVAR(BufferPosition) = 1;
                };

                call FUNC(updateBuffer);
            };

            if (_char == "+" || _char == "-") exitWith {
                if (GVAR(BufferPosition)>6) then {
                    GVAR(CalculatorInputBuffer) set [8, _char];
                    call DFUNC(updateBuffer);
                    true;
                };

            };

            if (_char == "ENTER") exitWith {
                if (GVAR(BufferPosition)>6) then {
                    GVAR(BufferPosition) = 1;
                    call FUNC(updateBuffer);
                } else {
                    GVAR(BufferPosition) = 9;
                    call FUNC(updateBuffer);
                };
                call FUNC(calcSolution);
                true;
            };


            GVAR(CalculatorInputBuffer) set [GVAR(BufferPosition), _char];
            GVAR(BufferPosition) = GVAR(BufferPosition) + 1;

            if (GVAR(BufferPosition) == 6) then {
                GVAR(BufferPosition) = 9;
                call FUNC(calcSolution);
            };

            if (GVAR(BufferPosition) == 13) then {
                GVAR(BufferPosition) = 1;
                call FUNC(calcSolution);
            };

            call FUNC(updateBuffer);
            true;

        }];

    }, {
        !isNull (GVAR(WeaponSightDisplay) displayCtrl 170);
    }] call CFUNC(waitUntil);
    nil;


}] call CFUNC(addEventHandler);
