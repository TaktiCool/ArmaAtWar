#include "macros.hpp"
/*
    Arma At War

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

            if (!isNull objectParent CLib_Player && {damage objectParent CLib_Player == 1}) exitWith {
                CLib_Player setUnconscious false;
                CLib_Player setDamage 1;
                GVAR(bleedoutTimer) call CFUNC(removePerFrameHandler);
                GVAR(bleedoutTimer) = -1;
                GVAR(BleedOutEffect) ppEffectEnable false;
                GVAR(BleedOutEffect) ppEffectCommit 1;
            };

            if ((CLib_Player getVariable [QGVAR(reviveAction), ""]) == "") then {

                private _bloodLevel = CLib_Player getVariable [QGVAR(bloodLevel), 1];
                _bloodLevel = _bloodLevel - (CLib_Player getVariable [QGVAR(bleedingRate), 1]) / ([QGVAR(Settings_unconsciousDuration), 500] call CFUNC(getSetting));

                GVAR(BleedOutEffect) ppEffectEnable true;
                GVAR(BleedOutEffect) ppEffectAdjust [1, 1 + 1.5 * ((1 - _bloodLevel) ^ 3), 0, [1.0, 1.0, 1.0, 0], [1.0, 1.0, 1.0, _bloodLevel ^ 2], [0.7, 0.2, 0.1, 0.0]];

                if (_bloodLevel <= 0) then {
                    CLib_Player setUnconscious false;
                    CLib_Player setDamage 1;
                    GVAR(bleedoutTimer) call CFUNC(removePerFrameHandler);
                    GVAR(bleedoutTimer) = -1;
                    GVAR(BleedOutEffect) ppEffectAdjust [1, 1, 0, [1.0, 1.0, 1.0, 0], [1.0, 1.0, 1.0, 1], [0.7, 0.2, 0.1, 0.0]];
                    GVAR(BleedOutEffect) ppEffectEnable false;
                };

                CLib_Player setVariable [QGVAR(bloodLevel), _bloodLevel max 0];

                GVAR(BleedOutEffect) ppEffectCommit 1;
            };
        }, 1] call CFUNC(addPerFrameHandler);
    };

    if (!_state && {alive CLib_Player && {GVAR(bloodRefreshTimer) < 0}}) then {
        GVAR(bloodRefreshTimer) = [{
            private _bloodLevel = CLib_Player getVariable [QGVAR(bloodLevel), 1];
            private _bleedingRate = CLib_Player getVariable [QGVAR(bleedingRate), 0];
            _bloodLevel = _bloodLevel + 1 / ([QGVAR(Settings_bloodRestoreDuration), 300] call CFUNC(getSetting));
            _bleedingRate = _bleedingRate - _bleedingRate / ([QGVAR(Settings_bloodRestoreDuration), 300] call CFUNC(getSetting));

            CLib_Player setVariable [QGVAR(bloodLevel), _bloodLevel min 1];
            CLib_Player setVariable [QGVAR(bleedingRate), _bleedingRate max 0];

            if (_bloodLevel >= 1) exitWith {
                GVAR(bloodRefreshTimer) call CFUNC(removePerFrameHandler);
                GVAR(bloodRefreshTimer) = -1;
                GVAR(BleedOutEffect) ppEffectEnable false;
                GVAR(BleedOutEffect) ppEffectCommit 2;
            };

            if (!alive CLib_Player || (CLib_Player getVariable [QGVAR(isUnconscious), false])) exitWith {
                GVAR(bloodRefreshTimer) call CFUNC(removePerFrameHandler);
                GVAR(bloodRefreshTimer) = -1;
                GVAR(BleedOutEffect) ppEffectEnable false;
                GVAR(BleedOutEffect) ppEffectCommit 2;
            };

            GVAR(BleedOutEffect) ppEffectEnable true;
            GVAR(BleedOutEffect) ppEffectAdjust [1, 1, 0, [1.0, 1.0, 1.0, 0], [1.0, 1.0, 1.0, _bloodLevel ^ 2], [0.7, 0.2, 0.1, 0.0]];
            GVAR(BleedOutEffect) ppEffectCommit 1;
        }, 1] call CFUNC(addPerFrameHandler);
    };

}] call CFUNC(addEventhandler);
