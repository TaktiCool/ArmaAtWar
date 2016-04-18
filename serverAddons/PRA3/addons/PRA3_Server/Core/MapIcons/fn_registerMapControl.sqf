#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Registers a Map Control for Map Icon Drawing

    Parameter(s):
    0: Map <Control>

    Returns:
    None
*/
disableSerialization;
params ["_map"];
private _exit = false;
// get sure that the controll not allready have a draw function
with uiNamespace do {
    _exit = _map in GVAR(MapIconMapControls);
};

if (_exit) exitWith {nil};
/*
private _drawEHId = _map ctrlAddEventHandler ["Draw", FUNC(drawMapIcons)];
private _mmEHId = _map ctrlAddEventHandler ["MouseMoving", FUNC(mouseMovingEH)];
private _mcEHId = _map ctrlAddEventHandler ["MouseButtonClick", FUNC(mouseClickEH)];

_map setVariable [QGVAR(DrawEHId), _drawEHId];
_map setVariable [QGVAR(MouseMovingEHId), _mmEHId];
_map setVariable [QGVAR(MouseButtonClickEHId), _mcEHId];
*/
with uiNamespace do {
    GVAR(MapIconMapControls) pushBackUnique _map;
};

nil
