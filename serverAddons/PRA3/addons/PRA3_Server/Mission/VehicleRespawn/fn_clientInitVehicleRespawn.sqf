#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Client Init for Vehicle Respawn System to show Notification

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(vehicleRespawnAvailable), {
    params ["_args"];
    _args params ["_vehicle"];

    private _vehicleConfig = configFile >> "CfgVehicles" >> typeOf _vehicle;
    ["PRA3_VehicleRespawnAvailable", [ getText (_vehicleConfig >> "displayName"), getText (_vehicleConfig >> "picture") ]] call BIS_fnc_showNotification;

}] call CFUNC(addEventHandler);
