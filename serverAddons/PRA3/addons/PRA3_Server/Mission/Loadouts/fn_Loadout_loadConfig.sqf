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
private ["_scope", "_cfg", "_name", "_displayName", "_isMedic", "_isEngineer",
"_isPilot", "_isVehicleCrew", "_isLeader", "_primaryWeapon", "_primaryAttachments",
"_primaryMagazine", "_primaryMagazineTracer", "_primaryMagazineCount", "_primaryMagazineTracerCount",
"_secondaryWeapon", "_secondaryMagazine", "_secondaryMagazineCount", "_handgunWeapon", "_handgunMagazine",
"_handgunMagazineCount", "_uniform", "_vest", "_backpack", "_headGear", "_assignedItems",
"_attributes", "_realLoadout", "_loadoutVar", "_loadout"];
params ["_cfg"];

_scope = getNumber(_cfg >> "scope");

if (_scope == 0) exitWith {};

_name = configName _cfg;
_displayName = getText (_cfg >> "displayName");
if (_displayName == "") then {
    _displayName = _name;
};


_isMedic = (getNumber (_cfg >> "isMedic")) isEqualTo 1;
_isEngineer = (getNumber (_cfg >> "isEngineer")) isEqualTo 1;
_isPilot = (getNumber (_cfg >> "isPilot")) isEqualTo 1;
_isVehicleCrew = (getNumber (_cfg >> "isVehicleCrew")) isEqualTo 1;
_isLeader = (getNumber (_cfg >> "isLeader")) isEqualTo 1;


_primaryWeapon = getText (_cfg >> "primaryWeapon");
_primaryAttachments = getArray (_cfg >> "primaryAttachments");
_primaryMagazine = getText (_cfg >> "primaryMagazine");
_primaryMagazineTracer = getText (_cfg >> "primaryMagazineTracer");
_primaryMagazineCount = getNumber (_cfg >> "primaryMagazineCount");
_primaryMagazineTracerCount = getNumber (_cfg >> "primaryMagazineTracerCount");
_primarySecoundMagazine = getText (_cfg >> "primarySecoundMagazine");
_primarySecoundMagazineCount = getNumber (_cfg >> "primarySecoundMagazineCount");

_secondaryWeapon = getText (_cfg >> "secondaryWeapon");
_secondaryMagazine = getText (_cfg >> "secondaryMagazine");
_secondaryMagazineCount = getNumber (_cfg >> "secondaryMagazineCount");


_handgunWeapon = getText (_cfg >> "handgunWeapon");
_handgunMagazine = getText (_cfg >> "handgunMagazine");
_handgunMagazineCount = getNumber (_cfg >> "handgunMagazineCount");


_uniform = getText (_cfg >> "uniform");
_vest = getText (_cfg >> "vest");
_backpack = getText (_cfg >> "backpack");
_headGear = getText (_cfg >> "headGear");


_assignedItems = getArray (_cfg >> "assignedItems");
_assignedItems = getArray (_cfg >> "items");

_attributes = [_isMedic, _isEngineer, _isPilot, _isVehicleCrew, _isLeader];
_realLoadout = [_primaryWeapon,_primaryAttachments,_primaryMagazine,_primaryMagazineTracer,_primaryMagazineCount,_primaryMagazineTracerCount,_secondaryWeapon,_secondaryMagazine,_secondaryMagazineCount,_handgunWeapon,_handgunMagazine,_handgunMagazineCount,_uniform,_vest,_backpack,_headGear,_assignedItems,_assignedItems];
_loadoutVar = [_name, [_displayName, _realLoadout, _attributes]];
["saveLoadout", _loadoutVar, true] call CFUNC(globalEvent);
