#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Init

    Parameter(s):
    None

    Returns:
    None
*/

DFUNC(addReviveEventhandler) = {
    params ["_unit"];
    if (_unit isKindOf "CAManBase") then {
        if !(_unit getVariable [QGVAR(reviveEventhandlerAdded), false]) then {
            _unit addEventHandler ["HandleDamage", FUNC(handleDamage)];

            /*
            // Disable vanilla healing
            _unit addEventHandler ["HitPart", {
                {
                    _x params ["_unit", "_source", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_dir", "_radius", "_surface", "_direct"];
                    private _damage = _unit getHit _selection;
                    [_unit, (_selection select 0), (damage _unit), _source, (typeOf _projectile), -1] call FUNC(handleDamage);
                    nil
                } count _this;
                0
            }];

            _unit addEventHandler ["Hit", {
                params ["_unit", "_source", "_damage"];
                [_unit, "body", _damage, _source, "", -1] call FUNC(handleDamage);
                0
            }];*/

            // register that the player
            _unit setVariable [QGVAR(reviveEventhandlerAdded), true];
            DUMP("Unit: " + name _unit + " HandleDamage EHs added")
        };
    };
};

{
    [_x, {
        params ["_entity"];
        _entity call FUNC(addReviveEventhandler);
    }] call CFUNC(addEventhandler);
    nil
} count ["playerChanged", "MPRespawn", "entityCreated", "Respawn"];

[QGVAR(remoteHandleDamageEvent), {
    (_this select 0) call FUNC(handleDamageCached);
}] call CFUNC(addEventhandler);
