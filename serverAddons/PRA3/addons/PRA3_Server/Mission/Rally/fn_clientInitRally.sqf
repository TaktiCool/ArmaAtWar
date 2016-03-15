#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Init for Rally System for Leaders

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(Rally), missionConfigFile >> "PRA3" >> "CfgSquadRallyPoint"] call CFUNC(loadSettings);

["Create Rally Point", PRA3_Player, 0, {
    [QGVAR(isRallyPlaceable), FUNC(canPlaceRally), [], 5, QGVAR(ClearRallyPlaceable)] call CFUNC(cachedCall);
}, {
    [QGVAR(ClearRallyPlaceable)] call CFUNC(localEvent);

    [{
        if (!(call FUNC(canPlaceRally))) exitWith {};

        private _squadRallyPointObjects = getArray (missionConfigFile >> "PRA3" >> "Sides" >> (str side group PRA3_Player) >> "squadRallyPointObjects");
        private _position = PRA3_Player modelToWorld [0,1,0];

        private _oldRally = (group PRA3_Player) getVariable [QGVAR(rallyPoint), [0, [], [], 0]];
        {
            deleteVehicle _x;
            nil
        } count (_oldRally select 2);

        private _spawnedObjects = [];
        {
            _x params ["_type", "_offset"];
            private _obj = createVehicle [_type, _position, [], 0, "CAN_COLLIDE"];
            _obj setPosASL ([_position select 0, _position select 1, (getTerrainHeightASL _position)] vectorAdd _offset);
            _obj setVectorUp (surfaceNormal (getPos _obj));
            ["enableSimulation", [_obj, false]] call CFUNC(serverEvent);
            _spawnedObjects pushBack _obj;
            nil
        } count _squadRallyPointObjects;

        (group PRA3_Player) setVariable [QGVAR(rallyPoint), [time, _position, _spawnedObjects, [QGVAR(Rally_spawnCount)] call CFUNC(getSetting)], true];
        [QGVAR(rallyPlaced), group PRA3_Player] call CFUNC(serverEvent);
        ["displayNotification", group PRA3_Player, [format["Your Team Leader Placed a Rally Near %1", [getPos PRA3_Player] call CFUNC(getNearestLocationName)], [1,1,1,1]]] call CFUNC(targetEvent);
        [QGVAR(updateDeploymentList), group PRA3_Player] call CFUNC(targetEvent);
    }] call CFUNC(mutex);
}] call CFUNC(addAction);
