#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Initialize the

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(competingSides) = [];
{
    GVAR(competingSides) pushBack configName _x;
    missionNamespace setVariable [format ["%1_%2",QGVAR(Flag),configName _x], getText (_x >> "flag")];
    missionNamespace setVariable [format ["%1_%2",QGVAR(SideColor),configName _x], getArray (_x >> "color")];
    nil;
} count ("true" configClasses (missionConfigFile >> "PRA3" >> "sides"));

if (isServer) then {
    [] spawn {
        GVAR(allSectors) = (call EFUNC(Core,getLogicGroup)) createUnit ["Logic", [0,0,0], [], 0, "NONE"];
        publicVariable QGVAR(allSectors);
        GVAR(allSectorsArray) = [];


        private _sectors = "true" configClasses (missionConfigFile >> "PRA3" >> "CfgSectors");

        {
            [configName _x, getArray (_x >> "dependency"),getNumber (_x >> "ticketBleed"),getNumber (_x >> "minUnits"),getArray (_x >> "captureTime"), getText (_x >> "designator")] call FUNC(createSectorLogic);
            nil;
        } count _sectors;
        publicVariable QGVAR(allSectorsArray);
    };
};

[{
    {
        [_x] call FUNC(createSectorTrigger);
        nil;
    } count GVAR(allSectorsArray);
    if (isServer) then {
        GVAR(sectorLoopCounter) = 0;
        [FUNC(loop), 0.1, []] call CFUNC(addPerFrameHandler);
        ["sector_side_changed", {
            params ["_sector", "_oldSide", "_newSide"];

            private _marker = _sector getVariable ["marker",""];

            if (_marker != "") then {
                _marker setMarkerColor format["Color%1",_newSide];
            };
        }] call EFUNC(events,addEventHandler);
    };

    if (hasInterface) then {
        GVAR(captureStatusPFH) = false;
        ["sector_entered", {[true,_this select 0] call FUNC(showCaptureStatus);}] call EFUNC(events,addEventHandler);

        ["sector_leaved", {[false,_this select 0] call FUNC(showCaptureStatus);}] call EFUNC(events,addEventHandler);

        ["sector_side_changed", {hint format["SECTOR %1 SIDE CHANGED FROM %2 TO %3",_this select 0,_this select 1,_this select 2];}] call EFUNC(events,addEventHandler);

        /*
        player addEventHandler ["Respawn", {
            {
                [_x] call FUNC(createSectorTrigger);
                nil;
            } count GVAR(allSectorsArray);
            nil;
        }];
        */
    };

}, {
    !isNil QGVAR(allSectorsArray)
}] call CFUNC(waitUntil);
