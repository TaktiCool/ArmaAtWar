#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    Check if the player is Allowed to switch sides

    Parameter(s):
    0: NewSide <Side>
    1: OldSide <Side>

    Returns:
    <Bool> can change side
*/
params ["_newSide", "_oldSide"];

if ((GVAR(lastTimeSideChanged) + GVAR(minSideSwitchTime)) >= serverTime) exitWith {
    ["PLEASE WAIT", format [MLOC(waitToSwitchSide), floor ((GVAR(lastTimeSideChanged) + GVAR(minSideSwitchTime)) - serverTime)]] call EFUNC(Common,displayHint);
    false
};

private _fnc = {
    params ["_side"];
    {_side == side _x} count allPlayers;
};

private _newSideCount = _newSide call _fnc;
private _oldSideCount = _oldSide call _fnc;
if (_oldSideCount < (_newSide + EGVAR(Common,maxPlayerCountDifference))) exitWith {
    ["SIDE BALANCING", MLOC(MaxPlayerCount)] call EFUNC(Common,displayHint);
    false
};

GVAR(lastTimeSideChanged) = serverTime;
true
