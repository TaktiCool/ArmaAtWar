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
    private _text = format [MLOC(NewVehicleAvailable),
        format ["<img size='0.7' color='#ffffff' image='%2'/> %1",
            getText (_vehicleConfig >> "displayName"),
            getText (_vehicleConfig >> "picture")
        ]
     ];
     _text call EFUNC(Common,displayNotification);
}] call CFUNC(addEventHandler);

// bug Fix for JIP and VehicleVarName
{
    if (vehicleVarName _entity == "") then {
        private _varName = _entity getVariable [QGVAR(vehicleVarName), ""];
        if (_varName != "") then {
            _entity setVehicleVarName _varName;
        };
    };
    nil
} count (((entities "") - allUnits) + allUnits);
