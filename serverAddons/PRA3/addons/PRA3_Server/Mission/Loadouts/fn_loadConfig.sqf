#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Load Loadouts from mission Config

    Parameter(s):
    0: Argument Name <TYPE>

    Returns:
    0: Return Name <TYPE>
*/
params ["_cfg"];

private _scope = getNumber(_cfg >> "scope");

if (_scope == 0) exitWith {};

private _name = configName _cfg;
private _displayName = getText (_cfg >> "displayName");
if (_displayName == "") then {
    _displayName = _name;
};



private _attributes = [];
private _realLoadout = [];
private _loadoutVar = [_name, [_displayName, _realLoadout, _attributes]];
["saveLoadout", _loadout] call CFUNC(globalEvent);
