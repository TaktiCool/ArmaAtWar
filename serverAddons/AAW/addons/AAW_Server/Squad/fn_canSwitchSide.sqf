#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas

    Description:
    Check if the player is Allowed to switch sides

    Parameter(s):
    0: NewSide <Side> (Default: sideUnknown)
    1: OldSide <Side> (Default: sideUnknown)

    Returns:
    <Bool> can change side
*/

params [
    ["_newSide", sideUnknown, [sideUnknown]],
    ["_oldSide", sideUnknown, [sideUnknown]]
];

if ((GVAR(lastTimeSideChanged) + GVAR(restirctSideSwitchRestrictionTime)) >= serverTime) exitWith {
    [format [MLOC(waitToSwitchSide), (GVAR(lastTimeSideChanged) + GVAR(restirctSideSwitchRestrictionTime)) - serverTime]] call EFUNC(Common,displayNotification);
    false
};

private _fnc = {
    params ["_side"];
    {_side == side _x} count allPlayers;
};

private _newSideCount = _newSide call _fnc;
private _oldSideCount = _oldSide call _fnc;
if (_oldSideCount < (_newSide + GVAR(restirctSideSwitchRestrictionCount))) exitWith {
    [MLOC(MaxPlayerCount)] call EFUNC(Common,displayNotification);
    false
};

GVAR(lastTimeSideChanged) = serverTime;
true
