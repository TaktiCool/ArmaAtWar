#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    server Init for the Common Module

    Parameter(s):
    None

    Returns:
    None
*/

[{
    private _side1 = GVAR(competingSides) select 0;
    private _side2 = GVAR(competingSides) select 1;
    private _side1Count = _side1 countSide allPlayers;
    private _side2Count = _side2 countSide allPlayers;
    if (_side1Count == _side2Count) exitWith {};

    private _diff = abs ( _side1Count - _side2Count);

    if (_diff < GVAR(maxPlayerCountDifference)) exitWith {};

    ["EVENT", [_side1, _side2] select (_side1Count < _side2Count), [
        "SIDES UNBALANCED",
        "Go Change the Side",
        [["A3\ui_f\data\map\respawn\respawn_background_ca.paa", 1, [0.13, 0.54, 0.21, 1],1],["A3\ui_f\data\map\groupicons\badge_simple.paa", 0.8]] // TODO find Icon
    ]]  call CFUNC(targetEvent);
}, 120] call CFUNC(addPerFrameHandler);
