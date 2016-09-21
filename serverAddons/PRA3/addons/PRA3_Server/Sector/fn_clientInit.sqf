#include "macros.hpp"
/*
    Project Reality ArmA 3

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
    [QGVAR(LoadingScreen)] call bis_fnc_startLoadingScreen;
    [{
        [QGVAR(LoadingScreen)] call bis_fnc_endLoadingScreen;
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
    [false,_this select 1] call FUNC(showCaptureStatus);
    GVAR(currentSector) = objNull;
}] call CFUNC(addEventHandler);

["sectorSideChanged", {
    params ["_args"];
    _args params ["_sector", "_oldSide", "_newSide"];

    private _sectorName = _sector getVariable ["fullName", ""];

    if ((side group Clib_Player) isEqualTo _newSide) exitWith {
        if (GVAR(currentSector) isEqualTo _sector) then {
            [format["You captured sector %1", _sectorName], missionNamespace getVariable [format [QEGVAR(Mission,SideColor_%1), _newSide],[0,1,0,1]]] call EFUNC(Common,displayNotification);
        } else {
            [format["Your team captured sector %1", _sectorName], missionNamespace getVariable [format [QEGVAR(Mission,SideColor_%1), _newSide],[0,1,0,1]]] call EFUNC(Common,displayNotification);
        };
    };

    if ((side group Clib_Player) isEqualTo _oldSide) exitWith {
        [format["You lost sector %1", _sectorName], missionNamespace getVariable [format [QEGVAR(Mission,SideColor_%1), _newSide],[0,1,0,1]]] call EFUNC(Common,displayNotification);
    };

    if (sideUnknown isEqualTo _newSide && !((side group Clib_Player) isEqualTo _oldSide)) exitWith {
        if (GVAR(currentSector) isEqualTo _sector) then {
            [format["You neutralized sector %1", _sectorName], missionNamespace getVariable [format [QEGVAR(Mission,SideColor_%1), _sector getVariable ["attackerSide", sideUnknown]],[0,1,0,1]]] call EFUNC(Common,displayNotification);
        } else {
            [format["Your team neutralized sector %1", _sectorName], missionNamespace getVariable [format [QEGVAR(Mission,SideColor_%1), _sector getVariable ["attackerSide", sideUnknown]],[0,1,0,1]]] call EFUNC(Common,displayNotification);
        };
    };


}] call CFUNC(addEventHandler);

[{
    if (isNil QGVAR(allSectorsArray)) exitWith {};
    scopeName "MAIN";
    if (alive Clib_Player) then {
        {
            private _marker = _x getVariable ["marker",""];
            if (_marker != "") then {
                if (Clib_Player inArea _marker) then {
                    if (GVAR(currentSector) != _x) then {
                        if (!isNull GVAR(currentSector)) then {
                            if (!isServer) then {
                                ["sectorLeaved", [Clib_Player, GVAR(currentSector)]] call CFUNC(serverEvent);
                            };
                            ["sectorLeaved", [Clib_Player, GVAR(currentSector)]] call CFUNC(localEvent);
                        };

                        GVAR(currentSector) = _x;

                        if (!isServer) then {
                            ["sectorEntered", [Clib_Player, GVAR(currentSector)]] call CFUNC(serverEvent);
                        };
                        ["sectorEntered", [Clib_Player, GVAR(currentSector)]] call CFUNC(localEvent);

                    };
                    breakOut "MAIN";
                };
            };
            nil;
        } count GVAR(allSectorsArray);
    };

    if (!isNull GVAR(currentSector)) then {
        if (!isServer) then {
            ["sectorLeaved", [Clib_Player, GVAR(currentSector)]] call CFUNC(serverEvent);
        };
        ["sectorLeaved", [Clib_Player, GVAR(currentSector)]] call CFUNC(localEvent);
    };

}, 0.1, []] call CFUNC(addPerFrameHandler);
