#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Init Loadout Module

    Parameter(s):
    None

    Returns:
    None
*/

DFUNC(addMagazine) = {
    params ["_unit", "_className", "_count"];
    if (_className != "" && _count > 0) then {
        for "_i" from 0 to _count do {
            _unit addMagazine _className;
        };
    };
};
DFUNC(addWeapon) = {
    params ["_unit", "_className", "_magazine", "_count"];
    if (_className != "" && _magazine != "" && _count > 0) then {
        _unit addWeapon _className;
        [_unit, _magazine, _count] call FUNC(addMagazine);
    };
};
DFUNC(addPrimaryAttachment) = {
    params ["_unit", "_className"];
    if (_className != "") then {
        _unit addPrimaryWeaponItem _className;
    };
};

/*
DFUNC(addSecoundaryAttachment) = {
    params ["_unit", "_className"];
    _unit addSecondaryWeaponItem _className;
};
DFUNC(addHandGunAttachment) = {
    params ["_unit", "_className"];
    _unit addHandgunItem _className;
};
*/

DFUNC(addItem) = {
    params ["_unit", "_className", ["_count", 1]];
    if (_className != "" && _count < 0) exitWith {};
    if (_unit canAddItemToUniform [_className, _count]) exitWith {};
    if (_unit canAddItemToVest [_className, _count]) exitWith {};
    if (_unit canAddItemToBackpack [_className, _count]) exitWith {};
    if (_unit canAdd [_className, _count]) exitWith {};
    hint format ["Item %1 can't added because Gear is Full", _className];
};

GVAR(LoadoutCache) = call CFUNC(createNamespace);
["saveLoadout", {
    (_this select 0) params ["_loadoutVar", "_value"];
    GVAR(LoadoutCache) setVariable [_loadoutVar, _value];
}] call CFUNC(addEventhandler);

{
    private _sideName = configName _x;
    {
        [_x, _sideName] call FUNC(Loadout_loadConfig);
        nil
    } count ("true" configClasses (_x));
    nil
} count ("true" configClasses (missionConfigFile >> "PRA3" >>"Loadouts"));
