#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Unregisters a Map Control for Map Icon Drawing

    Parameter(s):
    0: Map <Control>

    Remarks:
    None

    Returns:
    None
*/
disableSerialization;
params ["_map"];
with uiNamespace do {
    private _idx = GVAR(MapIconMapControls) find _map;
};
if (_idx >= 0) then {
    private _drawId = _map getVariable [QGVAR(DrawEHId), -1];
    private _mmId = _map getVariable [QGVAR(MouseMovingEHId), -1];
    private _mcId = _map getVariable [QGVAR(MouseButtonClickEHId), -1];
    _map ctrlRemoveEventHandler ["Draw", _drawId];
    _map ctrlRemoveEventHandler ["MouseMoving", _mmId];
    _map ctrlRemoveEventHandler ["MouseButtonClick", _mcId];
    with uiNamespace do {
        GVAR(MapIconMapControls) deleteAt _idx;
    };
};
