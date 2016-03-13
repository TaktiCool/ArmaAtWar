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

    if (!isNull (uiNamespace getVariable [QGVAR(mission,dlgDisableMouse), displayNull])) exitWith {};
    if (!isNil QGVAR(disableInputPFH)) exitWith {};

    // end TFAR and ACRE2 radio transmissions
    // call FUNC(endRadioTransmission);

    // Close map
    if (visibleMap && {!(player getVariable ["ACE_canSwitchUnits", false])}) then {
        openMap false;
    };

    closeDialog 0;
    createDialog QEGVAR(mission,DisableMouse_Dialog);

    private _dlg = uiNamespace getVariable QEGVAR(mission,dlgDisableMouse);

    _dlg displayAddEventHandler ["KeyDown", {
        params ["", "_key"];

        if (_key == 1 && {PRA3_call FUNC(isAlive)}) then {
            createDialog (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);

            disableSerialization;

            private _dlg = findDisplay 49;

            for "_index" from 100 to 2000 do {
                (_dlg displayCtrl _index) ctrlEnable false;
            };
            private _code = {
                while {!isNull (uiNamespace getVariable [QGVAR(mission,dlgDisableMouse),displayNull])} do {
                    closeDialog 0
                };
                failMission 'LOSER';
                [false] call FUNC(disableUserInput);
            };

            _code = _code call FUNC(codeToString);

            private _ctrl = _dlg displayctrl 103;
            _ctrl ctrlSetEventHandler ["buttonClick", _code];
            _ctrl ctrlEnable true;
            _ctrl ctrlSetText "ABORT";
            _ctrl ctrlSetTooltip "Abort.";

            _ctrl = _dlg displayctrl ([104, 1010] select isMultiplayer);
            _ctrl ctrlSetEventHandler ["buttonClick", QUOTE(closeDialog 0; player setDamage 1; [false] call FUNC(disableUserInput);)];
            _ctrl ctrlEnable (call {private _config = missionConfigFile >> "respawnButton"; !isNumber _config || {getNumber _config == 1}});
            _ctrl ctrlSetText "RESPAWN";
            _ctrl ctrlSetTooltip "Respawn.";
        };

        if (_key in actionKeys "TeamSwitch" && {teamSwitchEnabled}) then {
            (uiNamespace getVariable [QGVAR(mission,dlgDisableMouse), displayNull]) closeDisplay 0;

            private _acc = accTime;
            teamSwitch;
            setAccTime _acc;
        };

        if (_key in actionKeys "CuratorInterface" && {getAssignedCuratorLogic player in allCurators}) then {
            (uiNamespace getVariable [QGVAR(mission,dlgDisableMouse), displayNull]) closeDisplay 0;
            openCuratorInterface;
        };

        if (_key in actionKeys "ShowMap") then {
            (uiNamespace getVariable [QGVAR(mission,dlgDisableMouse), displayNull]) closeDisplay 0;
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
        if (isNull (uiNamespace getVariable [QGVAR(mission,dlgDisableMouse), displayNull]) && {!visibleMap && isNull findDisplay 49 && isNull findDisplay 312 && isNull findDisplay 632}) then {
            [GVAR(disableInputPFH)] call FUNC(removePerFrameHandler);
            GVAR(disableInputPFH) = nil;
            [true] call FUNC(disableUserInput);
        };
    }, 0, []] call CBA_fnc_addPerFrameHandler;
} else {
    if (!isNil QGVAR(disableInputPFH)) then {
        [GVAR(disableInputPFH)] call FUNC(removePerFrameHandler);
        GVAR(disableInputPFH) = nil;
    };

    (uiNamespace getVariable [QGVAR(mission,dlgDisableMouse), displayNull]) closeDisplay 0;
};
