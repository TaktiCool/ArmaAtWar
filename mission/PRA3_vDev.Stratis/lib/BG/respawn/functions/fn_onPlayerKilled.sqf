#include "script_macros.hpp"
params ["_oldUnit","_killer","_respawn","_respawnDelay"];

private _pfh = [{
    setPlayerRespawnTime 60;
    }, 0, []] call CBA_fnc_addPerFrameHandler;

private _t = time + 2*_respawnDelay;

hint format["%1",_this];

waitUntil {_t<time;};
[_pfh] call CBA_fnc_removePerFrameHandler;
hint format["Respawn Now!",_this];
setPlayerRespawnTime 1;
waitUntil {playerRespawnTime == -1};
setPlayerRespawnTime _respawnDelay;
