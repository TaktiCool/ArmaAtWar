#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, NetFusion

    Description:
    Init Kit Module

    Parameter(s):
    None

    Returns:
    None
*/
if (side CLib_player == sideLogic && {player isKindOf "VirtualSpectator_F"}) exitWith {};

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
            ["VEHICLE LOCKED", "You are not allowed to use enemy vehicles!", ["A3\modules_f\data\iconlock_ca.paa"]] call CFUNC(displayHint);
            true
        };

        // Everyone can use cargo seats.
        if (_actionName in ["GetInCargo", "MoveToCargo"]) exitWith {
            false
        };

        // Read the player kit settings.
        private _isCrew = CLib_Player getVariable [QGVAR(isCrew), false];
        private _isPilot = CLib_Player getVariable [QGVAR(isPilot), false];
        private _isEngineer = CLib_Player getVariable [QGVAR(isEngineer), false];

        // Pilot kit for pilot seats.
        if (_actionName in ["GetInPilot", "MoveToPilot"] && !_isPilot) exitWith {
            [MLOC(VEHICLELOCKED), MLOC(EnemyVehicle), ["A3\modules_f\data\iconlock_ca.paa"]] call CFUNC(displayHint);
            true
        };

        // Gunner and commander always require a driver.
        if (_actionName in ["GetInGunner", "GetInCommander", "MoveToGunner", "MoveToCommander"] && (!alive (driver _vehicle) || {driver _vehicle == CLib_Player})) exitWith {
            [MLOC(VEHICLELOCKED), MLOC(PilotRequired), ["A3\modules_f\data\iconlock_ca.paa"]] call CFUNC(displayHint);
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
            if (!(getText (_turretConfig >> "body") == "") && ([_vehicle, ["Air", "Tank", "Wheeled_APC_F"]] call CFUNC(isKindOfArray))) exitWith {
                // Turrets with guns always require a driver (except statics).
                if (!alive (driver _vehicle) || {driver _vehicle == CLib_Player}) exitWith {
                    [MLOC(VEHICLELOCKED), MLOC(DriverRequired), ["A3\modules_f\data\iconlock_ca.paa"]] call CFUNC(displayHint);
                    true
                };

                // Turrets with guns in air, tank and wheeled apc require crew kit.
                if ((_vehicle isKindOf "Air" || _vehicle isKindOf "Tank" || _vehicle isKindOf "Wheeled_APC_F") && !_isCrew) exitWith {
                    [MLOC(VEHICLELOCKED), MLOC(CrewRequired), ["A3\modules_f\data\iconlock_ca.paa"]] call CFUNC(displayHint);
                    true
                };

                false
            };

            // Check if its not a FFV slot.
            if (getNumber (_turretConfig >> "hideWeaponsGunner") == 1) exitWith {
                // This is a turret without a gun and without the players handheld weapon (only copilot afaik).
                // Copilot need pilot kit
                if (_vehicle isKindOf "Air" && !_isPilot) exitWith {
                    [MLOC(VEHICLELOCKED), MLOC(PilotRequired), ["A3\modules_f\data\iconlock_ca.paa"]] call CFUNC(displayHint);
                    true
                };

                false
            };

            false
        };

        // Driver
        // Tank and APC driver require crew kit.
        if ((_vehicle isKindOf "Tank" || _vehicle isKindOf "Wheeled_APC_F") && !_isCrew) exitWith {
            [MLOC(VEHICLELOCKED), MLOC(CrewRequired), ["A3\modules_f\data\iconlock_ca.paa"]] call CFUNC(displayHint);
            true
        };

        // Supply vehicles need engineer
        if (((getAmmoCargo _vehicle >= 0) || (getFuelCargo _vehicle >= 0) || (getRepairCargo _vehicle >= 0)) && !_isEngineer) exitWith {
            [MLOC(VEHICLELOCKED), MLOC(EngineerRequired), ["A3\modules_f\data\iconlock_ca.paa"]] call CFUNC(displayHint);
            true
        };

        false
    }, _x] call CFUNC(overrideAction);
    nil
} count ["GetInDriver", "GetInCommander", "GetInGunner", "GetInCargo", "GetInPilot", "GetInTurret", "MoveToDriver", "MoveToCommander", "MoveToGunner", "MoveToCargo", "MoveToPilot", "MoveToTurret"];

// ACRE support
/*
if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
    ["playerInventoryChanged", {
        //[true, false] call acre_api_fnc_setupMission;

        private _radios = [] call acre_api_fnc_getCurrentRadioList;
        DUMP(_radios);

        private _radio343Ids = _radios select {toLower (_x select [0, 11]) == (toLower "ACRE_PRC343")};
        if (!(_radio343Ids isEqualTo [])) then {
            private _channelId = ((((toArray (groupId group CLib_Player)) select 0) - 65) * 8) + ([17, 129] select (str playerSide == "EAST"));
            private _success = [toUpper (_radio343Ids select 0), _channelId] call acre_api_fnc_setRadioChannel;
            DUMP(_success);
            DUMP(_channelId);
        };

        private _radio117Ids = _radios select {toLower (_x select [0, 11]) == (toLower "ACRE_PRC117")};
        if (!(_radio117Ids isEqualTo [])) then {
            private _success = [toUpper (_radio117Ids select 0), [2, 5] select (str playerSide == "EAST")] call acre_api_fnc_setRadioChannel;
            DUMP(_success);
        };
    }] call CFUNC(addEventhandler);
};
*/
