#include "macros.hpp"


GVAR(cachedCall) = call FUNC(createNamespace);
PRA3_Player setVariable [QGVAR(side), playerSide];
PRA3_Player setVariable [QGVAR(playerName), profileName, true];

if (hasInterface) then {
    [{
        disableSerialization;
        private _pauseMenuDisplay = findDisplay 49;

        _gY = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
        _gX = (((safezoneW / safezoneH) min 1.2) / 40);

        _gY0 = SafeZoneY;
        _gX0 = SafeZoneX;

        private _controlGroup  = _pauseMenuDisplay ctrlCreate ["RscControlsGroupNoScrollbars",-1];
        _controlGroup ctrlSetPosition [_gX0+safeZoneW-24*_gX,safezoneH-9*_gY,13*_gX,8.1*_gY];
        _controlGroup ctrlCommit 0;

        private _ctrl = _pauseMenuDisplay ctrlCreate ["RscText",-1,_controlGroup];
        _ctrl ctrlSetPosition [0.1*_gX,0.1*_gY,4.8*_gX,1*_gY];
        _ctrl ctrlSetText format ["Mission Version: %1", (GVAR(VersionInfo) select 0) select 0];
        _ctrl ctrlCommit 0;

        private _ctrl = _pauseMenuDisplay ctrlCreate ["RscText",-1,_controlGroup];
        _ctrl ctrlSetPosition [0.1*_gX,1.1*_gY,4.8*_gX,1*_gY];
        _ctrl ctrlSetText format ["Server Version: %1", (GVAR(VersionInfo) select 1) select 0];
        _ctrl ctrlCommit 0;


    }, {!isNull (findDisplay 49)}, []] call CFUNC(waitUntil);
};
