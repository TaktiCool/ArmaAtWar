#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas, NetFusion, BadGuy

    Description:
    Init file for common stuff

    Parameter(s):
    None
*/

// Version Informations
private _missionVersionStr = "";
private _missionVersionAr = getArray (missionConfigFile >> QPREFIX >> "Version");

private _serverVersionStr = "";
private _serverVersionAr = [VERSION_AR];

{
    _missionVersionStr = _missionVersionStr + str _x + ".";
    nil
} count _missionVersionAr;

{
    _serverVersionStr = _serverVersionStr + str _x + ".";
    nil
} count _serverVersionAr;

DUMP("Version Mission: " + _missionVersionStr + "; Version Server: " + _serverVersionStr);

_missionVersionStr = _missionVersionStr select [0, (count _missionVersionStr - 1)];
_serverVersionStr = _serverVersionStr select [0, (count _serverVersionStr - 1)];
GVAR(VersionInfo) = [[_missionVersionStr, _missionVersionAr], [_serverVersionStr, _serverVersionAr]];
publicVariable QGVAR(VersionInfo);

GVAR(ignoreVariables) = [
    toLower QGVAR(PlayerInteraction_Actions),
    toLower QGVAR(tempUnit),
    toLower QGVAR(isProcessed),
    toLower QEGVAR(Revive,reviveEventhandlerAdded),
    toLower QEGVAR(Revive,damageWaitIsRunning)
];

GVAR(allLocationTypes) = [];
{
    GVAR(allLocationTypes) pushBack (configName _x);
    nil
} count ("true" configClasses (configFile >> "CfgLocationTypes"));

GVAR(markerLocations) = getArray (missionConfigFile >> QPREFIX >> "markerLocation");
GVAR(markerLocations) = GVAR(markerLocations) apply {
    private _text = markerText _x;
    if (_text call CFUNC(isLocalised)) then {
        _text = LOC(_text);
    };
    [_x, getMarkerPos _x, _text]
};

if (hasInterface) then {
    ["missionStarted", {
        private _mainDisplay = findDisplay 46;

        _ctrl = _mainDisplay ctrlCreate ["RscStructuredText", -1];
        _ctrl ctrlSetPosition [safeZoneX + safeZoneW - PX(50), safeZoneY + safeZoneH - PY(8), PX(50), PY(10)];
        _ctrl ctrlSetFade 0.4;
        _ctrl ctrlSetStructuredText parseText format [
            "<t align='right' size='%1'>Mission Version: %2<br />Server Version: %3</t><br /><t align='right' size='%4'>The current version of AAW is in a stage of early Alpha.<br />Every element is subject to change at the current state of development</t>",
            PY(1.8) / 0.035,
            (GVAR(VersionInfo) select 0) select 0,
            (GVAR(VersionInfo) select 1) select 0,
            PY(1.5) / 0.035
        ];
        _ctrl ctrlCommit 0;

        uiNamespace setVariable [UIVAR(VersionInfo), _ctrl];

        _mainDisplay displayAddEventHandler ["KeyDown", {
            if ((_this select 1) == 1) then {
                [{
                    private _pauseMenuDisplay = findDisplay 49;

                    private _ctrl = _pauseMenuDisplay ctrlCreate ["RscStructuredText", -1];
                    _ctrl ctrlSetPosition [safeZoneX + safeZoneW - PX(30), safeZoneY + safeZoneH - PY(30), PX(30), PY(30)];
                    _ctrl ctrlSetFade 0;
                    _ctrl ctrlSetStructuredText parseText format [
                        "<t align='center'><img color='#ffffff' shadow='0' size='%1' image='ui\media\AAWLogo_ca.paa' /></t><t align='center' size='%2'><br />Mission Version: %3<br />Server Version: %4<br /></t><t size='%5' align='center' font='PuristaBold'><a href='https://github.com/TaktiCool/ArmaAtWar/blob/master/.github/CONTRIBUTING.md'>REPORT AN ISSUE</a></t>",
                        PY(15) / 0.035,
                        PY(1.8) / 0.035,
                        (GVAR(VersionInfo) select 0) select 0,
                        (GVAR(VersionInfo) select 1) select 0,
                        PY(2.2) / 0.035
                    ];
                    _ctrl ctrlCommit 0;
                }, {!isNull (findDisplay 49)}, []] call CFUNC(waitUntil);
                nil
            };
        }];
    }] call CFUNC(addEventhandler);

    // Disable all Radio Messages
    enableSentences false;
    enableRadio false;

    ["playerChanged", {
        (_this select 0) params ["_newPlayer"];
        _newPlayer disableConversation true;
        _newPlayer setVariable ["BIS_noCoreConversations", true];
    }] call CFUNC(addEventhandler);

    ["entityCreated", {
        params ["_args"];
        if (_args isKindOf "CAManBase") then {
            _args disableConversation true;
            _args setVariable ["BIS_noCoreConversations", true];
        };
    }] call CFUNC(addEventhandler);

    // Rating system
    ["sideChanged", {
        (_this select 0) params ["_currentSide", "_oldSide"];

        if (_currentSide == sideEnemy) then {
            _rating = rating CLib_Player;
            CLib_Player addRating (0 - _rating);
        };
    }] call CFUNC(addEventhandler);
};

