#include "macros.hpp"
/*
    Arma At War

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

        // Pilot kit for pilot seats.
        if (_actionName in ["GetInPilot", "MoveToPilot"] && _isPilot == 0) exitWith {
            [MLOC(NotAllowToDrive)] call EFUNC(Common,displayNotification);
            true
        };

        // Gunner and commander always require a driver.
        if (_actionName in ["GetInGunner", "GetInCommander", "MoveToGunner", "MoveToCommander"] && (isNull (driver _vehicle) || {driver _vehicle == CLib_Player})) exitWith {
            [MLOC(NotAllowToDrive)] call EFUNC(Common,displayNotification);
            true
        };

        // Turrets
        if (_actionName in ["GetInTurret", "MoveToTurret"]) exitWith {
            // Detect the turret via scanning for the action text.
            private _vehicleConfig = configFile >> "CfgVehicles" >> typeOf _vehicle;
            private _actionText = getText (configFile >> "CfgActions" >> _actionName >> "text");
            private _vehicleName = getText (_vehicleConfig >> "displayName");

            private _possibleTexts = [];
            private _turretConfigs = [];
            private _scanTurrets = {
                if (!isClass (_this >> "Turrets")) exitWith {};

                {
                    _possibleTexts pushBack format [_actionText, _vehicleName, getText (_x >> "gunnerName")];
                    _turretConfigs pushBack _x;
                    _x call _scanTurrets;
                    nil
                } count ("true" configClasses (_this >> "Turrets"));
            };
            _vehicleConfig call _scanTurrets;

            private _turretConfig = _turretConfigs select (_possibleTexts find _title);

            // Now check if the turret has a gun.
            if (getText (_turretConfig >> "body") != "") exitWith {
                // Turrets with guns always require a driver.
                if (isNull (driver _vehicle) || {driver _vehicle == CLib_Player}) exitWith {
                    [MLOC(NotAllowToDrive)] call EFUNC(Common,displayNotification);
                    true
                };

                // Turrets with guns in air, tank and wheeled apc require crew kit.
                if ((_vehicle isKindOf "Air" || _vehicle isKindOf "Tank" || _vehicle isKindOf "Wheeled_APC_F") && _isCrew == 0) exitWith {
                    [MLOC(NotAllowToDrive)] call EFUNC(Common,displayNotification);
                    true
                };

                false
            };

            // Check if its not a FFV slot.
            if (getNumber (_turretConfig >> "hideWeaponsGunner") == 1) exitWith {
                // This is a turret without a gun and without the players handheld weapon (only copilot afaik).
                // Copilot need pilot kit
                if (_vehicle isKindOf "Air" && _isPilot == 0) exitWith {
                    [MLOC(NotAllowToDrive)] call EFUNC(Common,displayNotification);
                    true
                };

                false
            };

            false
        };

        // Driver
        // Tank and APC driver require crew kit.
        if ((_vehicle isKindOf "Tank" || _vehicle isKindOf "Wheeled_APC_F") && _isCrew == 0) exitWith {
            [MLOC(NotAllowToDrive)] call EFUNC(Common,displayNotification);
            true
        };

        false
    }, _x] call CFUNC(overrideAction);
} count ["GetInDriver", "GetInCommander", "GetInGunner", "GetInCargo", "GetInPilot", "GetInTurret", "MoveToDriver", "MoveToCommander", "MoveToGunner", "MoveToCargo", "MoveToPilot", "MoveToTurret"];
