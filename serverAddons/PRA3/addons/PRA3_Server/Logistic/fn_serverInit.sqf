#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Logistic system

    Parameter(s):
    None

    Returns:
    None
*/


["entityCreated", {
    (_this select 0) params ["_entity"];

    private _cargoCapacity = _entity getVariable ["cargoCapacity", 0];

    if (_cargoCapacity > 0) then {

        private _className = typeOf _entity;
        private _tb = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxbackpacks");
        private _tm = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxmagazines");
        private _tw = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxweapons");
        private _isCargo = (_tb > 0  || _tm > 0 || _tw > 0);

        _entity setVariable ["hasInventory", _isCargo, true];
    };

}] call CFUNC(addEventHandler);

["spawnCrate", FUNC(spawnCrate)] call CFUNC(addEventHandler);
