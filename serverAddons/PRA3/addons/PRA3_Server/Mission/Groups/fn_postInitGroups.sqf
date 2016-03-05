#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Init Groups

    Parameter(s):
    None

    Returns:
    None
*/

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


    ["new_group",{
        (_this select 0) params ["_group"];

        private _allGroupIds = [];

        {
            if (side _x == side _group) then {
                private _groupId = _x getVariable ["PRA3_GroupId",""];
                if (_groupId != "") then {
                    _allGroupIds pushBack _groupId;
                };
            };
            nil;
        } count allGroups;

        private _groupId = (GVAR(allGroupIds)-_allGroupIds) select 0;

        _group setVariable ["PRA3_GroupId", _groupId,true];

    }] call CFUNC(addEventhandler);
};
