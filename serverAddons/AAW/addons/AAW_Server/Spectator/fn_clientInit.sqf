#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Client Init for Spectator

    Parameter(s):
    None

    Returns:
    None
*/


if !(side CLib_player == sideLogic && {player isKindOf "VirtualSpectator_F"}) exitWith {};

GVAR(camera) = objNull;
GVAR(cameraPos) = [0,0,0];
GVAR(cameraDir) = getDirVisual CLib_player;
GVAR(cameraDirOffset) = 0;
GVAR(cameraPitch) = -45;
GVAR(cameraPitchOffset) = 0;
GVAR(cameraHeight) = 100;
GVAR(CameraSmoothingMode) = false;
GVAR(CameraSpeedMode) = false;
GVAR(CameraOffsetMode) = false;
GVAR(CameraSpeed) = 5;
GVAR(CameraMode) = 1; // 1: FREE | 2: FOLLOW
GVAR(CameraRelPos) = [0, 0, 0];
GVAR(CameraFollowTarget) = objNull;
GVAR(CursorTarget) = objNull;
GVAR(CameraStateHistory) = [];
GVAR(CameraSmoothingTime) = 0.2;
GVAR(MapState) = [];

GVAR(OverlayUnitMarker) = true;
GVAR(OverlayGroupMarker) = true;
GVAR(OverlaySectorMarker) = true;

GVAR(InputMode) = 0;
GVAR(InputScratchpad) = "";
GVAR(InputGuess) = [];
GVAR(InputGuessIndex) = 0;

// small helper functions
DFUNC(angle2Vec) = {
    params ["_dir", "_pitch"];

    [
        [(sin _dir) * cos _pitch, (cos _dir) * cos _pitch, sin _pitch],
        [0, 0, cos _pitch]
    ];
};

DFUNC(dik2Char) = {
    params ["_dik", "_shift"];
    private _char = switch (_dik) do {
        case (0x1E): {"a"};
        case (0x30): {"b"};
        case (0x2E): {"c"};
        case (0x20): {"d"};
        case (0x12): {"e"};
        case (0x21): {"f"};
        case (0x22): {"g"};
        case (0x23): {"h"};
        case (0x17): {"i"};
        case (0x24): {"j"};
        case (0x25): {"k"};
        case (0x26): {"l"};
        case (0x32): {"m"};
        case (0x31): {"n"};
        case (0x18): {"o"};
        case (0x19): {"p"};
        case (0x10): {"q"};
        case (0x13): {"r"};
        case (0x1F): {"s"};
        case (0x14): {"t"};
        case (0x16): {"u"};
        case (0x2F): {"v"};
        case (0x11): {"w"};
        case (0x2D): {"x"};
        case (0x15): {"y"};
        case (0x2C): {"z"};
        case (0x39): {" "};
        case (0x0B): {"0"};
        case (0x02): {"1"};
        case (0x03): {"2"};
        case (0x04): {"3"};
        case (0x05): {"4"};
        case (0x06): {"5"};
        case (0x07): {"6"};
        case (0x08): {"7"};
        case (0x09): {"8"};
        case (0x0A): {"9"};
        default {""};
    };
    if (_shift) then {
        toUpper _char;
    } else {
        _char;
    };
};

[QGVAR(InputModeChanged), {
    GVAR(InputScratchpad) = "";
    [QGVAR(updateInput)] call CFUNC(localEvent);
}] call CFUNC(addEventhandler);


