#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    0: Squad type name <STRING>

    Returns:
    <BOOL>
*/
params ["_squadTypeName"];

private _availableSquadCount = 1;
private _prefix = format [QGVAR(GroupTypes_%1_), _squadTypeName];

private _requiredGroups = [_prefix + "requiredGroups", 1] call CFUNC(getSetting);
private _groupCount = {side _x == playerSide} count allGroups;
if (_requiredGroups > 0) then {
    _availableSquadCount = _groupCount / _requiredGroups;
};

private _requiredPlayers = [_prefix + "requiredPlayers", 1] call CFUNC(getSetting);
private _playerCount = {side group _x == playerSide} count allUnits;
if (_requiredPlayers > 0) then {
    _availableSquadCount = _availableSquadCount min (_playerCount / _requiredPlayers);
};

(floor _availableSquadCount) > 0