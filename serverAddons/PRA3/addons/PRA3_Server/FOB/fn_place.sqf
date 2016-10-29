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

    private _position = CLib_Player modelToWorld [0,1,0]; // [CLib_Player modelToWorld [0,1,0], 2] call CFUNC(findSavePosition);
    if (CLib_Player distance _position >= 20) exitWith {
        ["You can not place a FOB at this position"] call EFUNC(Common,displayNotification);
    };

    private _pointObjects = getArray (missionConfigFile >> QPREFIX >> "Sides" >> (str playerSide) >> "FOBObjects");
    _pointObjects = _pointObjects apply {
        _x params ["_type", "_offset"];

        private _objPosition = _position vectorAdd _offset;
        private _obj = createVehicle [_type, _position, [], 0, "CAN_COLLIDE"];
        _obj setPosASL ([_position select 0, _position select 1, (getTerrainHeightASL _objPosition)] vectorAdd _offset);
        _obj setVectorUp (surfaceNormal (getPos _obj));
        _obj setVariable ["isDragable", 0, true];

        clearWeaponCargoGlobal _obj;
        clearMagazineCargoGlobal _obj;
        clearItemCargoGlobal _obj;
        clearBackpackCargoGlobal _obj;

        ["enableSimulation", [_obj, false]] call CFUNC(serverEvent);
        ["blockDamage", [_obj, true], true] call CFUNC(globalEvent);

        _obj
    };

    deleteVehicle _target;

    private _text = [_position] call EFUNC(Common,getNearestLocationName);
    private _pointId = ["FOB " + _text, _position, playerSide, -1, "ui\media\fob_ca.paa", "ui\media\fob_ca.paa", _pointObjects] call EFUNC(Common,addDeploymentPoint);

    (_pointObjects select 0) setVariable [QGVAR(pointId), _pointId, true];
    (_pointObjects select 0) setVariable [QGVAR(side), playerSide, true];
    ["enableSimulation", [_pointObjects select 0, true]] call CFUNC(serverEvent); // TODO this is only for the take down action

    ["displayNotification", playerSide, [format[MLOC(FOBPlaced), groupId (group CLib_Player), _text]]] call CFUNC(targetEvent);
}, [_target], "respawn"] call CFUNC(mutex);
