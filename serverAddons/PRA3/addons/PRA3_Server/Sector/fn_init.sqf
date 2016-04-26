#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Initialize the

    Parameter(s):
    None

    Returns:
    None
*/


["missionStarted", {
    GVAR(captureStatusPFH) = -1;
    GVAR(currentSector) = objNull;
    [QGVAR(SideSelection)] call bis_fnc_startLoadingScreen;
    if (isServer) then {
        [{
            GVAR(allSectors) = (call CFUNC(getLogicGroup)) createUnit ["Logic", [0,0,0], [], 0, "NONE"];
            publicVariable QGVAR(allSectors);
            GVAR(allSectorsArray) = [];
            private _sectors = "true" configClasses (missionConfigFile >> "PRA3" >> "CfgSectors");

            {
                if ((configName _x find "base") >= 0) then {
                    [configName _x, getArray(_x >> "dependency"), getNumber(_x >> "ticketValue"), getNumber(_x >> "minUnits"), getArray(_x >> "captureTime"), getArray(_x >> "firstCaptureTime"), getText(_x >> "designator")] call FUNC(createSectorLogic);
                };
                nil;
            } count _sectors;

            private _path = selectRandom ("true" configClasses (missionConfigFile >> "PRA3" >> "CfgSectors" >> "CfgSectorPath"));

            {
                [configName _x, getArray (_x >> "dependency"),getNumber (_x >> "ticketValue"),getNumber (_x >> "minUnits"),getArray (_x >> "captureTime"), getArray(_x >> "firstCaptureTime"), getText (_x >> "designator")] call FUNC(createSectorLogic);
                nil;
            } count ("true" configClasses _path);

            publicVariable QGVAR(FirstCaptureTime);
            publicVariable QGVAR(allSectorsArray);
            GVAR(sectorCreationDone) = true;
            publicVariable QGVAR(sectorCreationDone);

        }, 3,[]] call CFUNC(wait);
    };

    [{
        {
            [_x] call FUNC(createSectorTrigger);
            nil;
        } count GVAR(allSectorsArray);
        if (isServer) then {
            GVAR(sectorLoopCounter) = 0;
            [QFUNC(loop), 0.1, []] call CFUNC(addPerFrameHandler);
            ["sector_side_changed", {
                (_this select 0) params ["_sector", "_oldSide", "_newSide"];

                private _marker = _sector getVariable ["name", ""];
                private _designator = _sector getVariable ["designator", ""];

                ["sectorCreated", [_newSide, _marker, _designator]] call CFUNC(globalEvent);

                private _marker = _sector getVariable ["marker",""];

                if (_marker != "") then {
                    _marker setMarkerColor format["Color%1", _newSide];
                };
            }] call CFUNC(addEventHandler);
        };

        if (hasInterface) then {
            ["sector_entered", {[true,_this select 0] call FUNC(showCaptureStatus); GVAR(currentSector) = ([_this select 0] call FUNC(getSector));}] call CFUNC(addEventHandler);

            ["sector_leaved", {[false,_this select 0] call FUNC(showCaptureStatus); GVAR(currentSector) = objNull;}] call CFUNC(addEventHandler);

            ["sector_side_changed", {
                params ["_args"];
                _args params ["_sector", "_oldSide", "_newSide"];

                private _sectorName = _sector getVariable ["fullName", ""];

                if ((side group PRA3_Player) isEqualTo _newSide) exitWith {
                    if (GVAR(currentSector) isEqualTo _sector) then {
                        [format["You captured sector %1", _sectorName], missionNamespace getVariable [format [QGVAR(SideColor_%1), _newSide],[0,1,0,1]]] call CFUNC(displayNotification);
                    } else {
                        [format["Your team captured sector %1", _sectorName], missionNamespace getVariable [format [QGVAR(SideColor_%1), _newSide],[0,1,0,1]]] call CFUNC(displayNotification);
                    };
                };

                if ((side group PRA3_Player) isEqualTo _oldSide) exitWith {
                    [format["You lost sector %1", _sectorName], missionNamespace getVariable [format [QGVAR(SideColor_%1), _newSide],[0,1,0,1]]] call CFUNC(displayNotification);
                };

                if (sideUnknown isEqualTo _newSide && !((side group PRA3_Player) isEqualTo _oldSide)) exitWith {
                    if (GVAR(currentSector) isEqualTo _sector) then {
                        [format["You neutralized sector %1", _sectorName], missionNamespace getVariable [format [QGVAR(SideColor_%1), _sector getVariable ["attacker"]],[0,1,0,1]]] call CFUNC(displayNotification);
                    } else {
                        [format["Your team neutralized sector %1", _sectorName], missionNamespace getVariable [format [QGVAR(SideColor_%1), _sector getVariable ["attacker"]],[0,1,0,1]]] call CFUNC(displayNotification);
                    };
                };
            }] call CFUNC(addEventHandler);

            ["sectorCreated", {
                (_this select 0) params ["_side", "_marker", "_designator"];
                private _color = [
                    missionNamespace getVariable format [QEGVAR(mission,SideColor_%1), str _side],
                    [(profilenamespace getvariable ['Map_Unknown_R',0]),(profilenamespace getvariable ['Map_Unknown_G',1]),(profilenamespace getvariable ['Map_Unknown_B',1]),(profilenamespace getvariable ['Map_Unknown_A',0.8])]
                ] select (_side isEqualTo sideUnknown);

                private _icon = [
                    missionNamespace getVariable format [QEGVAR(mission,SideMapIcon_%1), str _side],
                    "a3\ui_f\data\Map\Markers\NATO\u_installation.paa"
                ] select (_side isEqualTo sideUnknown);

                private _id = format [QGVAR(ID_%1), _marker];
                [
                    _id,
                    [
                        [_icon, _color, getMarkerPos _marker],
                        ["a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1,1,1,1], getMarkerPos _marker, 25, 0, _designator, 2]
                    ]
                ] call CFUNC(addMapIcon);

                [
                    _id,
                    [
                        [_icon, _color, getMarkerPos _marker],
                        ["a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [0,0,0,1], getMarkerPos _marker, 25, 0, _designator, 2]
                    ],
                    "hover"
                ] call CFUNC(addMapIcon);
            }] call CFUNC(addEventHandler);

            {
                private _side = _x getVariable ["side", sideUnknown];
                private _marker = _x getVariable ["name", ""];
                private _designator = _x getVariable ["designator", "A"];
                ["sectorCreated", [_side, _marker, _designator]] call CFUNC(localEvent);
                nil
            } count GVAR(allSectorsArray);
        };
        [QGVAR(SideSelection)] call bis_fnc_endLoadingScreen;
    }, {
        !isNil QGVAR(sectorCreationDone)
    },[]] call CFUNC(waitUntil);
}] call CFUNC(addEventhandler);
