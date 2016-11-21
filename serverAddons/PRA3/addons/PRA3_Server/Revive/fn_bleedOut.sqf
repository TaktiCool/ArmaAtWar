#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Handles the bleedout timer when unconscious

    Parameter(s):
    -

    Returns:
    -
*/
GVAR(bleedoutTimer) = -1;

GVAR(BleedOutEffect) = ppEffectCreate ["colorCorrections", 1501];
GVAR(BleedOutEffect) ppEffectEnable false;

GVAR(BleedOutEffect) = _hndl;

GVAR(bloodRefreshTimer) = -1;
["unconsciousnessChanged", {
    (_this select 0) params ["_state"];

    if (_state && {GVAR(bleedoutTimer) < 0}) then {

        GVAR(bleedoutTimer) = [{
            if (!alive CLib_Player || !(CLib_Player getVariable [QGVAR(isUnconscious), false])) exitWith {
                GVAR(bleedoutTimer) call CFUNC(removePerFrameHandler);
                GVAR(bleedoutTimer) = -1;
                GVAR(BleedOutEffect) ppEffectEnable false;
                GVAR(BleedOutEffect) ppEffectCommit 1;
            };

            if (CLib_Player != vehicle CLib_Player && {damage vehicle CLib_Player == 1}) exitWith {
                CLib_Player setUnconscious false;
                CLib_Player setDamage 1;
                GVAR(bleedoutTimer) call CFUNC(removePerFrameHandler);
                GVAR(bleedoutTimer) = -1;
                GVAR(BleedOutEffect) ppEffectEnable false;
                GVAR(BleedOutEffect) ppEffectCommit 1;
            };

            if ((CLib_Player getVariable [QGVAR(reviveAction),""]) == "") then {
                private _bloodLevel = CLib_Player getVariable [QGVAR(bloodLevel), 1];

                _bloodLevel = _bloodLevel - (CLib_Player getVariable [QGVAR(bleedingRate), 1])/([QGVAR(Settings_unconsciousDuration), 500] call CFUNC(getSetting));



                if (_bloodLevel <= 0) then {
                    CLib_Player setUnconscious false;
                    CLib_Player setDamage 1;
                    GVAR(bleedoutTimer) call CFUNC(removePerFrameHandler);
                    GVAR(bleedoutTimer) = -1;
                };

                CLib_Player setVariable [QGVAR(bloodLevel), _bloodLevel max 0];
            };

            GVAR(BleedOutEffect) ppEffectEnable true;
            GVAR(BleedOutEffect) ppEffectAdjust [1, 1+10*(1-_bloodLevel), 0, [1.0, 1.0, 1.0, 0], [(1-_bloodLevel), (1-_bloodLevel), (1-_bloodLevel), 0], [0.7, 0.2, 0.1, 0.0]];
            GVAR(BleedOutEffect) ppEffectCommit 1;
        }, 1] call CFUNC(addPerFrameHandler);
    };

    if (!_state && {alive CLib_Player && {GVAR(bloodRefreshTimer) < 0}}) then {
        GVAR(bloodRefreshTimer) = [{
            private _bloodLevel = CLib_Player getVariable [QGVAR(bloodLevel), 1];
            private _bleedingRate = CLib_Player getVariable [QGVAR(bleedingRate), 0];
            _bloodLevel = _bloodLevel + 1/([QGVAR(Settings_bloodRestoreDuration), 300] call CFUNC(getSetting));
            _bleedingRate = _bleedingRate - _bleedingRate/([QGVAR(Settings_bloodRestoreDuration), 300] call CFUNC(getSetting));

            CLib_Player setVariable [QGVAR(bloodLevel), _bloodLevel min 1];
            CLib_Player setVariable [QGVAR(bleedingRate), _bleedingRate max 0];



            if (_bloodLevel >= 1) exitWith {
                GVAR(bloodRefreshTimer) call CFUNC(removePerFrameHandler);
                GVAR(bloodRefreshTimer) = -1;
                GVAR(BleedOutEffect) ppEffectEnable false;
                GVAR(BleedOutEffect) ppEffectCommit 1;
            };

            if (!alive CLib_Player || (CLib_Player getVariable [QGVAR(isUnconscious), false])) exitWith {
                GVAR(bloodRefreshTimer) call CFUNC(removePerFrameHandler);
                GVAR(bloodRefreshTimer) = -1;
                GVAR(BleedOutEffect) ppEffectEnable false;
                GVAR(BleedOutEffect) ppEffectCommit 1;
            };

            GVAR(BleedOutEffect) ppEffectEnable true;
            GVAR(BleedOutEffect) ppEffectAdjust [1, 1, 0, [1.0, 1.0, 1.0, 0], [(1-_bloodLevel), (1-_bloodLevel), (1-_bloodLevel), 0], [0.7, 0.2, 0.1, 0.0]];
            GVAR(BleedOutEffect) ppEffectCommit 1;
        }, 1] call CFUNC(addPerFrameHandler);
    };

}] call CFUNC(addEventhandler);


/*
 * UI STUFF
 */
// Visual effect unconscious
GVAR(unconsciousPPEffects) = [
    ["colorCorrections", 1632, [1, 1, 0.15, [0.3, 0.3, 0.3, 0], [0.3, 0.3, 0.3, 0.3], [1, 1, 1, 1]]] call CFUNC(createPPEffect),
    ["colorCorrections", 1633, [1, 1, 0, [0.15, 0, 0, 1], [1.0, 0.5, 0.5, 1], [0.587, 0.199, 0.114, 0], [1, 1, 0, 0, 0, 0.2, 1]]] call CFUNC(createPPEffect),
    ["dynamicBlur", 525, [0]] call CFUNC(createPPEffect)
];
/*
// Unconscious timer
GVAR(unconsciousPFH) = -1;
["unconsciousnessChanged", {
    (_this select 0) params ["_state"];

    if (_state) then {

        if (GVAR(unconsciousPFH) == -1) then {
            GVAR(unconsciousPFH) = [{
                params ["_dummy", "_id"];

                if (!alive CLib_Player || !(CLib_Player getVariable [QGVAR(isUnconscious), false])) exitWith {
                    GVAR(unconsciousPFH) call CFUNC(removePerFrameHandler);
                    GVAR(unconsciousPFH) = -1;
                    {
                        _x ppEffectEnable false;
                        nil
                    } count GVAR(unconsciousPPEffects);
                };


                private _progressPercentage = 1 - (CLib_Player getVariable [QGVAR(bloodLevel), 0]);

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

            }, 0] call CFUNC(addPerFrameHandler);
        };
    };
}] call CFUNC(addEventHandler);
*/
