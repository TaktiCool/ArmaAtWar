#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    place rally

    Parameter(s):
    None

    Returns:
    None
*/
[{
    if (!(call FUNC(canPlaceRally))) exitWith {};

    [group PRA3_Player] call FUNC(destroyRally);

    private _position = [PRA3_Player modelToWorld [0,1,0], 2] call CFUNC(findSavePosition);

    private _squadRallyPointObjects = getArray (missionConfigFile >> "PRA3" >> "Sides" >> (str playerSide) >> "squadRallyPointObjects");
    _squadRallyPointObjects = _squadRallyPointObjects apply {
        _x params ["_type", "_offset"];

        private _objPosition = _position vectorAdd _offset;
        private _obj = createVehicle [_type, _objPosition, [], 0, "CAN_COLLIDE"];
        _obj setPosASL [_objPosition select 0, _objPosition select 1, (getTerrainHeightASL _objPosition)];
        _obj setVectorUp (surfaceNormal (getPos _obj));
        ["enableSimulation", [_obj, false]] call CFUNC(serverEvent);

        _obj
    };

    (group PRA3_Player) setVariable [QGVAR(lastRallyPlaced), serverTime, true];

    private _spawnCount = [QGVAR(Rally_spawnCount), 1] call CFUNC(getSetting);
    private _pointId = ["RALLYPOINT " + (toUpper groupId group PRA3_Player), "ui\media\rally_ca.paa", _spawnCount, _position, {group PRA3_Player == _this}, group PRA3_Player, _squadRallyPointObjects] call FUNC(addDeploymentPoint);
    (group PRA3_Player) setVariable [QGVAR(rallyId), _pointId, true];

    ["displayNotification", group PRA3_Player, [format["Your Team Leader Placed a Rally Near %1", [_position] call CFUNC(getNearestLocationName)]]] call CFUNC(targetEvent);
    [UIVAR(RespawnScreen_DeploymentManagement_update), group PRA3_Player] call CFUNC(targetEvent);
    [QGVAR(updateMapIcons), group PRA3_Player] call CFUNC(targetEvent);
}] call CFUNC(mutex);