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

    if (!(call FUNC(canPlaceFOB))) exitWith {};

    private _position = [PRA3_Player modelToWorld [0,1,0], 2] call CFUNC(findSavePosition);
    if (PRA3_Player distance _position >= 20) exitWith {
        ["You can not place a FOB at this position"] call CFUNC(displayNotification);
    };

    private _pointObjects = getArray (missionConfigFile >> "PRA3" >> "Sides" >> (str playerSide) >> "FOBObjects");
    _pointObjects = _pointObjects apply {
        _x params ["_type", "_offset"];

        private _objPosition = _position vectorAdd _offset;
        private _obj = createVehicle [_type, _objPosition, [], 0, "CAN_COLLIDE"];
        _obj setPosASL [_objPosition select 0, _objPosition select 1, (getTerrainHeightASL _objPosition)];
        _obj setVectorUp (surfaceNormal (getPos _obj));

        ["enableSimulation", [_obj, false]] call CFUNC(serverEvent);

        _obj
    };

    deleteVehicle _target;

    private _text = [_position] call CFUNC(getNearestLocationName);
    private _pointId = ["FOB " + _text, _position, playerSide, -1, "ui\media\fob_ca.paa", "ui\media\fob_ca.paa", _pointObjects] call FUNC(addPoint);

    (_pointObjects select 0) setVariable [QGVAR(pointId), _pointId, true];
    ["enableSimulation", [_pointObjects select 0, true]] call CFUNC(serverEvent); // TODO this is only for the take down action

    ["displayNotification", playerSide, [format["Squad %1 placed a FOB near %2", groupId (group PRA3_Player), _text]]] call CFUNC(targetEvent);
}, [_target], "respawn"] call CFUNC(mutex);
