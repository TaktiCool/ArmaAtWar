#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Place rally

    Parameter(s):
    None

    Returns:
    None
*/
[{
    if (!(call FUNC(canPlace))) exitWith {};

    private _position = CLib_Player modelToWorld [0,1,0]; // [CLib_Player modelToWorld [0,1,0], 2] call CFUNC(findSavePosition);
    if (CLib_Player distance _position >= 20) exitWith {
        [MLOC(cantPlaceRally)] call EFUNC(Common,displayNotification);
    };

    [group CLib_Player] call FUNC(destroy);

    private _pointObjects = getArray (missionConfigFile >> QPREFIX >> "Sides" >> (str playerSide) >> "squadRallyPointObjects");
    _pointObjects = _pointObjects apply {
        _x params ["_type", "_offset"];

        private _objPosition = _position vectorAdd _offset;
        private _obj = createVehicle [_type, _objPosition, [], 0, "CAN_COLLIDE"];
        _obj setPosASL [_objPosition select 0, _objPosition select 1, (getTerrainHeightASL _objPosition)];
        _obj setVectorUp (surfaceNormal (getPos _obj));
        ["enableSimulation", [_obj, false]] call CFUNC(serverEvent);

        _obj
    };

    (group CLib_Player) setVariable [QGVAR(lastRallyPlaced), serverTime, true];
    private _text = [_position] call EFUNC(Common,getNearestLocationName);
    private _spawnCount = [QGVAR(Rally_spawnCount), 1] call CFUNC(getSetting);
    private _pointId = [_text, _position, group CLib_Player, _spawnCount, "ui\media\rally_ca.paa", "ui\media\rally_ca.paa", _pointObjects] call EFUNC(Common,addPoint);
    (group CLib_Player) setVariable [QGVAR(rallyId), _pointId, true];

    ["displayNotification", group CLib_Player, [format[MLOC(RallyPlaced), _text]]] call CFUNC(targetEvent);
}, [], "respawn"] call CFUNC(mutex);
