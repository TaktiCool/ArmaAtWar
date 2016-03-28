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
if !(alive PRA3_player) exitWith {};

private _bloodLoss = PRA3_Player getVariable [QGVAR(bloodLoss), 0];
if (_bloodLoss == 0) exitWith {
    if (!isnull (uinamespace getVariable [UIVAR(MedicalProgress), displayNull])) then {
        ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutFadeOut 0;
    };
};
private _bleedOutTime = PRA3_Player getVariable [QGVAR(bleedOutTime), 0];
_bleedOutTime = _bleedOutTime + ((_bloodLoss * CGVAR(deltaTime)) / 2);

// if Player is Uncon check if maxBleedoutTime is reached and than force the player to respawn
if (PRA3_Player getVariable [QGVAR(isUnconscious), false]) then {
    if (isnull (uiNamespace getVariable [UIVAR(MedicalProgress), displayNull])) then {
        ([UIVAR(MedicalProgress)] call bis_fnc_rscLayer) cutRsc [UIVAR(MedicalProgress),"plain", 0];
        private _display =  uiNamespace getVariable [UIVAR(MedicalProgress), displayNull];

        (_display displayCtrl 3003) ctrlSetStructuredText parseText "YOU ARE UNCONSCIOUS AND BLEEDING";
        (_display displayCtrl 3003) ctrlSetFade 0;
        (_display displayCtrl 3003) ctrlCommit 0;

        (_display displayCtrl 3004) ctrlSetStructuredText parseText "Wait for help or respawn ...";
        (_display displayCtrl 3004) ctrlSetFade 0;
        (_display displayCtrl 3004) ctrlCommit 0;

        (_display displayCtrl 3002) progressSetPosition ((GVAR(reviveBleedOutTime) - _bleedOutTime)/GVAR(reviveBleedOutTime));
    } else {
        private _display =  uiNamespace getVariable [UIVAR(MedicalProgress), displayNull];
        (_display displayCtrl 3002) progressSetPosition ((GVAR(reviveBleedOutTime) - _bleedOutTime)/GVAR(reviveBleedOutTime));
    };


    //hintSilent format ["Bleedout Timer: %1, %2; Bloodloss: %3", _bleedOutTime,  GVAR(reviveBleedOutTime) - _bleedOutTime, _bloodLoss]; // @Todo replace with Loadingbarish UI
    if (_bleedOutTime >= GVAR(reviveBleedOutTime)) then {
        ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutFadeOut 0;
        // Force Player to Respawn
        forceRespawn PRA3_Player;
        ["UnconsciousnessChanged", [false, PRA3_Player]] call CFUNC(localEvent);

    };
} else {
    if (!isnull (uiNamespace getVariable [UIVAR(MedicalProgress), displayNull])) then {
        ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutFadeOut 0;
    };
    // if Player is not Uncon chech if maxBleedingTime is reach and than toggle Uncon
    //hintSilent format ["Bleedout Timer: %1, %2; Bloodloss: %3", _bleedOutTime,  GVAR(reviveBleedingTime) - _bleedOutTime, _bloodLoss]; // @Todo replace with Loadingbarish UI
    if (_bleedOutTime >= GVAR(reviveBleedingTime)) then {
        ["UnconsciousnessChanged", [true, PRA3_Player]] call CFUNC(localEvent);
    };
};
[PRA3_Player, QGVAR(bleedOutTime), _bleedOutTime] call CFUNC(setVariablePublic);
