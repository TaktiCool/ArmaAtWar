#include "macros.hpp"
/*
    Project Reality ArmA 3

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

    private _position = position _target; // [CLib_Player modelToWorld [0,1,0], 2] call CFUNC(findSavePosition);
    private _dirVector = vectorDirVisual CLib_Player;
    if (CLib_Player distance _position >= 20) exitWith {
        ["You can not place a FOB at this position"] call EFUNC(Common,displayNotification);
    };

    private _composition = getText (missionConfigFile >> QPREFIX >> "Sides" >> (str playerSide) >> "FOBComposition");


    deleteVehicle _target;
    private _pointObjects = [_composition, _position, _dirVector, _target] call CFUNC(createSimpleObjectComp);

    private _text = [_position] call EFUNC(Common,getNearestLocationName);
    private _pointId = ["FOB " + _text, "FOB", _position, playerSide, -1, "ui\media\fob_ca.paa", "ui\media\fob_ca.paa", _pointObjects] call EFUNC(Common,addDeploymentPoint);

    (_pointObjects select 0) setVariable [QGVAR(pointId), _pointId, true];
    (_pointObjects select 0) setVariable [QGVAR(side), playerSide, true];
    ["enableSimulation", [_pointObjects select 0, true]] call CFUNC(serverEvent); // TODO this is only for the take down action

    [QGVAR(placed), _pointId] call CFUNC(globalEvent);

    ["displayNotification", playerSide, [format[MLOC(FOBPlaced), groupId (group CLib_Player), _text]]] call CFUNC(targetEvent);
}, [_target], "respawn"] call CFUNC(mutex);
