#include "macros.hpp"

// Version Informations
private _missionVersionStr = "";
private _missionVersionAr = getArray(missionConfigFile >> QPREFIX >> "Version");

private _serverVersionStr = "";
private _serverVersionAr = getArray(configFile >> "CfgPatches" >> "PRA3_Server" >> "versionAr");

{
    _missionVersionStr = _missionVersionStr + str(_x) + ".";
    nil
} count _missionVersionAr;

{
    _serverVersionStr = _serverVersionStr + str(_x) + ".";
    nil
} count _serverVersionAr;

// TODO Create Database for Compatible Versions
if (!(_missionVersionAr isEqualTo _serverVersionAr) && (isClass (missionConfigFile >> QPREFIX))) then {
    ["Lost"] call BIS_fnc_endMissionServer
};

_missionVersionStr = _missionVersionStr select [0, (count _missionVersionStr - 1)];
_serverVersionStr = _serverVersionStr select [0, (count _serverVersionStr - 1)];
GVAR(VersionInfo) = [[_missionVersionStr,_missionVersionAr], [_serverVersionStr, _serverVersionAr]];
publicVariable QGVAR(VersionInfo);

GVAR(ignoreVariables) = [toLower(QGVAR(PlayerInteraction_Actions)),toLower(QGVAR(tempUnit)), toLower(QGVAR(isProcessed)), toLower(QEGVAR(Revive,reviveEventhandlerAdded)), toLower(QEGVAR(Revive,damageWaitIsRunning))];

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
        (findDisplay 46) displayAddEventHandler ["KeyDown", {
            if ((_this select 1)==1) then {
                [{
                    private _pauseMenuDisplay = findDisplay 49;

                    _gY = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
                    _gX = (((safezoneW / safezoneH) min 1.2) / 40);

                    _gY0 = SafeZoneY;
                    _gX0 = SafeZoneX;

                    private _controlGroup  = _pauseMenuDisplay ctrlCreate ["RscControlsGroupNoScrollbars",-1];
                    _controlGroup ctrlSetPosition [_gX0+safezoneW-10*_gX,_gY0+safezoneH-14*_gY,14*_gX,12*_gY];
                    _controlGroup ctrlCommit 0;

                    private _ctrl = _pauseMenuDisplay ctrlCreate ["RscPicture",-1,_controlGroup];
                    _ctrl ctrlSetPosition [0.25*_gX,0,8*_gX,8*_gY];
                    _ctrl ctrlSetText "ui\media\PRA3Logo_ca.paa";
                    _ctrl ctrlCommit 0;

                    _ctrl = _pauseMenuDisplay ctrlCreate ["RscText",-1,_controlGroup];
                    _ctrl ctrlSetPosition [0.5*_gX,8*_gY,8*_gX,1*_gY];
                    _ctrl ctrlSetText format ["Mission Version: %1", (GVAR(VersionInfo) select 0) select 0];
                    _ctrl ctrlCommit 0;

                    _ctrl = _pauseMenuDisplay ctrlCreate ["RscText",-1,_controlGroup];
                    _ctrl ctrlSetPosition [0.7*_gX,8.8*_gY,8*_gX,1*_gY];
                    _ctrl ctrlSetText format ["Server Version: %1", (GVAR(VersionInfo) select 1) select 0];
                    _ctrl ctrlCommit 0;

                    _ctrl = _pauseMenuDisplay ctrlCreate ["RscStructuredText",-1,_controlGroup];
                    _ctrl ctrlSetPosition [0*_gX,10*_gY,12*_gX,1*_gY];
                    _ctrl ctrlSetStructuredText parseText "<t size='1.2' font='PuristaBold'><a href='https://github.com/drakelinglabs/projectrealityarma3/blob/master/.github/CONTRIBUTING.md'>REPORT AN ISSUE</a></t>";
                    _ctrl ctrlCommit 0;
                }, {!isNull (findDisplay 49)}, []] call CFUNC(waitUntil);
            };
        }];
    }] call CFUNC(addEventhandler);

    // Disable all Radio Messages
    enableSentences false;
    enableRadio false;

    ["playerChanged", {
        (_this select 0) params ["_newPlayer"];
        _newPlayer disableConversation true;
        _newPlayer setVariable ["BIS_noCoreConversations", false];
    }] call CFUNC(addEventhandler);

    ["entityCreated", {
        params ["_args"];
        if (_args isKindOf "CAManBase") then {
            _args disableConversation true;
            _args setVariable ["BIS_noCoreConversations", true];
        };
    }] call CFUNC(addEventhandler);

};

// Rating system
["sideChanged", {
    (_this select 0) params ["_currentSide", "_oldSide"];

    if (_currentSide == sideEnemy) then {
        _rating = rating Clib_Player;
        Clib_Player addRating (0 - _rating);
    };
}] call CFUNC(addEventhandler);


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
}] call CFUNC(addEventhandler);

["performanceCheck", 0] call CFUNC(addIgnoredEventLog);
