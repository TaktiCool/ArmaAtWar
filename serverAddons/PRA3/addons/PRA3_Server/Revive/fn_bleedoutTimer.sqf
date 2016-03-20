#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Bleedout Timer PFH

    Parameter(s):
    PFH Return

    Returns:
    None
*/

if (PRA3_player getVariable [QGVAR(medicalActionIsInProgress), false]) exitWith {};
private _bloodLoss = PRA3_Player getVariable [QGVAR(bloodLoss), 0];
if (_bloodLoss == 0) exitWith {};
private _bleedOutTime = PRA3_Player getVariable [QGVAR(bleedOutTime), 0];

_bleedOutTime = _bleedOutTime + ((_bloodLoss * CGVAR(deltaTime)) / 2);

[PRA3_Player, QGVAR(bleedOutTime), _bleedOutTime] call CFUNC(setVariablePublic);

// if Player is Uncon check if maxBleedoutTime is reached and than force the player to respawn
if (PRA3_Player getVariable [QGVAR(isUnconscious), false]) then {
    if (_bleedOutTime >= GVAR(reviveBleedOutTime)) then {
        // Force Player to Respawn
        forceRespawn PRA3_Player;
    };
} else {
    // if Player is not Uncon chech if maxBleedingTime is reach and than toggle Uncon
    if (_bleedOutTime >= GVAR(reviveBleedingTime)) then {
        PRA3_Player setVariable [QGVAR(bleedOutTime), 0, true];
        PRA3_Player setVariable [QGVAR(isUnconscious), false, true];
        ["UnconsciousnessChanged", [false, PRA3_Player]] call CFUNC(localEvent);
    };
};
