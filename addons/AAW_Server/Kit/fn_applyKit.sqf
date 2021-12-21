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
params ["_unit", "_kitName"];

private _kitDetails = [_kitName, side group _unit, [
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
removeAllAssignedItems _unit;
removeAllWeapons _unit;
removeHeadgear _unit;
removeGoggles _unit;

if (_icon == "") then {
    _icon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
};
if (_mapIcon == "") then {
    _mapIcon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
};
if (_uiIcon == "") then {
    _uiIcon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
};

{
    [_unit, _x] call CFUNC(applyLoadout);
    nil
} count _loadouts;

_unit setVariable [QGVAR(kit), _kitName, true];
_unit setVariable [QGVAR(kitDisplayName), _displayName, true];
_unit setVariable [QGVAR(kitIcon), _icon, true];
_unit setVariable [QGVAR(MapIcon), _mapIcon, true];
_unit setVariable [QGVAR(compassIcon), _compassIcon, true];

_unit setVariable [QGVAR(isLeader), _isLeader == 1, true];
_unit setVariable [QGVAR(isMedic), _isMedic == 1, true];
_unit setVariable [QGVAR(isEngineer), _isEngineer == 1, true];
_unit setVariable [QGVAR(isPilot), _isPilot == 1, true];
_unit setVariable [QGVAR(isCrew), _isCrew == 1, true];

_unit setUnitTrait ["medic", _isMedic == 1];
_unit setUnitTrait ["engineer", _isEngineer == 1];
