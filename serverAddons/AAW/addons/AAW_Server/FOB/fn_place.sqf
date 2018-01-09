#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Place FOB

    Parameter(s):
    None

    Returns:
    None
*/
params ["_target"];

[{
    params ["_target"];

    if (!(call FUNC(canPlace))) exitWith {};

    private _position = _target modelToWorld [0, 0, 0];
    private _dirVector = vectorDirVisual CLib_Player;
    if (CLib_Player distance _position >= 20) exitWith {
        ["FOB NOT PLACABLE", "Not enough space available!"] call MFUNC(displayHint);
    };

    private _composition = getText (missionConfigFile >> QPREFIX >> "Sides" >> (str playerSide) >> "FOBComposition");

    deleteVehicle _target;
    private _pointObjects = [_composition, _position, _dirVector, _target] call CFUNC(createSimpleObjectComp);

    private _text = [_position] call MFUNC(getNearestLocationName);
    private _pointId = ["FOB " + _text, "FOB", _position, playerSide, -1, "A3\ui_f\data\map\markers\military\triangle_ca.paa", "A3\ui_f\data\map\markers\military\triangle_ca.paa", _pointObjects] call MFUNC(addDeploymentPoint);

    ["displayNotification", side group CLib_player, [
        "NEW FOB PLACED",
        "near " + _text,
        [["A3\ui_f\data\map\respawn\respawn_background_ca.paa", 1, [0, 0.4, 0.8, 1],1],["A3\ui_f\data\map\markers\military\triangle_ca.paa", 0.8]]
    ]] call CFUNC(targetEvent);

    [_pointId, "spawnPointLocked", 1] call MFUNC(setDeploymentPointData);
    [_pointId, "spawnPointBlocked", 0] call MFUNC(setDeploymentPointData);
    [_pointId, "spawnTime", serverTime + ([CFGFOB(waitTimeAfterPlacement), 300] call CFUNC(getSetting))] call MFUNC(setDeploymentPointData);

    [QGVAR(placed), _pointId] call CFUNC(globalEvent);
}, [_target], "respawn"] call CFUNC(mutex);
