#include "macros.hpp"
/*
    Arma At War

    Author: NetFusion

    Description:
    Fade a control from the closest side to its original position.

    Parameter(s):
    0: IDC of the control <Number>

    Returns:
    None
*/
params ["_control"];

// Place the UI out of the screen to animate it back in
private _initialPosition = ctrlPosition _control;
private _width = _initialPosition select 2;
_control ctrlSetPosition [
    [safeZoneX - _width, safeZoneX + safeZoneW] select ((_initialPosition select 0) + (_width / 2) > 0.5),
    _initialPosition select 1,
    _initialPosition select 2,
    _initialPosition select 3
];
_control ctrlCommit 0;

// Wait one frame for the placements to take effect and animate back to original position
[{
    params ["_control", "_initialPosition"];

    _control ctrlSetPosition _initialPosition;
    _control ctrlSetFade 0;
    _control ctrlCommit 0.5;
}, [_control, _initialPosition]] call CFUNC(execNextFrame);