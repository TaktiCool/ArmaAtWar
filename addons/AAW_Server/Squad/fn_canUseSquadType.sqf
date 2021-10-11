#include "macros.hpp"
/*
    Arma At War - AAW

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
private _prefix = format [QUOTE(PREFIX/CfgGroupTypes/%1/), _squadTypeName];

private _requiredGroups = [_prefix + "requiredGroups", 1] call CFUNC(getSetting);
if (_requiredGroups > 0) then {
    private _groupCount = count allGroups;
    _availableSquadCount = _groupCount / _requiredGroups;
};

private _requiredPlayers = [_prefix + "requiredPlayers", 1] call CFUNC(getSetting);
if (_requiredPlayers > 0) then {
    private _playerCount = count allPlayers; // TODO use allPlayers when no AI needed
    _availableSquadCount = _availableSquadCount min (_playerCount / _requiredPlayers);
};

(floor _availableSquadCount) > 0
