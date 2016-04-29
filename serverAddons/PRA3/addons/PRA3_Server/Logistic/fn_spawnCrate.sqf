#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Spawn a Crate at a Position

    Remark:
    Only Execute on Server

    Parameter(s):
    0: Object Arguments <Array>
        0: Object Classname <String>
        1: Content of the Object <Array>(Default: [])
    1: Spawn Position <Array>

    Returns:
    None
*/

(_this select 0) params ["_args", "_spawnPos"];
_args params ["_crateType", ["_content", []]];

if (isClass (configFile >> "CfgVehicles" >> _crateType)) exitWith {
    DUMP("Crate Classname Dont Exist: " + _crateType)
};
private _spawnPos = [_spawnPos, 10, _crateType] call CFUNC(findSavePosition);
private _crateObject = _crateType createVehicle _spawnPos;

if !(_content isEqualTo []) then {

    // hideObject until the Cargo is Filled up
    _crateObject hideObjectGlobal true;

    // clear the Cargo
    clearWeaponCargoGlobal _crateObject;
    clearMagazineCargoGlobal _crateObject;
    clearItemCargoGlobal _crateObject;
    clearBackpackCargoGlobal _crateObject;

    // Refill the Cargo
    {
        call {
            if ((_x select 0) isKindOf ["ItemCore", configFile >> "CfgWeapons"]) exitWith {
                _crateObject addItemCargoGlobal _x;
            };

            if (isClass(configFile >> "CfgMagazines" >> (_x select 0))) exitWith {
                _crateObject addMagazineCargoGlobal _x;
            };

            if ((_x select 0) isKindOf "Bag_Base") exitWith {
                _crateObject addBackpackCargoGlobal _x;
            };

            if (isClass(configFile >> "CfgWeapons" >> (_x select 0))) exitWith {
                _crateObject addWeaponCargoGlobal _x;
            };
        };
        nil
    } count _content;

    // Unhide the Cargo after Filling
    _crateObject hideObjectGlobal false;
};
