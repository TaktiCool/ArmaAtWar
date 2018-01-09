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
    ["PLEASE WAIT", format [MLOC(waitToSwitchSide), floor ((GVAR(lastTimeSideChanged) + GVAR(minSideSwitchTime)) - serverTime)]] call MFUNC(displayHint);
    false
};

private _newSideCount = _newSide countSide allPlayers;
private _oldSideCount = _oldSide countSide allPlayers;

if (_oldSideCount < (_newSideCount + MGVAR(maxPlayerCountDifference))) exitWith {
    ["SIDE BALANCING", MLOC(MaxPlayerCount)] call MFUNC(displayHint);
    false
};

GVAR(lastTimeSideChanged) = serverTime;
true
