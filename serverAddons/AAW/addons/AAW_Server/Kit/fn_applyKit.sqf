#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, NetFusion

    Description:
    Apply Kit to player

    Parameter(s):
    0: Kit Name <String>

    Returns:
    None
*/
params ["_kitName"];

private _kitDetails = [_kitName, [
    ["displayName", ""], ["icon", ""], ["mapIcon", ""], ["compassIcon", ["", 1]],
    ["loadouts", ["basic"]],
    ["isLeader", 0], ["isMedic", 0], ["isEngineer", 0], ["isPilot", 0], ["isCrew", 0]
]] call FUNC(getKitDetails);
_kitDetails params [
    "_displayName", "_icon", "_mapIcon", "_compassIcon",
    "_loadouts",
    "_isLeader", "_isMedic", "_isEngineer", "_isPilot", "_isCrew"
];

// remove all Items
removeAllAssignedItems CLib_Player;
removeAllWeapons CLib_Player;
removeHeadgear CLib_Player;
removeGoggles CLib_Player;

if (_icon == "") then {
    _icon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
};
if (_mapIcon == "") then {
    _mapIcon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
};


{
    [_x] call CFUNC(applyLoadout);
    nil
} count _loadouts;

CLib_Player setVariable [QGVAR(kit), _kitName, true];
CLib_Player setVariable [QGVAR(kitDisplayName), _displayName, true];
CLib_Player setVariable [QGVAR(kitIcon), _icon, true];
CLib_Player setVariable [QGVAR(MapIcon), _mapIcon, true];
CLib_Player setVariable [QGVAR(compassIcon), _compassIcon, true];

CLib_Player setVariable [QGVAR(isLeader), _isLeader == 1, true];
CLib_Player setVariable [QGVAR(isMedic), _isMedic == 1, true];
CLib_Player setVariable [QGVAR(isEngineer), _isEngineer == 1, true];
CLib_Player setVariable [QGVAR(isPilot), _isPilot == 1, true];
CLib_Player setVariable [QGVAR(isCrew), _isCrew == 1, true];

if (_isMedic == 1) then {
    CLib_Player setUnitTrait ["medic", true];
} else {
    CLib_Player setUnitTrait ["medic", false];
};
if (_isEngineer == 1) then {
    CLib_Player setUnitTrait ["engineer", true];
} else {
    CLib_Player setUnitTrait ["engineer", false];
};
