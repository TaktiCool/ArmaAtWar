#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy

    Description:
    Initialize the Sector Module on Client

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(currentSector) = objNull;

["missionStarted", {
    [QGVAR(LoadingScreen)] call BIS_fnc_startLoadingScreen;
    [{
        [QGVAR(LoadingScreen)] call BIS_fnc_endLoadingScreen;
    }, {
        !isNil QEGVAR(Sector,ServerInitDone) && {EGVAR(Sector,ServerInitDone)}
    }] call CFUNC(waitUntil);
}] call CFUNC(addEventhandler);

["sectorEntered", {
    params ["_args"];
    _args params ["_unit", "_sector"];
    [true, _sector] call FUNC(showCaptureStatus);
}] call CFUNC(addEventHandler);

["sectorLeaved", {
    [false, _this select 1] call FUNC(showCaptureStatus);
    GVAR(currentSector) = objNull;
}] call CFUNC(addEventHandler);

["sectorSideChanged", {
    params ["_args"];
    _args params ["_sector", "_oldSide", "_newSide"];

    private _sectorName = _sector getVariable ["fullName", ""];

    if ((side group CLib_Player) isEqualTo _newSide) exitWith {
        if (GVAR(currentSector) isEqualTo _sector) then {
            [format [MLOC(YouSC), _sectorName], missionNamespace getVariable [format [QEGVAR(Common,SideColor_%1), _newSide], [0, 1, 0, 1]]] call EFUNC(Common,displayNotification);
        } else {
            [format [MLOC(YourTSC), _sectorName], missionNamespace getVariable [format [QEGVAR(Common,SideColor_%1), _newSide], [0, 1, 0, 1]]] call EFUNC(Common,displayNotification);
        };
    };

    if ((side group CLib_Player) isEqualTo _oldSide) exitWith {
        [format [MLOC(YouSL), _sectorName], missionNamespace getVariable [format [QEGVAR(Common,SideColor_%1), _newSide], [0, 1, 0, 1]]] call EFUNC(Common,displayNotification);
    };

    if (sideUnknown isEqualTo _newSide && !((side group CLib_Player) isEqualTo _oldSide)) exitWith {
        if (GVAR(currentSector) isEqualTo _sector) then {
            [format [MLOC(YouSN), _sectorName], missionNamespace getVariable [format [QEGVAR(Common,SideColor_%1), _sector getVariable ["attackerSide", sideUnknown]], [0, 1, 0, 1]]] call EFUNC(Common,displayNotification);
        } else {
            [format [MLOC(YourTSN), _sectorName], missionNamespace getVariable [format [QEGVAR(Common,SideColor_%1), _sector getVariable ["attackerSide", sideUnknown]], [0, 1, 0, 1]]] call EFUNC(Common,displayNotification);
        };
    };
}] call CFUNC(addEventHandler);

[{
    if (isNil QGVAR(allSectorsArray)) exitWith {};
    scopeName "MAIN";
    if (alive CLib_Player) then {
        {
            private _marker = _x getVariable ["marker", ""];
            if (_marker != "") then {
                if (CLib_Player inArea _marker) then {
                    if (GVAR(currentSector) != _x) then {
                        if !(isNull GVAR(currentSector)) then {
                            if !(isServer) then {
                                ["sectorLeaved", [CLib_Player, GVAR(currentSector)]] call CFUNC(serverEvent);
                            };
                            ["sectorLeaved", [CLib_Player, GVAR(currentSector)]] call CFUNC(localEvent);
                        };

                        GVAR(currentSector) = _x;

                        if !(isServer) then {
                            ["sectorEntered", [CLib_Player, GVAR(currentSector)]] call CFUNC(serverEvent);
                        };
                        ["sectorEntered", [CLib_Player, GVAR(currentSector)]] call CFUNC(localEvent);
                    };
                    breakOut "MAIN";
                };
            };
            nil;
        } count GVAR(allSectorsArray);
    };

    if !(isNull GVAR(currentSector)) then {
        if !(isServer) then {
            ["sectorLeaved", [CLib_Player, GVAR(currentSector)]] call CFUNC(serverEvent);
        };
        ["sectorLeaved", [CLib_Player, GVAR(currentSector)]] call CFUNC(localEvent);
    };
}, 0.1, []] call CFUNC(addPerFrameHandler);
