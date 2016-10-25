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

        if (_actionName in ["GetInCargo", "MoveToCargo"]) exitWith {
            false
        };

        // Read the player settings
        private _currentKitName = CLib_Player getVariable [QGVAR(kit), ""];
        private _kitDetails = [_currentKitName, [["isCrew", 0], ["isPilot", 0]]] call FUNC(getKitDetails);
        _kitDetails params ["_isCrew", "_isPilot"];

        // Tanks and Air turrets require crew and air driver requires pilot
        if (((_vehicle isKindOf "Tank" || _vehicle isKindOf "Wheeled_APC_F") && _isCrew == 0)
            || (_vehicle isKindOf "Air" && ([_isCrew, _isPilot] select (_actionName in ["GetInPilot", "MoveToPilot"])) == 0)
            || (_actionName in ["GetInTurret", "GetInGunner", "GetInCommander", "MoveToTurret", "MoveToGunner", "MoveToCommander"] && (isNull (driver _vehicle) || {driver _vehicle == CLib_Player}))
        ) exitWith {
            [MLOC(NotAllowToDrive)] call EFUNC(Common,displayNotification);
            true
        };

        false
    }, _x] call CFUNC(overrideAction);
} count ["GetInDriver", "GetInCommander", "GetInGunner", "GetInCargo", "GetInPilot", "GetInTurret", "MoveToDriver", "MoveToCommander", "MoveToGunner", "MoveToCargo", "MoveToPilot", "MoveToTurret"];

["playerChanged", {
    (_this select 0) params ["_newPlayer", "_oldPlayer"];
    {
        _newPlayer setVariable [_x, _oldPlayer getVariable _x, true];
    } count [QGVAR(kit), QGVAR(kitDisplayName), QGVAR(kitIcon), QGVAR(MapIcon), QGVAR(isLeader), QGVAR(isMedic), QGVAR(isEngineer), QGVAR(isPilot), QGVAR(isCrew)];
}] call CFUNC(addEventHandler);
