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

    ["joinGroupRequested",{
        (_this select 0) params ["_group","_unit"];

        if ((count units _group) < 9) then {
            [_unit] join _group;
        };

    }] call CFUNC(addEventhandler);

    ["sideChangeRequested",{
        (_this select 0) params ["_unit"];
        private _currentSide = side group _unit;
        private _otherSide = call compile ((GVAR(competingSides) select { _x != str _currentSide }) select 0);

        private _baseGroupCurrentSide = missionNamespace getVariable (format [QGVAR(baseGroup%1), _currentSide]);
        private _baseGroupOtherSide = missionNamespace getVariable (format [QGVAR(baseGroup%1), _otherSide]);

        if (group _unit != _baseGroupCurrentSide) then {
            ["groupLeave", group _unit] call CFUNC(globalEvent);
        };

        [_unit] join _baseGroupOtherSide;
        ["changeSide", _unit, _otherSide] call CFUNC(targetEvent);

    }] call CFUNC(addEventhandler);

    ["selectLeaderRequested",{
        (_this select 0) params ["_group","_unit"];

        hint format ["%1, %2",_group, _unit];
        ["selectLeader", groupOwner _group, [_group, _unit]] call FUNC(targetEvent);

    }] call CFUNC(addEventhandler);
};
