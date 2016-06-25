#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: commy2 ported joko // Jonas

    Description:
    Disables key input. ESC can still be pressed to open the menu.

    Parameter(s):
    0: True to disable key inputs, false to re-enable them <Bool>

    Returns:
    None
*/
params ["_state"];

if (_state) then {
    disableSerialization;

    if (!isNil QGVAR(disableUserInputKeyEventHandler)) exitWith {};

    // end TFAR and ACRE2 radio transmissions
    // call FUNC(endRadioTransmission);

    // Close map
    if (visibleMap) then {
        openMap false;
    };

    inGameUISetEventHandler ["PrevAction", "true"];
    inGameUISetEventHandler ["NextAction", "true"];
    inGameUISetEventHandler ["Action", "true"];

    GVAR(disableUserInputScrollWheelEventHandler) = (findDisplay 46) displayAddEventHandler ["MouseZChanged", {true;}];
    GVAR(disableUserInputMouseButtonEventHandler) = (findDisplay 46) displayAddEventHandler ["MouseButtonDown", {true;}];
    GVAR(disableUserInputKeyEventHandler) = (findDisplay 46) displayAddEventHandler ["KeyDown", {
        params ["", "_key"];

        if (_key == 1) then {
            createDialog (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);

            disableSerialization;

            private _dlg = findDisplay 49;

            for "_index" from 100 to 2000 do {
                (_dlg displayCtrl _index) ctrlEnable false;
            };



            private _ctrl = _dlg displayctrl 103;
            _ctrl ctrlSetEventHandler ["buttonClick", DFUNC(onButtonClickEndStr)];
            _ctrl ctrlEnable true;
            _ctrl ctrlSetText "ABORT";
            _ctrl ctrlSetTooltip "Abort.";

            _ctrl = _dlg displayctrl ([104, 1010] select isMultiplayer);
            _ctrl ctrlSetEventHandler ["buttonClick", DFUNC(onButtonClickRespawnStr)];
            _ctrl ctrlEnable (call {private _config = missionConfigFile >> "respawnButton"; !isNumber _config || {getNumber _config == 1}});
            _ctrl ctrlSetText "RESPAWN";
            _ctrl ctrlSetTooltip "Respawn.";
        };

        if (_key in actionKeys "CuratorInterface" && {getAssignedCuratorLogic player in allCurators}) exitWith {
            false;
            //openCuratorInterface;
        };

        if (_key in (actionKeys "ShowMap" + actionKeys "PushToTalk" + actionKeys "PushToTalkAll" + actionKeys "PushToTalkCommand" + actionKeys "PushToTalkDirect" + actionKeys "PushToTalkGroup" + actionKeys "PushToTalkSide" + actionKeys "PushToTalkVehicle")) exitWith {
            false;
        };

        if (isServer || {serverCommandAvailable "#kick"} || {player getVariable [QEGVAR(Revive,isUnconscious), false]}) then {
            if (!(_key in (actionKeys "DefaultAction" + actionKeys "Throw")) && {_key in (actionKeys "Chat" + actionKeys "PrevChannel" + actionKeys "NextChannel")}) exitWith {
                false;
            };
        };

        true;
    }];

} else {
    if !(isNil QGVAR(disableUserInputKeyEventHandler)) then {
        (findDisplay 46) displayRemoveEventHandler ["KeyDown",GVAR(disableUserInputKeyEventHandler)];
        (findDisplay 46) displayRemoveEventHandler ["MouseButtonDown",GVAR(disableUserInputMouseButtonEventHandler)];
        (findDisplay 46) displayRemoveEventHandler ["MouseZChanged",GVAR(disableUserInputScrollWheelEventHandler)];
    };
    GVAR(disableUserInputKeyEventHandler) = nil;
    GVAR(disableUserInputMouseButtonEventHandler) = nil;
    GVAR(disableUserInputScrollWheelEventHandler) = nil;

    inGameUISetEventHandler ["PrevAction", ""];
    inGameUISetEventHandler ["NextAction", ""];
    inGameUISetEventHandler ["Action", ""];
};

