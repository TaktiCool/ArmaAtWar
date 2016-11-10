#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Server Init

    Parameter(s):
    -

    Returns:
    -
*/

GVAR(namespace) = false call CFUNC(createNamespace);

[QGVAR(startDestroyTimer), {
    (_this select 0) params ["_pointId"];
    private _pfhId = [{
        (_this select 0) params ["_pointId"];
        private _data = [GVAR(namespace), _pointId, []] call CFUNC(getVariable);
        _data params ["_pfhId", ["_time", -1]];
        if (_time < 0) exitWith {
            _pfhId call CFUNC(removePerFrameHandler);
        };
        if (_time > time) exitWith {};

        private _pos = [_pointId, "position"] call EFUNC(Common,getDeploymentPointData);

        [{
            params ["_pos"];
            private _bomb = "M_Mo_82mm_AT_LG" createVehicle _pos;
            _bomb setDamage 1;
        }, _pos] call CFUNC(execNextFrame);

        [_pointId] call EFUNC(Common,removeDeploymentPoint);

    }, 0.1, [_pointId]] call CFUNC(addPerFrameHandler);
    GVAR(namespace) setVariable [_pointId, [_pfhId, time + 30]];
    [{
        params ["_pointId"];

        [_pointId, "counterActive", 1] call EFUNC(Common,setDeploymentCustomData);
    }, [_pointId], "respawn"] call CFUNC(mutex);
}] call CFUNC(addEventhandler);

[QGVAR(stopDestroyTimer), {
    (_this select 0) params ["_pointId"];
    private _data = [GVAR(namespace), _pointId, []] call CFUNC(getVariable);
    _data params ["_pfhId", ["_time", -1]];
    if (_time > time) then {
        _pfhId call CFUNC(removePerFrameHandler);
        GVAR(namespace) setVariable [_pointId, [-1, -1]];
    };

    [{
        params ["_pointId"];

        [_pointId, "counterActive", 0] call EFUNC(Common,setDeploymentCustomData);
    }, [_pointId], "respawn"] call CFUNC(mutex);
}] call CFUNC(addEventhandler);

GVAR(soundList) = [
    ["radio\ambient_radio2", 10],
    ["radio\ambient_radio3", 11],
    ["radio\ambient_radio4", 7],
    ["radio\ambient_radio5", 9],
    ["radio\ambient_radio6", 7],
    ["radio\ambient_radio7", 5],
    ["radio\ambient_radio8", 12],
    ["radio\ambient_radio9", 8],
    ["radio\ambient_radio10", 11],
    ["radio\ambient_radio11", 6],
    ["radio\ambient_radio13", 6],
    ["radio\ambient_radio14", 7],
    ["radio\ambient_radio15", 8],
    ["radio\ambient_radio16", 11],
    ["radio\ambient_radio17", 6],
    ["radio\ambient_radio18", 10],
    ["radio\ambient_radio19", 10],
    ["radio\ambient_radio20", 6],
    ["radio\ambient_radio21", 4],
    ["radio\ambient_radio22", 5],
    ["radio\ambient_radio23", 8],
    ["radio\ambient_radio24", 8],
    ["radio\ambient_radio25", 10],
    ["radio\ambient_radio26", 8],
    ["radio\ambient_radio30", 9],
    ["UI\uav\UAV_01", 04, 4.5],
    ["UI\uav\UAV_02", 11, 4.5],
    ["UI\uav\UAV_03", 05, 4.5],
    ["UI\uav\UAV_04", 08, 4.5],
    ["UI\uav\UAV_05", 08, 4.5],
    ["UI\uav\UAV_06", 17, 4.5],
    ["UI\uav\UAV_07", 10, 4.5]
];

DFUNC(shuffleSoundArray) = {
    GVAR(soundList) = GVAR(soundList) call CFUNC(shuffleArray);
    [FUNC(shuffleSoundArray), 300] call CFUNC(wait);
};

call FUNC(shuffleSoundArray);

DFUNC(playRadioSound) = {
    params ["_obj"];
    if (isNull _obj) exitWith {};
    private _data = selectRandom GVAR(soundList);
    _data params ["_soundPath", "_length", ["_volume", 1]];
    _soundPath = format ["a3\sounds_f\sfx\%1.wss", _soundPath];

    playSound3D [_soundPath, _obj, false, getPosASL _obj, (_volume * 5), 1, 100];
    [FUNC(playRadioSound), (_length + random 5), _obj] call CFUNC(wait);
};

[QGVAR(placed), {
    (_this select 0) params ["_pointId"];
    private _data = [_pointId, "pointobjects"] call EFUNC(Common,getDeploymentPointData);
    (selectRandom _data) call FUNC(playRadioSound);
}] call CFUNC(addEventhandler);
