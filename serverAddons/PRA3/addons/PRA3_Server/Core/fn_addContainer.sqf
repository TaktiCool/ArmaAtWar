#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Add Container Wraper

    Parameter(s):
    0: Unit <Object>
    1: Container Classname <String>
    2: Type Of Classname <Number>(Default: generated out of Config)

    Returns:
    None
*/


private ["_returnValue", "_cfg"];
params [["_unit",objNull,[objNull]],["_containerClassname","",["STRING"]],["_containerNumber", -1, [-1]]];

if (_containerNumber == -1) then {
    private _cfg = (configFile >> "CfgWeapons");
    if (_containerClassname isKindOf ["Uniform_Base", _cfg]) then {
        _containerNumber = 0;
    };
    if (_containerClassname isKindOf ["Vest_NoCamo_Base", _cfg] || _containerClassname isKindOf ["Vest_Camo_Base", _cfg]) then {
        _containerNumber = 1;
    };
    if (_containerClassname isKindOf "Bag_Base") then {
        _containerNumber = 2;
    };
};

_returnValue = true;
switch (_containerNumber) do {
    case 0 : {
        _uniformName = uniform _unit;
        if(_containerClassname == _uniformName && _containerClassname != "") then {
            _uniform = uniformContainer _unit;
            clearItemCargoGlobal _uniform;
            clearMagazineCargoGlobal _uniform;
            clearWeaponCargoGlobal _uniform;
        } else {
            removeUniform _unit;
            _unit forceAddUniform _containerClassname;
        };
    };
    case 1 : {
        _vestName = vest _unit;
        if(_containerClassname == _vestName && _containerClassname != "") then {
            _vest = vestContainer _unit;
            clearItemCargoGlobal _vest;
            clearMagazineCargoGlobal _vest;
            clearWeaponCargoGlobal _vest;
        } else {
            removeVest _unit;
            _unit addVest _containerClassname;
        };
    };
    case 2 : {
        _backpackName = backpack _unit;
        if(_containerClassname == _backpackName && _containerClassname != "") then {
            _backpack = backpackContainer _unit;
            clearItemCargoGlobal _backpack;
            clearMagazineCargoGlobal _backpack;
            clearWeaponCargoGlobal _backpack;
        } else {
            removeBackpack _unit;
            _unit addBackpack _containerClassname;
        };
    };
};
