#include "macros.hpp"

// Rating system
["sideChanged", {
    (_this select 0) params ["_currentSide", "_oldSide"];

    if (_currentSide == sideEnemy) then {
        _rating = rating PRA3_player;
        PRA3_player addRating (0 - _rating);
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
    } count ("true" configClasses (missionConfigFile >> "PRA3" >> "sides"));
}] call CFUNC(addEventhandler);
