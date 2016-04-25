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
        private _isCargo = if (_tb > 0  || _tm > 0 || _tw > 0) then {true;} else {false;};

        if (!_isCargo) then {
            private _weaponHolder = createVehicle ["WeaponHolder", [0, 0, 0], [], 0, "NONE"];
            _weaponHolder attachTo [_entity];
            /*
            ["hideObject", [_weaponHolder, true]] call CFUNC(serverEvent);

            _entity setVariable ["WeaponHolder", _weaponHolder];

            [
                getText (configFile >> "CfgActions" >> "Gear" >> "text"),
                _entity,
                3,
                {cursorTarget == _target},
                {
                    params ["_object"];
                    hint str (_object getVariable "WeaponHolder");
                    PRA3_Player action ["Gear", _object getVariable "WeaponHolder"];
                }
            ] call CFUNC(addAction);
            */
        };
    };

}] call CFUNC(addEventHandler);
