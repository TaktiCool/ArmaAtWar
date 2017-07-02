#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Client Init for RadioSounds

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(CurrentVONChannel) = "";

GVAR(VONChannel_Global) = localize "str_channel_global";
GVAR(VONChannel_Side) = localize "str_channel_Side";
GVAR(VONChannel_Command) = localize "str_channel_command";
GVAR(VONChannel_Group) = localize "str_channel_group";
GVAR(VONChannel_Vehicle) = localize "str_channel_vehicle";
GVAR(VONChannel_Direct) = localize "str_channel_direct";

GVAR(RadioActiveForChannel) = [GVAR(VONChannel_Command), GVAR(VONChannel_Group)];

GVAR(ChannelTarget) = false call CFUNC(createNamespace);

GVAR(ChannelTarget) setVariable [localize "str_channel_side", {side group CLib_player}];
GVAR(ChannelTarget) setVariable [localize "str_channel_command", {side group CLib_player}];
GVAR(ChannelTarget) setVariable [localize "str_channel_group", {units group CLib_player}];
GVAR(ChannelTarget) setVariable [localize "str_channel_vehicle", {crew CLib_player}];

DFUNC(RadioEvent) = {
    params ["_event", "_unit", "_channel"];

    if (_channel in GVAR(RadioActiveForChannel)) then {
        hint "CHANNEL";
        private _target = (GVAR(ChannelTarget) getVariable [_channel, nil]);
        if (_target isEqualType {}) then {
            [_event, call _target, [_unit, _channel]] call CFUNC(targetEvent);
        };

        //[_event, _target, [_unit, QGVAR(CurrentVONChannel)]] call CFUNC(globalEvent);
    };
};

["startRadioSpeaking", {
    (_this select 0) params ["_unit", "_channel"];

    playSound "AAW_RadioClickIn";
    if (_unit != CLib_player) then {
        private _source = objNull;
        private _nbrSoundSources = {
            private _value = _x getVariable [QGVAR(NoiseSoundSource), 0];
            if (_value > 0) exitWith {
                _source = _x;
                _value;
            };
            false;
        } count attachedObjects CLib_player;

        if (isNull _source) then {
            _source = "#particlesource" createVehicleLocal getPos CLib_player;
            _source attachTo [CLib_player, [0, 0, 0], "neck"];
        };

        _source setVariable [QGVAR(NoiseSoundSource), _nbrSoundSources + 1];

        [{
            (_this select 0) params ["_source"];
            if (!isNull _source) exitWith {
                (_this select 1) call CFUNC(removePerFrameHandler);
            };
            _source say2D "AAW_RadioNoise";
        }, 5, _source] call CFUNC(addPerFrameHandler);

    };
}] call CFUNC(addEventhandler);

["stopRadioSpeaking", {

    playSound "AAW_RadioClickOut";
    if (_unit != CLib_player) then {
        private _source = objNull;
        private _nbrSoundSources = {
            private _value = _x getVariable [QGVAR(NoiseSoundSource), 0];
            if (_value > 0) exitWith {
                _source = _x;
                _value;
            };
            false;
        } count attachedObjects CLib_player;

        if (_nbrSoundSources > 0) then {
            _nbrSoundSources = _nbrSoundSources - 1;
            _source setVariable [QGVAR(NoiseSoundSource), _nbrSoundSources];
            if (_nbrSoundSources == 0) then {
                deleteVehicle _source;
            };
        };
    };

}] call CFUNC(addEventhandler);

["missionStarted", {
    hint "MISSION STARTED";
    private _fncKeyDown = {
        [{
            if (GVAR(CurrentVONChannel) == "" && { !isNull findDisplay 55 && !isNull findDisplay 63 }) then {
                GVAR(CurrentVONChannel) = ctrlText (findDisplay 63 displayCtrl 101);

                ["startRadioSpeaking", CLib_player, GVAR(CurrentVONChannel)] call FUNC(RadioEvent);

                findDisplay 55 displayAddEventHandler ["Unload", {
                    ["stopRadioSpeaking", CLib_player, GVAR(CurrentVONChannel)] call FUNC(RadioEvent);
                    GVAR(CurrentVONChannel) = "";
                }];
            };
        }] call CFUNC(execNextFrame);

        false;
    };

    private _fncKeyUp = {
        //hint "KEY UP";
        [{
            if (GVAR(CurrentVONChannel) != "" && { GVAR(CurrentVONChannel) != ctrlText (findDisplay 63 displayCtrl 101) }) then {
                ["stopRadioSpeaking", CLib_player, GVAR(CurrentVONChannel)] call DFUNC(RadioEvent);
                GVAR(CurrentVONChannel) = "";
            };
        }] call CFUNC(execNextFrame);
        false;
    };

    findDisplay 46 displayAddEventHandler ["KeyDown", _fncKeyDown];
    findDisplay 46 displayAddEventHandler ["KeyUp", _fncKeyUp];
    findDisplay 46 displayAddEventHandler ["MouseButtonDown", _fncKeyDown];
    findDisplay 46 displayAddEventHandler ["MouseButtonUp", _fncKeyUp];
    findDisplay 46 displayAddEventHandler ["JoystickButton", _fncKeyDown];
}] call CFUNC(addEventhandler);
