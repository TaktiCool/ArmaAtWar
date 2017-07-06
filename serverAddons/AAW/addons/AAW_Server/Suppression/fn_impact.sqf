#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas & LAxemann

    Description:
    Changes PP Effects and add a CamShake

    Parameter(s):
    None

    Returns:
    None
*/
if !(alive player) exitWith {};
if (((vehicle player) == player) || (isTurnedOut player)) then {

    GVAR(impactBlur) ppEffectAdjust [0.015, 0.015, 0.2, 0.2];
    GVAR(impactBlur) ppEffectCommit 0;
    GVAR(impactCC) ppEffectAdjust [1, 1, 0, [0,0,0,0.4], [1,1,1,1],[1,1,1,0]];
    GVAR(impactCC) ppEffectCommit 0;

    GVAR(impactBlur) ppEffectAdjust [0, 0, 0, 0];
    GVAR(impactBlur) ppEffectCommit 0.5;
    GVAR(impactCC) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
    GVAR(impactCC) ppEffectCommit 0.25;

    // Makes the player twitch if it's been a while since he was getting shot at
    if ((time - GVAR(lastShotAt)) >= 120) then {
        addCamShake [3,0.4, 80];
    };
};
