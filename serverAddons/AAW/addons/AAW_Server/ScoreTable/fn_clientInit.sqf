#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Client Init for ScoreTable System

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(ppBlur) = ppEffectCreate ["DynamicBlur", 999];
GVAR(ppColor) = ppEffectCreate ["colorCorrections", 1501];




["showScoreTable", {
    private _display = (findDisplay 46) createDisplay "RscDisplayEmpty";


    _display displayAddEventHandler ["KeyDown",  {
        params ["_display", "_dikCode", "_shift", "_ctrl", "_alt"];
        private _handled = false;
        if (_dikCode in actionKeys "networkStats" || _dikCode == 1) then {
            _display closeDisplay 1;
            _handled = true;
        };
        _handled;
    }];

    _display displayAddEventHandler ["Unload",  {
        params ["_display", "_exitCode"];
        GVAR(ppColor) ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [0.7, 0.2, 0.1, 0.0]];
        GVAR(ppColor) ppEffectCommit 0.3;
        GVAR(ppBlur) ppEffectAdjust [0];
        GVAR(ppBlur) ppEffectCommit 0.3;

    }];

    



    GVAR(ppColor) ppEffectEnable true;
    GVAR(ppColor) ppEffectAdjust [0.7, 0.7, 0.1, [0, 0, 0, 0], [1, 1, 1, 1], [0.7, 0.2, 0.1, 0.0]];
    GVAR(ppColor) ppEffectCommit 0.3;

    GVAR(ppBlur) ppEffectAdjust [8];
    GVAR(ppBlur) ppEffectEnable true;
    GVAR(ppBlur) ppEffectCommit 0.3;

}] call CFUNC(addEventhandler);

["missionStarted", {
    (findDisplay 46) displayAddEventHandler ["KeyDown",  {
        params ["_display", "_dikCode", "_shift", "_ctrl", "_alt"];
        private _handled = false;
        if (_dikCode in actionKeys "networkStats" && !_shift && !_alt && !_ctrl) then {
            ["showScoreTable"] call CFUNC(localEvent);
            _handled = true;
        };
        _handled;
    }];
}] call CFUNC(addEventhandler);
