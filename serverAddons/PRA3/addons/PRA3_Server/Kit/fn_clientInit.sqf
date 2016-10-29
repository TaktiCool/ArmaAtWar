#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Init Kit Module

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(KitGroups), missionConfigFile >> QPREFIX >> "KitGroups"] call CFUNC(loadSettings);
{
    [format [QGVAR(Kit_%1), configName _x], _x >> "Kits"] call CFUNC(loadSettings);
    nil
} count ("true" configClasses (missionConfigFile >> QPREFIX >> "Sides"));

// When the player changes he takes his kit with him.
["playerChanged", {
    (_this select 0) params ["_newPlayer", "_oldPlayer"];
    {
        _newPlayer setVariable [_x, _oldPlayer getVariable _x, true];
    } count [QGVAR(kit), QGVAR(kitDisplayName), QGVAR(kitIcon), QGVAR(MapIcon), QGVAR(isLeader), QGVAR(isMedic), QGVAR(isEngineer), QGVAR(isPilot), QGVAR(isCrew)];
}] call CFUNC(addEventHandler);

// VEHICLE RESTRICTION
{
    [_x, {
        params ["_vehicle", "_id", "_caller", "_actionName"];

        // Players should not be able to board enemy vehicles.
        private _playerSide = str side group CLib_Player;
        private _vehicleSide = _vehicle getVariable ["side", _playerSide];
        if (_vehicleSide != _playerSide) exitWith {
            [MLOC(NotAllowToDrive)] call EFUNC(Common,displayNotification);
            true
        };

        // Everyone can use cargo seats.
        if (_actionName in ["GetInCargo", "MoveToCargo"]) exitWith {
            false
        };

        // Read the player kit settings.
        private _currentKitName = CLib_Player getVariable [QGVAR(kit), ""];
        private _kitDetails = [_currentKitName, [["isCrew", 0], ["isPilot", 0]]] call FUNC(getKitDetails);
        _kitDetails params ["_isCrew", "_isPilot"];

        // Tank and APC require crew.
        if ((_vehicle isKindOf "Tank" || _vehicle isKindOf "Wheeled_APC_F") && _isCrew == 0) exitWith {
            [MLOC(NotAllowToDrive)] call EFUNC(Common,displayNotification);
            true
        };

        // Air requires crew for gunner/commander/turret and pilot for pilot.
        if (_vehicle isKindOf "Air" && ([_isCrew, _isPilot] select (_actionName in ["GetInPilot", "MoveToPilot"])) == 0) exitWith {
            [MLOC(NotAllowToDrive)] call EFUNC(Common,displayNotification);
            true
        };

        // Gunner and commander require a driver.
        // Not possible to figure out which specific turret the player wants to board.
        // This makes it impossible to check the config for FFV seats.
        if (_actionName in ["GetInTurret", "GetInGunner", "GetInCommander", "MoveToTurret", "MoveToGunner", "MoveToCommander"] && (isNull (driver _vehicle) || {driver _vehicle == CLib_Player})) exitWith {
            [MLOC(NotAllowToDrive)] call EFUNC(Common,displayNotification);
            true
        };

        false
    }, _x] call CFUNC(overrideAction);
} count ["GetInDriver", "GetInCommander", "GetInGunner", "GetInCargo", "GetInPilot", "GetInTurret", "MoveToDriver", "MoveToCommander", "MoveToGunner", "MoveToCargo", "MoveToPilot", "MoveToTurret"];