/*
params ["_state"];

if (_state) then {
    disableSerialization;

    if (!isNull (uiNamespace getVariable [UIVAR(dlgDisableMouse), displayNull])) exitWith {};
    if (!isNil QGVAR(disableInputPFH)) exitWith {};

    // end TFAR and ACRE2 radio transmissions
    // call FUNC(endRadioTransmission);

    // Close map
    if (visibleMap) then {
        openMap false;
    };

    closeDialog 0;
    createDialog UIVAR(DisableMouse_Dialog);

    private _dlg = uiNamespace getVariable UIVAR(dlgDisableMouse);

    _dlg displayAddEventHandler ["KeyDown", {
        params ["", "_key"];

        if (_key == 1) then {
            createDialog (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);

            disableSerialization;

            private _dlg = findDisplay 49;

            for "_index" from 100 to 2000 do {
                (_dlg displayCtrl _index) ctrlEnable false;
            };



            private _ctrl = _dlg displayctrl 103;
            _ctrl ctrlSetEventHandler ["buttonClick", DFUNC(onButtonClickEndStr)];
            _ctrl ctrlEnable true;
            _ctrl ctrlSetText "ABORT";
            _ctrl ctrlSetTooltip "Abort.";

            _ctrl = _dlg displayctrl ([104, 1010] select isMultiplayer);
            _ctrl ctrlSetEventHandler ["buttonClick", DFUNC(onButtonClickRespawnStr)];
            _ctrl ctrlEnable (call {private _config = missionConfigFile >> "respawnButton"; !isNumber _config || {getNumber _config == 1}});
            _ctrl ctrlSetText "RESPAWN";
            _ctrl ctrlSetTooltip "Respawn.";
        };

        if (_key in actionKeys "TeamSwitch" && {teamSwitchEnabled}) then {
            (uiNamespace getVariable [UIVAR(dlgDisableMouse), displayNull]) closeDisplay 0;

            private _acc = accTime;
            teamSwitch;
            setAccTime _acc;
        };

        if (_key in actionKeys "CuratorInterface" && {getAssignedCuratorLogic player in allCurators}) then {
            (uiNamespace getVariable [UIVAR(dlgDisableMouse), displayNull]) closeDisplay 0;
            openCuratorInterface;
        };

        if (_key in actionKeys "ShowMap") then {
            (uiNamespace getVariable [UIVAR(dlgDisableMouse), displayNull]) closeDisplay 0;
            openMap true;
        };

        if (isServer || {serverCommandAvailable "#kick"} || {player getVariable [QEGVAR(Revive,isUnconscious), false]}) then {
            if (!(_key in (actionKeys "DefaultAction" + actionKeys "Throw")) && {_key in (actionKeys "Chat" + actionKeys "PrevChannel" + actionKeys "NextChannel")}) then {
                _key = 0;
            };
        };

        _key > 0
    }];

    _dlg displayAddEventHandler ["KeyUp", {true}];

    GVAR(disableInputPFH) = [{
        if (isNull (uiNamespace getVariable [UIVAR(dlgDisableMouse), displayNull]) && {!visibleMap && isNull findDisplay 49 && isNull findDisplay 312 && isNull findDisplay 632}) then {
            [GVAR(disableInputPFH)] call FUNC(removePerFrameHandler);
            GVAR(disableInputPFH) = nil;
            [true] call FUNC(disableUserInput);
        };
        if (!alive PRA3_Player) then {
            if (!isNil QGVAR(disableInputPFH)) then {
                [GVAR(disableInputPFH)] call FUNC(removePerFrameHandler);
                GVAR(disableInputPFH) = nil;
            };
            [false] call FUNC(disableUserInput);
        };
    }, 0, []] call CBA_fnc_addPerFrameHandler;
} else {
    if (!isNil QGVAR(disableInputPFH)) then {
        [GVAR(disableInputPFH)] call FUNC(removePerFrameHandler);
        GVAR(disableInputPFH) = nil;
    };

    (uiNamespace getVariable [UIVAR(dlgDisableMouse), displayNull]) closeDisplay 0;
};
*/
