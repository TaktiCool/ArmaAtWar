#include "macros.hpp"


GVAR(cachedCall) = call FUNC(createNamespace);
PRA3_Player setVariable [QGVAR(side), playerSide];
PRA3_Player setVariable [QGVAR(playerName), profileName, true];

if (hasInterface) then {
    [{
        (findDisplay 46) displayAddEventHandler ["KeyDown", {
            if ((_this select 1)==1) then {
                [{
                    disableSerialization;
                    private _pauseMenuDisplay = findDisplay 49;

                    _gY = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
                    _gX = (((safezoneW / safezoneH) min 1.2) / 40);

                    _gY0 = SafeZoneY;
                    _gX0 = SafeZoneX;

                    private _controlGroup  = _pauseMenuDisplay ctrlCreate ["RscControlsGroupNoScrollbars",-1];
                    _controlGroup ctrlSetPosition [_gX0+safezoneW-9*_gX,_gY0+safezoneH-12*_gY,9*_gX,11*_gY];
                    _controlGroup ctrlCommit 0;

                    private _ctrl = _pauseMenuDisplay ctrlCreate ["RscPicture",-1,_controlGroup];
                    _ctrl ctrlSetPosition [0,0,8*_gX,8*_gY];
                    _ctrl ctrlSetText "media\PRA3Logo_ca.paa";
                    _ctrl ctrlCommit 0;

                    private _ctrl = _pauseMenuDisplay ctrlCreate ["RscText",-1,_controlGroup];
                    _ctrl ctrlSetPosition [0*_gX,8*_gY,8*_gX,1*_gY];
                    _ctrl ctrlSetText format ["Mission Version: %1", (GVAR(VersionInfo) select 0) select 0];
                    _ctrl ctrlCommit 0;

                    private _ctrl = _pauseMenuDisplay ctrlCreate ["RscText",-1,_controlGroup];
                    _ctrl ctrlSetPosition [0*_gX,8.8*_gY,8*_gX,1*_gY];
                    _ctrl ctrlSetText format ["Server Version: %1", (GVAR(VersionInfo) select 1) select 0];
                    _ctrl ctrlCommit 0;
                }, {!isNull (findDisplay 49)}, []] call CFUNC(waitUntil);
            };
        }];
    }, {!isNull (findDisplay 46)}, []] call CFUNC(waitUntil);
};
