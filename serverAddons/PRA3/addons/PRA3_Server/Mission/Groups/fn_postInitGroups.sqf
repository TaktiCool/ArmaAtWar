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
    {
        private _side = _x;
        private _allGroupIds = [];

        {
            if (_side == str side _x) then {
                private _groupId = _x getVariable ["PRA3_GroupId",""];
                if (_groupId != "") then {
                    _allGroupIds pushBack _groupId;
                };
            };
            nil;
        } count allGroups;

        private _groups = (GVAR(allGroupIds)-_allGroupIds);
        missionNamespace setVariable [format ["%1_%2",QGVAR(nextGroupId),_side], _groups select 0, true];
    } count GVAR(competingSides);

    ["newGroupRequested", {
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

        private _groups = (GVAR(allGroupIds)-_allGroupIds);
        private _groupId = _groups select 0;


        _group setVariable ["PRA3_GroupId", _groupId,true];
        missionNamespace setVariable [format ["%1_%2",QGVAR(nextGroupId), side _group], _groups select 1, true];

    }] call CFUNC(addEventhandler);
};
