#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    KeyDown-EH for the Spectator

    Parameter(s):
    0: display <Display>
    1: keyCode <Number>
    2: isShiftPressed <Boolean>
    2: isCtrlPressed <Boolean>
    2: isAltPressed <Boolean>
    Returns:
    None
*/
params ["_display", "_keyCode", "_shift", "_ctrl", "_alt"];

private _ret = switch (_keyCode) do {
    case (0x32): { // M: Map
        if (GVAR(InputMode) > 0) exitWith {false};
        private _mapDisplay =  uiNamespace getVariable [QGVAR(MapDisplay), displayNull];
        if (isNull _mapDisplay) then {
            _mapDisplay = (findDisplay 46) createDisplay "RscDisplayEmpty";
            uiNamespace setVariable [QGVAR(MapDisplay), _mapDisplay];
            (_mapDisplay displayCtrl 1202) ctrlSetFade 1;
            (_mapDisplay displayCtrl 1202) ctrlCommit 0;

            private _map = _mapDisplay ctrlCreate ["RscMapControl", -1];
            _map ctrlSetPosition [safeZoneX+pixelW*BORDERWIDTH, safeZoneY+pixelH*BORDERWIDTH, safeZoneW-pixelW*2*BORDERWIDTH, safeZoneH-pixelH*2*BORDERWIDTH];
            _map ctrlCommit 0;

            GVAR(MapState) params [["_zoom", 1], ["_position", position CLib_player]];

            _map ctrlMapAnimAdd [0, _zoom, _position];
            ctrlMapAnimCommit _map;

            [_map] call CFUNC(registerMapControl);

            _mapDisplay displayAddEventHandler ["KeyDown", {
                params ["_display", "_keyCode"];
                switch (_keyCode) do {
                    case (0x32): { // M
                        _display closeDisplay 1;
                        true;
                    };
                    default {
                        false;
                    };
                };
            }];

            _map ctrlAddEventHandler ["Destroy", {
                params ["_map"];

                private _pos = _map ctrlMapScreenToWorld [0.5, 0.5];
                private _zoom = ctrlMapScale _map;
                GVAR(MapState) = [_zoom, _pos];
            }];
        } else {
            _mapDisplay closeDisplay 1;
        };

        true;
    };
    case (0x21): { // F
        if (GVAR(InputMode) > 0) exitWith {false};
        if (_ctrl) then {
            GVAR(InputMode) = 1;
            [QGVAR(InputModeChanged), GVAR(InputMode)] call CFUNC(localEvent);
        } else {
            if (!isNull GVAR(CursorTarget)) then {
                GVAR(CameraFollowTarget) = GVAR(CursorTarget);
                GVAR(CameraRelPos) = getPosASLVisual GVAR(camera) vectorDiff getPosASLVisual GVAR(CameraFollowTarget);
                GVAR(CameraMode) = 2;
                [QGVAR(CameraModeChanged), GVAR(CameraMode)] call CFUNC(localEvent);
            } else {
                GVAR(CameraMode) = 1;
                [QGVAR(CameraModeChanged), GVAR(CameraMode)] call CFUNC(localEvent);
            };
        };


    };
    case (0x2A): { // LShift
        if (GVAR(InputMode) > 0) exitWith {false};
        GVAR(CameraSpeedMode) = true;
        false;
    };
    case (0x1D): { // LCTRL
        if (GVAR(InputMode) > 0) exitWith {false};
        GVAR(CameraSmoothingMode) = true;

        false;
    };
    case (0x38): { // LAlt
        if (GVAR(InputMode) > 0) exitWith {false};
        GVAR(CameraOffsetMode) = true;

        false;
    };
    case (0x01): { // ESC
        if (GVAR(InputMode) > 0) exitWith {
            GVAR(InputMode) = 0;
            [QGVAR(InputModeChanged), GVAR(InputMode)] call CFUNC(localEvent);
            true;
        };

        false;
        //code
    };
    case (0x0F): { // TAB
        if (GVAR(InputMode) > 0) exitWith {
            GVAR(InputGuessIndex) = GVAR(InputGuessIndex) + ([1, -1] select _shift);
            GVAR(InputGuessIndex) = [GVAR(InputGuessIndex), count GVAR(InputGuess) - 2] select (GVAR(InputGuessIndex) < 0);
            GVAR(InputGuessIndex) = [GVAR(InputGuessIndex), 0] select (GVAR(InputGuessIndex) >= count GVAR(InputGuess));
            [QGVAR(updateInput)] call CFUNC(localEvent);
            true;
        };

        false;
        //code
    };
    case (0x1C): {
        if (GVAR(InputMode) == 1) exitWith {
            if !(GVAR(InputGuess) isEqualTo []) then {
                GVAR(CameraFollowTarget) = (GVAR(InputGuess) select GVAR(InputGuessIndex)) select 1;
                if (GVAR(CameraMode) != 2 || {(getPosASLVisual GVAR(camera) distance getPosASLVisual GVAR(CameraFollowTarget)) > 50}) then {
                    GVAR(CameraRelPos) = (vectorNormalized (getPosASLVisual GVAR(camera) vectorDiff getPosASLVisual GVAR(CameraFollowTarget))) vectorMultiply 10;
                };

                if (speed GVAR(CameraFollowTarget) > 20) then {
                    if (vectorMagnitude GVAR(CameraRelPos) < 30) then {
                        GVAR(CameraRelPos) = (vectorNormalized GVAR(CameraRelPos)) vectorMultiply 30;
                    };
                };

                GVAR(CameraPitch) = -(GVAR(CameraRelPos) select 2) atan2 vectorMagnitude GVAR(CameraRelPos);
                GVAR(CameraDir) = -(GVAR(CameraRelPos) select 0) atan2 -(GVAR(CameraRelPos) select 1);

                GVAR(CameraMode) = 2;
                [QGVAR(CameraModeChanged), GVAR(CameraMode)] call CFUNC(localEvent);
            };

            GVAR(InputMode) = 0;
            [QGVAR(InputModeChanged), GVAR(InputMode)] call CFUNC(localEvent);

            true;
        };
    };
    case (0x0E): { // BACKSPACE
        (GVAR(InputMode)==0);
        //code
    };
    case (0x3B): { // F1
        GVAR(OverlayGroupMarker) = !GVAR(OverlayGroupMarker);
        true;
    };
    case (0x3C): { // F2
        GVAR(OverlayUnitMarker) = !GVAR(OverlayUnitMarker);
        true;
    };
    case (0x3D): { // F3
        GVAR(OverlaySectorMarker) = !GVAR(OverlaySectorMarker);
        true;
    };
    default {
        false;
    };
};

if (!_ret && GVAR(InputMode) > 0) then {
    private _char = [_keyCode, _shift] call FUNC(dik2char);
    if (_char != "") then {
        GVAR(InputScratchpad) = GVAR(InputScratchpad) + _char;
        [QGVAR(updateGuess)] call CFUNC(localEvent);
        [QGVAR(updateInput)] call CFUNC(localEvent);
        _ret = true;
    } else {
        if (_keyCode == 0x0E) then { // BACKSPACE
            GVAR(InputScratchpad) = GVAR(InputScratchpad) select [0, (count GVAR(InputScratchpad)) - 1];
            [QGVAR(updateGuess)] call CFUNC(localEvent);
            [QGVAR(updateInput)] call CFUNC(localEvent);
            _ret = true;
        };
    };
};

_ret;
