#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Init the Cleanup Script on the Server

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(objectStorage) = [];
GVAR(state) = 0;
// Use an OEF EH to check for new garbage every 10 seconds. We pass an empty array as storage parameter.
[{
    GVAR(state) = (GVAR(state) + 1) mod 2;
    if (GVAR(state) == 0) then {

        // Cycle through all units to detect near shells and enqueue them for removal.
        {
            // Cycle through all near shells.
            {
                // If the shell is not queued yet push it on the storage.
                if !(_x getVariable [QCGVAR(noClean), false]) then {
                    if (!(_x getVariable [QGVAR(queued), false])) then {
                        _x setVariable [QGVAR(queued), true];
                        GVAR(objectStorage) pushBack [_x, time];
                    };
                };
                nil
            } count (getPos _x nearObjects ["GrenadeHand", 100]);
            nil
        } count allUnits;

        {
            if !(_x getVariable [QCGVAR(noClean), false]) then {
                if (!(_x getVariable [QGVAR(queued), false])) then {
                    _x setVariable [QGVAR(queued), true];
                    GVAR(objectStorage) pushBack [_x, time];
                };
            };
            nil
        } count allMissionObjects ("WeaponHolder") + allMissionObjects ("GroundWeaponHolder") + allMissionObjects ("WeaponHolderSimulated") + allDead;
    } else {


        // Cycle through the storage and check the time. Removal is done with an animation.
        if !(GVAR(objectStorage) isEqualTo []) then {
            {
                _x params ["_object", "_enqueueTime"];

                // If the time has not passed exit. This assumes all following object are pushed after the current one.
                if (_enqueueTime + 120 > time) exitWith {};
                if !(_object getVariable [QCGVAR(noClean), false]) then {

                    // Remove the object from the storage.
                    GVAR(objectStorage) deleteAt (GVAR(objectStorage) find _x);
                    // Disable collision with the surface.
                    _object enableSimulationGlobal false;

                    // Calculate the height of the object to determine whether its below surface.
                    private _boundingBox = boundingBox _object;
                    private _height = ((_boundingBox select 1) select 2) - ((_boundingBox select 0) select 2);

                    // Use an OEF EH to move the object slowly below the surface.
                    //@todo make this optional cause it should not be visible in general.
                    [{
                        params ["_object"];
                        deleteVehicle _object;
                    }, {
                        params ["_object", "_height", "_position"];

                        // Get the current position and subtract some value from the z axis.
                        _position set [2,  (_position select 2) - 0.05];

                        // Apply the position change.
                        _object setPos _position;

                        (_position select 2) < (0 - _height)
                    }, [_object, _height, getPos _object]] call CFUNC(waitUntil);
                } else {
                    GVAR(objectStorage) deleteAt (GVAR(objectStorage) find _x);
                };
                nil
            } count +GVAR(objectStorage);
        };
    };

    // Remove empty groups.
    {
        if !(_x getVariable [QCGVAR(noClean), false]) then {
            if ((units _x) isEqualTo []) then {
                deleteGroup _x;
            };
        };
        nil
    } count allGroups;
}, 0] call CFUNC(addPerFrameHandler);
