#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    check if Rally is Placeable

    Parameter(s):
    0: Unit that will Place the Rally <Object>

    Returns:
    is Rally Placeable <Bool>
*/
params ["_unit"];
if (isNull _unit) exitWith {};
scopeName "Main";
GVAR(rallyArray) params ["_minDistance","_spawnCount"];
private _playerSide = str(side group _unit);
{
    if (toLower(_x select 0) isEqualTo toLower(_playerSide)) then {
        if ((_unit distance (_x select 1)) >= _minDistance) then {
            false breakOut "Main";
        };
    };
    nil
} count GVAR(respawnPositions);

private _count = {
    if (toLower(str(side player)) != toLower(_playerSide)) then {
        false breakOut "Main";
    };
    true
} count (nearestObjects [_unit, ["CAManBase"], 10]);

_count >= (GVAR(rallyArray) select 3)
