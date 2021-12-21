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
    [MLOC(pleaseWait), format [MLOC(waitToSwitchSide), floor ((GVAR(lastTimeSideChanged) + GVAR(minSideSwitchTime)) - serverTime)]] call CFUNC(displayHint);
    false
};

private _newSideCount = _newSide countSide allPlayers;
private _oldSideCount = _oldSide countSide allPlayers;

if (_oldSideCount < (_newSideCount + EGVAR(Common,maxPlayerCountDifference))) exitWith {
    [MLOC(SIDEBALANCING), MLOC(MaxPlayerCount)] call CFUNC(displayHint);
    false
};

GVAR(lastTimeSideChanged) = serverTime;
true
