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
        GVAR(competingSides) pushBack (configName _x);
        missionNamespace setVariable [format ["%1_%2", QGVAR(Flag), configName _x], getText (_x >> "flag")];
        missionNamespace setVariable [format ["%1_%2", QGVAR(SideColor), configName _x], getArray (_x >> "color")];
        missionNamespace setVariable [format ["%1_%2", QGVAR(SideName), configName _x], getText (_x >> "name")];
        nil;
    } count ("true" configClasses (missionConfigFile >> "PRA3" >> "sides"));
}] call CFUNC(addEventhandler);
