#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    End mission (with endMission-Event)

    Remark:
    -

    Parameter(s):
    1: type <String> // "WINNER" | "LOOSER"

    Returns:
    None
*/
params [["_type", "WINNER"]];

missionnamespace setvariable ["BIS_fnc_missionHandlers_win",_type isEqualTo "WINNER"];
missionnamespace setvariable ["BIS_fnc_missionHandlers_end",_type];


private _musicVolume = musicVolume;
0.2 fademusic 0;
[{
    params ["_win", "_musicVolume"];
    private _musicList = if (isnull curatorcamera) then {["EventTrack02_F_Curator","EventTrack01_F_Curator"]} else {["EventTrack02_F_Curator","EventTrack03_F_Curator"]};
    playmusic (_musicList select _win);
    0 fademusic _musicVolume;
}, 0.2, [_type == "WINNER", _musicVolume]] call CFUNC(wait);

[{
    QGVAR(layerStatic) cutrsc ["RscStatic","plain"];
}, 0.6] call CFUNC(wait);

RscMissionEnd_end = _type;
RscMissionEnd_win = _type isEqualTo "WINNER";

[{
    showHUD false;
    QGVAR(layerEnd) cutrsc ["RscMissionEnd","plain"];
}, 0.9] call CFUNC(wait);

[{
    params ["_type"];
    if (_type isEqualTo "WINNER") then {
        endMission _type;
    } else {
        failMission _type;
    };

    findDisplay 46 closeDisplay 1;

}, 15.9, [_type]] call CFUNC(wait);

["endMission", [_type]] call CFUNC(localEvent);
