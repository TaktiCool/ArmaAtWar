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

    _aoe = _v apply {
         private _temp = atan ((_x^2 + sqrt (_x^4 - _g * (_g * _r^2 + 2 * _h * _x^2)))/(_g * _r));
         [_temp,  _r / (_x * cos _temp)]
    };

    {
        (_aoe select _forEachIndex) params ["_angle", "_time"];
        if (_angle >= 45 && _angle <= 88) then {
            _x ctrlSetText format [" %1 %2/%3", _forEachIndex+1, (round (_angle*100))/100, round _time];
        } else {
            _x ctrlSetText format [" %1 --/--", _forEachIndex+1];
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
        GVAR(AOESolutionField1) ctrlSetText " 1 --/--";
        GVAR(AOESolutionField1) ctrlSetPosition [11*(0.01875 * safeZoneH), 29*(0.025*safeZoneH), 7.5*(0.01875 * safeZoneH), (0.025 * safeZoneH)];
        GVAR(AOESolutionField1) ctrlSetFontHeight (0.028*safeZoneH);

        GVAR(AOESolutionField2) = GVAR(WeaponSightDisplay) ctrlCreate ["RscTitle", -1, _ctrlGroup];
        GVAR(AOESolutionField2) ctrlSetFont "EtelkaMonospacePro";
        GVAR(AOESolutionField2) ctrlSetTextColor [1,0.3,0.4,1];
        GVAR(AOESolutionField2) ctrlSetText " 2 --/--";
        GVAR(AOESolutionField2) ctrlSetPosition [11*(0.01875 * safeZoneH), 30*(0.025*safeZoneH), 7.5*(0.01875 * safeZoneH), (0.025 * safeZoneH)];
        GVAR(AOESolutionField2) ctrlSetFontHeight (0.028*safeZoneH);

        GVAR(AOESolutionField3) = GVAR(WeaponSightDisplay) ctrlCreate ["RscTitle", -1, _ctrlGroup];
        GVAR(AOESolutionField3) ctrlSetFont "EtelkaMonospacePro";
        GVAR(AOESolutionField3) ctrlSetTextColor [1,0.3,0.4,1];
        GVAR(AOESolutionField3) ctrlSetText " 3 --/--";
        GVAR(AOESolutionField3) ctrlSetPosition [11*(0.01875 * safeZoneH), 31*(0.025*safeZoneH), 7.5*(0.01875 * safeZoneH), (0.025 * safeZoneH)];
        GVAR(AOESolutionField3) ctrlSetFontHeight (0.028*safeZoneH);

        GVAR(InputField) ctrlCommit 0;
        GVAR(InputFieldBG) ctrlCommit 0;
        GVAR(AOESolutionField1) ctrlCommit 0;
        GVAR(AOESolutionField2) ctrlCommit 0;
        GVAR(AOESolutionField3) ctrlCommit 0;

        GVAR(KeyEventHandler) = (findDisplay 46) displayAddEventHandler ["KeyDown",{
            params ["_display", "_dikCode", "_shift", "_ctrl", "_alt"];
            hint format ["%1",_this];
            if (_shift || _ctrl || _alt || !(_dikCode in [0x0b, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x52, 0x4f, 0x50, 0x51, 0x4b, 0x4c, 0x4d, 0x47, 0x48, 0x49, 0x1c, 0x9c, 0x0c, 0x4a, 0x4e, 0x35,0x1b])) exitWith {};

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
