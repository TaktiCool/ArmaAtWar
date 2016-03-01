#include "script_macros.hpp"

if (isServer) then {
    GVAR(allGroupIds) = [
        "ALPHA",
        "BRAVO",
        "CHARLIE",
        "DELTA",
        "ECHO",
        "FOXTROT",
        "GOLF",
        "HOTEL",
        "INDIA",
        "JULIETTE",
        "KILO",
        "LIMA",
        "MIKE",
        "NOVEMBER",
        "OSCAR",
        "PAPA",
        "QUEBEC",
        "ROMEO",
        "SIERRA",
        "TANGO",
        "UNIFORM",
        "VICTOR",
        "WHISKEY",
        "XRAY",
        "YANKEE",
        "ZULU"
    ];

    GVAR(currentGroupIndexWest) = 0;
    GVAR(currentGroupIndexEast) = 0;
    GVAR(currentGroupIndexGUER) = 0;

    ["new_group",{
        params ["_group"];

        private _allGroupIds = [];

        {
            if (side _x == side _group) then {
                private _groupId = _x getVariable ["BG_GroupId",""];
                if (_groupId != "") then {
                    _allGroupIds pushBack _groupId;
                };
            };
            nil;
        } count allGroups;

        hint format ["%1",_allGroupIds];

        private _groupId = (GVAR(allGroupIds)-_allGroupIds) select 0;

        _group setVariable ["BG_GroupId", _groupId,true];

        }] call CBA_fnc_addEventHandler;
};
