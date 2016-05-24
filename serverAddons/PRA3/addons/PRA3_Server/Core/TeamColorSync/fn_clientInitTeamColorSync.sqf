#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Init Team Color Sync

    Parameter(s):
    None

    Returns:
    None
*/

if (didJIP) then {
    {
        private _globalTeam = _x getVariable [QGVAR(teamColor_Color), "MAIN"];
        if (_globalTeam != "") then {
            _x assignTeam _globalTeam;
        };
        true
    } count allUnits;
};

GVAR(teamColor_currentIndex) = -1;
[{
    private _units = units PRA3_Player;
    if (_units isEqualTo [PRA3_Player]) exitWith {};
    GVAR(teamColor_currentIndex) = (GVAR(teamColor_currentIndex) + 1) mod (count _units);
    private _unit = _units select GVAR(teamColor_currentIndex);
    private _localTeamCur = assignedTeam _unit;
    private _localTeamPrev = _unit getVariable [QGVAR(teamColor_prevTeam), "MAIN"];
    private _globalTeam = _unit getVariable [QGVAR(teamColor_Color), "MAIN"];
    if !(isNil "_localTeamCur") exitWith {}; // assignedTeam can return Nil in some wierd Cases
    if (_localTeamPrev != _localTeamCur) then {
        ["teamColorChanged", [_localTeamCur, _unit], _units] call CFUNC(targetEvent);
        _unit setVariable [QGVAR(teamColor_prevTeam), _localTeamCur];
        _unit setVariable [QGVAR(teamColor_Color), _localTeamCur, true];
        _globalTeam = _localTeamCur;
    };
    if (_localTeamCur != _globalTeam) then {
        _unit assignTeam _globalTeam;
        _unit setVariable [QGVAR(teamColor_prevTeam), _globalTeam];
    };
}] call CFUNC(addPerFrameHandler);

["teamColorChanged", {
    (_this select 0) params ["_team", "_unit"];
    _unit assignTeam _team;
    _unit setVariable [QGVAR(teamColor_prevTeam), _team];
}] call CFUNC(addEventHandler);