[{
    // Disable BI
    ["Terminate"] call BIS_fnc_EGSpectator;

    // Create Camera
    CLib_player enableSimulation false;
    GVAR(camera) = "Camera" camCreate eyePos CLib_player;
    GVAR(camera) cameraEffect ["internal", "back"];
    //GVAR(camera) = CLib_player;
    CLib_player attachTo [GVAR(camera), [0,0,0]];
    GVAR(cameraPos) = (eyePos CLib_player) vectorAdd [0, 0, GVAR(CameraHeight)];
    showCinemaBorder false;
    cameraEffectEnableHUD true;

    // Create On Screen Display
    UIVAR(SpectatorScreen) cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
    private _display = uiNamespace getVariable ["RscTitleDisplayEmpty", displayNull];
    if (isNull _display) exitWith {};

    uiNamespace setVariable [QGVAR(SpectatorControlDisplay), _display];

    (_display displayCtrl 1202) ctrlSetFade 1;
    (_display displayCtrl 1202) ctrlShow false;
    (_display displayCtrl 1202) ctrlCommit 0;

    // Create Black Border
    {
        private _tempCtrl = _display ctrlCreate ["RscPicture", -1];
        _tempCtrl ctrlSetPosition _x;
        _tempCtrl ctrlSetText "#(argb,8,8,3)color(0,0,0,1)";
        _tempCtrl ctrlCommit 0;
    } count [
        [safeZoneX, safeZoneY + pixelH*BORDERWIDTH, pixelW*BORDERWIDTH, safeZoneH-pixelH*2*BORDERWIDTH],
        [safeZoneX + safeZoneW - pixelW*BORDERWIDTH, safeZoneY + pixelH*BORDERWIDTH, pixelW*BORDERWIDTH, safeZoneH-pixelH*2*BORDERWIDTH],
        [safeZoneX, safeZoneY, safeZoneW, pixelH*BORDERWIDTH],
        [safeZoneX, safeZoneY + safeZoneH - pixelH*BORDERWIDTH, safeZoneW, pixelH*BORDERWIDTH]
    ];

    // Create Mode
    private _ctrlInfo = _display ctrlCreate ["RscStructuredText", -1];
    _ctrlInfo ctrlSetPosition [safeZoneX + pixelW*(3 + BORDERWIDTH), safeZoneY + pixelH*3, safeZoneW - 2*pixelW*(3 + BORDERWIDTH), pixelH*18];
    _ctrlInfo ctrlSetFontHeight pixelH*15;
    _ctrlInfo ctrlSetFont "RobotoCondensed";
    _ctrlInfo ctrlSetText "[F] Follow Target    [CTRL + F] Follow Unit/Squad/Objective    [M] Map";
    _ctrlInfo ctrlCommit 0;

    private _ctrlCameraMode = _display ctrlCreate ["RscStructuredText", -1];
    _ctrlCameraMode ctrlSetPosition [safeZoneX + safeZoneW - pixelW*220, safeZoneY + pixelH*3, pixelW*200, pixelH*18];
    _ctrlCameraMode ctrlSetFontHeight pixelH*15;
    _ctrlTargetInfo ctrlSetFont "RobotoCondensedBold";
    _ctrlCameraMode ctrlSetStructuredText parseText "<t align='right'>FREE</t>";
    _ctrlCameraMode ctrlCommit 0;

    private _ctrlTargetInfo = _display ctrlCreate ["RscTextNoShadow", -1];
    _ctrlTargetInfo ctrlSetPosition [safeZoneX, safeZoneY + safeZoneH + pixelH*(3 - BORDERWIDTH), safeZoneW, pixelH*18];
    _ctrlTargetInfo ctrlSetFontHeight pixelH*15;
    _ctrlTargetInfo ctrlSetFont "RobotoCondensedBold";
    _ctrlTargetInfo ctrlSetText "Target Info";
    _ctrlTargetInfo ctrlCommit 0;

    private _ctrlMouseSpeedBarBg = _display ctrlCreate ["RscPicture", -1];
    _ctrlMouseSpeedBarBg ctrlSetPosition [safeZoneX + safeZoneW - pixelW*(BORDERWIDTH*3/4), safeZoneY + pixelH*2*BORDERWIDTH, pixelW*BORDERWIDTH/2, pixelH*BORDERWIDTH*4];
    _ctrlMouseSpeedBarBg ctrlSetText "#(argb,8,8,3)color(0.3,0.3,0.3,1)";
    _ctrlMouseSpeedBarBg ctrlCommit 0;

    private _relLength = sqrt(GVAR(CameraSpeed))/sqrt(CAMERAMAXSPEED);
    private _ctrlMouseSpeedBar = _display ctrlCreate ["RscPicture", -1];
    _ctrlMouseSpeedBar ctrlSetPosition [safeZoneX + safeZoneW - pixelW*(BORDERWIDTH*3/4), safeZoneY + pixelH*2*BORDERWIDTH+pixelH*4*BORDERWIDTH*(1-_relLength), pixelW*BORDERWIDTH/2, _relLength*pixelH*BORDERWIDTH*4];
    _ctrlMouseSpeedBar ctrlSetText "#(argb,8,8,3)color(1,1,1,1)";
    _ctrlMouseSpeedBar ctrlCommit 0;

    private _ctrlMouseSpeedLabel = _display ctrlCreate ["RscTextNoShadow", -1];
    _ctrlMouseSpeedLabel ctrlSetPosition [safeZoneX + safeZoneW - pixelW*(BORDERWIDTH), safeZoneY +pixelH*6*BORDERWIDTH, pixelW*BORDERWIDTH, pixelH*BORDERWIDTH];
    _ctrlMouseSpeedLabel ctrlSetFontHeight pixelH*15;
    _ctrlMouseSpeedLabel ctrlSetFont "RobotoCondensedBold";
    _ctrlMouseSpeedLabel ctrlSetText "SPD";
    _ctrlMouseSpeedLabel ctrlCommit 0;

    private _ctrlMouseSmoothingBarBg = _display ctrlCreate ["RscPicture", -1];
    _ctrlMouseSmoothingBarBg ctrlSetPosition [safeZoneX + safeZoneW - pixelW*(BORDERWIDTH*3/4), safeZoneY + pixelH*8*BORDERWIDTH, pixelW*BORDERWIDTH/2, pixelH*BORDERWIDTH*4];
    _ctrlMouseSmoothingBarBg ctrlSetText "#(argb,8,8,3)color(0.3,0.3,0.3,1)";
    _ctrlMouseSmoothingBarBg ctrlCommit 0;

    private _relLength = sqrt(GVAR(CameraSmoothingTime))/sqrt(1.6);
    private _ctrlMouseSmoothingBar = _display ctrlCreate ["RscPicture", -1];
    _ctrlMouseSmoothingBar ctrlSetPosition [safeZoneX + safeZoneW - pixelW*(BORDERWIDTH*3/4), safeZoneY + pixelH*8*BORDERWIDTH+pixelH*4*BORDERWIDTH*(1-_relLength), pixelW*BORDERWIDTH/2, _relLength*pixelH*BORDERWIDTH*4];
    _ctrlMouseSmoothingBar ctrlSetText "#(argb,8,8,3)color(1,1,1,1)";
    _ctrlMouseSmoothingBar ctrlCommit 0;

    private _ctrlMouseSmoothingLabel = _display ctrlCreate ["RscTextNoShadow", -1];
    _ctrlMouseSmoothingLabel ctrlSetPosition [safeZoneX + safeZoneW - pixelW*(BORDERWIDTH), safeZoneY + pixelH*6*BORDERWIDTH+pixelH*6*BORDERWIDTH, pixelW*BORDERWIDTH, pixelH*BORDERWIDTH];
    _ctrlMouseSmoothingLabel ctrlSetFontHeight pixelH*12;
    _ctrlMouseSmoothingLabel ctrlSetFont "RobotoCondensedBold";
    _ctrlMouseSmoothingLabel ctrlSetText "SMTH";
    _ctrlMouseSmoothingLabel ctrlCommit 0;

    [QGVAR(CameraSpeedChanged), {
        (_this select 1) params ["_ctrl"];
        private _relLength = sqrt(GVAR(CameraSpeed))/sqrt(CAMERAMAXSPEED);
        _ctrl ctrlSetPosition [safeZoneX + safeZoneW - pixelW*(BORDERWIDTH*3/4), safeZoneY + pixelH*2*BORDERWIDTH+pixelH*4*BORDERWIDTH*(1-_relLength), pixelW*BORDERWIDTH/2, _relLength*pixelH*BORDERWIDTH*4];
        _ctrl ctrlCommit 0;
    }, _ctrlMouseSpeedBar] call CFUNC(addEventhandler);


    [QGVAR(CameraSmoothingChanged), {
        (_this select 1) params ["_ctrl"];
        private _relLength = sqrt(GVAR(CameraSmoothingTime))/sqrt(1.6);
        _ctrl ctrlSetPosition [safeZoneX + safeZoneW - pixelW*(BORDERWIDTH*3/4), safeZoneY + pixelH*8*BORDERWIDTH+pixelH*4*BORDERWIDTH*(1-_relLength), pixelW*BORDERWIDTH/2, _relLength*pixelH*BORDERWIDTH*4];
        _ctrl ctrlCommit 0;
    }, _ctrlMouseSmoothingBar] call CFUNC(addEventhandler);

    [QGVAR(CursorTargetChanged), {
        (_this select 0) params ["_target"];
        (_this select 1) params ["_ctrl"];

        _ctrl ctrlSetText format ["%1 [%2]", str _target, _target call CFUNC(name)];
        _ctrl ctrlCommit 0;
    }, _ctrlTargetInfo] call CFUNC(addEventhandler);

    [QGVAR(CameraModeChanged), {
        (_this select 0) params ["_mode"];
        (_this select 1) params ["_ctrl"];

        private _textMode = (["FREE", "FOLLOW"] select (_mode - 1));

        if (_mode == 2) then {
            _textMode = format ["%1 [%2]", _textMode, GVAR(CameraFollowTarget) call CFUNC(name)];
        };

        _ctrl ctrlSetStructuredText parseText format ["<t align='right'>%1</t>", _textMode];
        _ctrl ctrlCommit 0;
    }, _ctrlCameraMode] call CFUNC(addEventhandler);

    [QGVAR(updateGuess), {
        (_this select 1) params ["_ctrl"];

        private _str = switch (GVAR(InputMode)) do {
            case (1): { // Search FOLLOW Target
                private _searchStr = GVAR(InputScratchpad);
                GVAR(InputGuessIndex) = 0;
                if (_searchStr != "") then {
                    _searchStr = toLower _searchStr;
                    private _guess = [];
                    {
                        private _name = (_x call CFUNC(name));
                        private _index = toLower _name find _searchStr;
                        if (_index >= 0) then {
                            _guess pushBack [_index, _x, _name];
                        };
                        if (leader group _x == _x) then {
                            private _name = groupId group _x;
                            private _index = toLower _name find _searchStr;
                            if (_index >= 0) then {
                                _guess pushBack [_index, _x, _name];
                            };
                        };
                        false;
                    } count allUnits;

                    if !(_guess isEqualTo []) then {
                        _guess sort true;
                    };

                    GVAR(InputGuess) = _guess;
                } else {
                     _temp = _temp + _searchStr +"| ";
                };

                _temp
            };
            default {
            };

        };

        _ctrl ctrlSetStructuredText parseText _str;
        _ctrl ctrlCommit 0;
    }] call CFUNC(addEventhandler);

    [QGVAR(updateInput), {
        (_this select 1) params ["_ctrl"];

        private _str = switch (GVAR(InputMode)) do {
            case (1): { // Search FOLLOW Target
                private _searchStr = GVAR(InputScratchpad);
                private _temp = "<t color='#cccccc'>Search for Target: </t>";
                systemChat GVAR(InputScratchpad);
                if (_searchStr != "") then {
                    private _guess = +GVAR(InputGuess);
                    if !(_guess isEqualTo []) then {
                        if (GVAR(InputGuessIndex) >= count _guess) then {
                            GVAR(InputGuessIndex) = 0;
                        };
                        private _friendlySide = EGVAR(Common,competingSides) select 0;

                        _guess = _guess select [GVAR(InputGuessIndex), count _guess];
                        private _bestGuess = _guess select 0;
                        private _guessStr = _guess apply {
                            format ["<t color='%1'>%2</t>",
                            ["#CC3333", "#0099EE"] select ((side group (_x select 1)) isEqualTo _friendlySide),
                            (_x select 2)]};
                        _guessStr deleteAt 0;



                        if (GVAR(InputGuessIndex) > 0) then {
                            _temp = _temp + "<img size='0.5' image='\A3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa'/>";
                        };
                        private _color =["#CC3333", "#0099EE"] select ((side group (_bestGuess select 1)) isEqualTo _friendlySide);

                        _temp = _temp + format ["<t color='%1'>%2</t>", _color, ((_bestGuess select 2) select [0, _bestGuess select 0])];
                        _temp = _temp + format ["<t color='#ffffff' shadowColor='%1' shadow='1'>%2</t>", _color,  ((_bestGuess select 2) select [_bestGuess select 0, count _searchStr])];
                        _temp = _temp + format ["<t color='%1'>%2</t>", _color, ((_bestGuess select 2) select [(_bestGuess select 0) + count _searchStr])];
                        if (!(_guessStr isEqualTo [])) then {
                            _temp = _temp + "<t color='#cccccc'> | " + (_guessStr joinString " | ") + "</t>";
                        };

                    } else {
                        _temp = _temp + _searchStr +"| <t color='#cccccc'>NO RESULT</t>";
                    };

                } else {
                     _temp = _temp + _searchStr +"| ";
                };

                _temp
            };
            default {
                "[F] Follow Cursor Target    [CTRL + F] Follow Unit/Squad/Objective    [M] Map    [F1] Toggle Group Overlay    [F2] Toggle Unit Overlay    [F3] Toggle Sector Overlay"
            };

        };

        _ctrl ctrlSetStructuredText parseText _str;
        _ctrl ctrlCommit 0;
    }, _ctrlInfo] call CFUNC(addEventhandler);

    [QGVAR(updateInput)] call CFUNC(localEvent);




    (findDisplay 46) displayAddEventHandler ["MouseMoving", {_this call FUNC(mouseMovingEH)}];

    (findDisplay 46) displayAddEventHandler ["KeyDown", {_this call FUNC(keyDownEH)}];

    (findDisplay 46) displayAddEventHandler ["KeyUp", {_this call FUNC(keyUpEH)}];

    (findDisplay 46) displayAddEventHandler ["MouseZChanged", {_this call FUNC(mouseWheelEH)}];


}, {
    (missionNamespace getVariable ["BIS_EGSpectator_initialized", false]) && !isNull findDisplay 60492;
}] call CFUNC(waitUntil);



// Camera Update PFH
addMissionEventHandler ["Draw3D", {call DFUNC(draw3dEH)}];

[DFUNC(cameraUpdateLoop), 0] call CFUNC(addPerFrameHandler);
