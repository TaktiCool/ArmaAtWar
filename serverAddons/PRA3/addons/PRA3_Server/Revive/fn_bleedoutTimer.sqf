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

// if Player is Uncon check if maxBleedoutTime is reached and than force the player to respawn
if (PRA3_Player getVariable [QGVAR(isUnconscious), false]) then {
    hintSilent format ["Bleedout Timer: %1, %2; Bloodloss: %3", _bleedOutTime,  GVAR(reviveBleedOutTime) - _bleedOutTime, _bloodLoss]; // @Todo replace with Loadingbarish UI
    if (_bleedOutTime >= GVAR(reviveBleedOutTime)) then {
        // Force Player to Respawn
        PRA3_Player setVariable [QGVAR(bloodLoss), 0];
        PRA3_Player setVariable [QGVAR(isUnconscious), false, true];
        forceRespawn PRA3_Player;
    };
} else {
    // if Player is not Uncon chech if maxBleedingTime is reach and than toggle Uncon
    hintSilent format ["Bleedout Timer: %1, %2; Bloodloss: %3", _bleedOutTime,  GVAR(reviveBleedingTime) - _bleedOutTime, _bloodLoss]; // @Todo replace with Loadingbarish UI
    if (_bleedOutTime >= GVAR(reviveBleedingTime)) then {
        PRA3_Player setVariable [QGVAR(bleedOutTime), 0, true];
        PRA3_Player setVariable [QGVAR(isUnconscious), false, true];
        ["UnconsciousnessChanged", [true, PRA3_Player]] call CFUNC(localEvent);
    };
};
[PRA3_Player, QGVAR(bleedOutTime), _bleedOutTime] call CFUNC(setVariablePublic);
