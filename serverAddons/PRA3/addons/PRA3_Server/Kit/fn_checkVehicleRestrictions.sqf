#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Check if current vehicle position is usable.

    Parameter(s):
    0: possible old position where the player gets moved

    Returns:
    None
*/
params [["_oldVehicleRole", [""]]];

private _vehicle = vehicle CLib_Player;
private _newPosition = (assignedVehicleRole CLib_Player) select 0;

// Cargo is always allowed
if (_newPosition == "cargo") exitWith {};

// Read the player settings
private _currentKitName = CLib_Player getVariable [QGVAR(kit), ""];
private _kitDetails = [_currentKitName, [["isCrew", 0], ["isPilot", 0]]] call FUNC(getKitDetails);
_kitDetails params ["_isCrew", "_isPilot"];

// Tanks and Air turrets require crew and air driver requires pilot
if (((_vehicle isKindOf "Tank" || _vehicle isKindOf "Wheeled_APC_F") && _isCrew == 0) || (_vehicle isKindOf "Air" && ([_isCrew, _isPilot] select (_newPosition == "driver")) == 0) || (_newPosition == "Turret" && isNull (driver _vehicle))) then {
    private _oldPosition = _oldVehicleRole select 0;
    switch (_oldPosition) do {
        case "cargo": {
            moveOut CLib_Player;
            ["moveInCargo", _vehicle, [_vehicle, CLib_Player]] call CFUNC(targetEvent);
        };
        case "driver": {
            moveOut CLib_Player;
            ["moveInDriver", _vehicle, [_vehicle, CLib_Player]] call CFUNC(targetEvent);
        };
        case "Turret": {
            moveOut CLib_Player;
            ["moveInTurret", _vehicle, [_vehicle, CLib_Player, _oldVehicleRole select 1]] call CFUNC(targetEvent);
        };
        default {
            // Use action here to have an animation
            CLib_Player action ["getOut", _vehicle];
        };
    };
    ["You're not allowed to use this vehicle"] call CFUNC(displayNotification);
};
