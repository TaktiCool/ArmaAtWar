#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas, NetFusion

    Description:
    Handles unconsciousness

    Parameter(s):
    None

    Returns:
    None
*/
["missionStarted", {
    ["Killed", {
        (_this select 0) params ["_unit", "_killer"];

        private _preventInstantDeath = [QGVAR(Settings_preventInstantDeath), 1] call CFUNC(getSetting);

        // Abort if the respawn button was pressed or unconsciousness
        if (_preventInstantDeath == 0 || (time - (missionNamespace getVariable ["RscDisplayMPInterrupt_respawnTime",-1])) < 1) exitWith {
            [QGVAR(Killed), [CLib_Player, _killer]] call CFUNC(localEvent);
        };

        if (!(CLib_Player getVariable [QGVAR(isUnconscious), false])) then {
            private _gear = [CLib_Player] call CFUNC(saveGear);
            CLib_Player setVariable [QGVAR(killer), _killer];

            [{
                private _corpse = CLib_Player;

                // TODO this may trigger an unwanted respawn event - other modules may reset their variables on respawn
                [getPosASL CLib_Player] call CFUNC(respawn);

                [{
                    params ["_gear", "_corpse"];
                    [_gear, CLib_Player] call CFUNC(restoreGear);
                    CLib_Player setDir getDir _corpse;

                    ["UnconsciousnessChanged", true] call CFUNC(localEvent);

                    deleteVehicle _corpse;
                }, [_this, _corpse]] call CFUNC(execNextFrame);
            }, 3, _gear] call CFUNC(wait);
        } else {
            if (isNull _killer) then {
                _killer = CLib_Player getVariable [QGVAR(killer), objNull];
            };
            [QGVAR(Killed), [CLib_Player, _killer]] call CFUNC(localEvent);
        };
    }] call CFUNC(addEventHandler);
}] call CFUNC(addEventHandler);

// Reset values on death
[QGVAR(Killed), {
    (_this select 0) params ["_unit"];

    ["UnconsciousnessChanged", false] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

["UnconsciousnessChanged", {
    (_this select 0) params ["_state"];

    CLib_Player setVariable [QGVAR(isUnconscious), _state, true];
    [_state] call CFUNC(disableUserInput);

    if (_state) then {
        if (vehicle CLib_Player != CLib_Player) then {
            moveOut CLib_Player;
        };

        // TODO check if this is possible after ragdoll
        if ((animationState CLib_Player) in ["ladderriflestatic", "laddercivilstatic"]) then {
            CLib_Player action ["ladderOff", nearestBuilding CLib_Player];
        };

        private _currentAnimationState = animationState CLib_Player;
        CLib_Player setVariable [QGVAR(oldAnimationState), _currentAnimationState];

        if (vehicle CLib_Player == CLib_Player) then {
            ["switchMove", [CLib_Player, "acts_InjuredLyingRifle02"]] call CFUNC(globalEvent);
        } else {
            private _animationConfig = configFile >> "CfgMovesMaleSdr" >> "States" >> _currentAnimationState;
            if (isArray (_animationConfig >> "interpolateTo")) then {
                CLib_Player playMoveNow (getArray (_animationConfig >> "interpolateTo") select 0);
            };
        };
    } else {
        CLib_Player setVariable [QGVAR(unconsciousTimer), 0];

        if (vehicle CLib_Player == CLib_Player) then {
            if (animationState CLib_Player == "AinjPpneMstpSnonWrflDnon") then {
                CLib_Player playMoveNow "AinjPpneMstpSnonWrflDnon_rolltofront";
                CLib_Player playMove "amovppnemstpsnonwnondnon";
            } else {
                CLib_Player playMoveNow "amovppnemstpsnonwnondnon";
            };
        } else {
            private _originalAnimationState = CLib_Player getVariable [QGVAR(oldAnimationState), ""];
            CLib_Player playMoveNow _originalAnimationState;
        };
    };

}] call CFUNC(addEventHandler);


/*
 * UI STUFF
 */
// Visual effect unconscious
GVAR(unconsciousPPEffects) = [
    ["colorCorrections", 1632, [1, 1, 0.15, [0.3, 0.3, 0.3, 0], [0.3, 0.3, 0.3, 0.3], [1, 1, 1, 1]]] call CFUNC(createPPEffect),
    ["colorCorrections", 1633, [1, 1, 0, [0.15, 0, 0, 1], [1.0, 0.5, 0.5, 1], [0.587, 0.199, 0.114, 0], [1, 1, 0, 0, 0, 0.2, 1]]] call CFUNC(createPPEffect),
    ["dynamicBlur", 525, [0]] call CFUNC(createPPEffect)
];

// Unconscious timer
GVAR(unconsciousPFH) = -1;
["UnconsciousnessChanged", {
    (_this select 0) params ["_state"];

    if (_state) then {
        ([UIVAR(BleedOutProgress)] call bis_fnc_rscLayer) cutRsc [UIVAR(BleedOutProgress), "PLAIN", 0];
        private _display = uiNamespace getVariable [UIVAR(BleedOutProgress), displayNull];

        (_display displayCtrl 3003) ctrlSetStructuredText parseText "YOU ARE UNCONSCIOUS AND BLEEDING";
        (_display displayCtrl 3004) ctrlSetStructuredText parseText "Wait for help or respawn ...";

        if (GVAR(unconsciousPFH) == -1) then {
            GVAR(unconsciousPFH) = [{
                params ["_display", "_id"];

                private _unconsciousTimer = CLib_Player getVariable [QGVAR(unconsciousTimer), 0];
                private _unconsciousDuration = [QGVAR(Settings_unconsciousDuration), 100] call CFUNC(getSetting);

                private _progressPercentage = 1 - (_unconsciousTimer / _unconsciousDuration);

                if (_progressPercentage > 0.99) then {
                    {
                        _x ppEffectEnable false;
                        nil
                    } count GVAR(unconsciousPPEffects);
                } else {
                    private _bright = 0.2 + (0.1 * _progressPercentage);
                    private _intense = 0.6 + (0.4 * _progressPercentage);

                    {
                        _effect = GVAR(unconsciousPPEffects) select _forEachIndex;
                        _effect ppEffectEnable true;
                        _effect ppEffectAdjust _x;
                        _effect ppEffectCommit 1;
                    } forEach [
                        [1, 1, 0.15 * _progressPercentage, [0.3, 0.3, 0.3, 0], [_bright, _bright, _bright, _bright], [1, 1, 1, 1]],
                        [1, 1, 0, [0.15, 0, 0, 1], [1.0, 0.5, 0.5, 1], [0.587, 0.199, 0.114, 0], [_intense, _intense, 0, 0, 0, 0.2, 1]],
                        [0.7 + (1 - _progressPercentage)]
                    ];
                };

                (_display displayCtrl 3002) progressSetPosition _progressPercentage;
            }, 0, _display] call CFUNC(addPerFrameHandler);
        };
    } else {
        ([UIVAR(BleedOutProgress)] call BIS_fnc_rscLayer) cutFadeOut 0;
        GVAR(unconsciousPFH) call CFUNC(removePerFrameHandler);
        GVAR(unconsciousPFH) = -1;
        {
            _x ppEffectEnable false;
            nil
        } count GVAR(unconsciousPPEffects);
    };
}] call CFUNC(addEventHandler);

["isNotUnconscious", {
    !(_caller getVariable [QGVAR(isUnconscious), false]) &&
    !(_target getVariable [QGVAR(isUnconscious), false])
}] call CFUNC(addCanInteractWith);
