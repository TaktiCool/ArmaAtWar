#include "macros.hpp"
/*
    Arma At War

    Author: NetFusion

    Description:
    Checks if a squad type can be used

    Parameter(s):
    0: Squad type name <String> (Default: "")

    Returns:
    <BOOL>
*/

params [
    ["_squadTypeName", "", [""]]
];

private _availableSquadCount = 1;
private _prefix = format [QGVAR(GroupTypes_%1_), _squadTypeName];

private _requiredGroups = [_prefix + "requiredGroups", 1] call CFUNC(getSetting);
if (_requiredGroups > 0) then {
    private _groupCount = {side _x == playerSide} count allGroups;
    _availableSquadCount = _groupCount / _requiredGroups;
};

private _requiredPlayers = [_prefix + "requiredPlayers", 1] call CFUNC(getSetting);
if (_requiredPlayers > 0) then {
    private _playerCount = {side group _x == playerSide} count (allUnits + allDeadMen); // TODO use allPlayers when no AI needed
    _availableSquadCount = _availableSquadCount min (_playerCount / _requiredPlayers);
};

(floor _availableSquadCount) > 0