// generate Base sides and Hide all Markers
["missionStarted", {
    if (isServer) then {
        {_x setMarkerAlpha 0} count allMapMarkers;
    };

    GVAR(competingSides) = [];
    {
        private _side = sideUnknown;
        if (configName _x == "WEST") then {
            _side = west;
        };
        if (configName _x == "EAST") then {
            _side = east;
        };
        if (configName _x == "GUER") then {
            _side = independent;
        };
        if (configName _x == "CIV") then {
            _side = civilian;
        };
        GVAR(competingSides) pushBack _side;
        missionNamespace setVariable [format [QGVAR(Flag_%1), _side], getText (_x >> "flag")];
        missionNamespace setVariable [format [QGVAR(SideColor_%1), _side], getArray (_x >> "color")];
        missionNamespace setVariable [format [QGVAR(SideName_%1), _side], getText (_x >> "name")];
        missionNamespace setVariable [format [QGVAR(SideMapIcon_%1), _side], getText (_x >> "mapIcon")];
        nil;
    } count ("true" configClasses (missionConfigFile >> QPREFIX >> "sides"));
    // Temp for Ribbon
    if (isClass (configFile >> "CfgPatches" >> "gcam")) then {
        [{
            [
                "Hide HUD (Permanent)",
                CLib_Player,
                0,
                {true},
                {
                    ([UIVAR(Compass)] call BIS_fnc_rscLayer) cutFadeOut 0;
                    ([UIVAR(TicketStatus)] call BIS_fnc_rscLayer) cutFadeOut 0;
                    ([UIVAR(CaptureStatus)] call BIS_fnc_rscLayer) cutFadeOut 0;
                    ([UIVAR(PerformanceStatus)] call BIS_fnc_rscLayer) cutFadeOut 0;
                    (uiNamespace getVariable [UIVAR(VersionInfo), controlNull]) ctrlSetFade 1;
                    // showHUD [false, false, false, false, false, false, false, false, false];

                    CGVAR(hideHUD) = true;
                }
            ] call CFUNC(addAction);

            [
                "Hide Player",
                CLib_Player,
                0,
                {true},
                {
                    ["hideObject", [CLib_Player, true]] call CFUNC(serverEvent);
                    ["enableSimulation", [CLib_Player, false]] call CFUNC(serverEvent);
                    ["allowDamage", CLib_Player, [CLib_Player, true]] call CFUNC(targetEvent);
                }
            ] call CFUNC(addAction);
        }, 10] call CFUNC(wait);
    };
}] call CFUNC(addEventhandler);

["performanceCheck", 0] call CFUNC(addIgnoredEventLog);
CGVAR(hideHUD) = false;
