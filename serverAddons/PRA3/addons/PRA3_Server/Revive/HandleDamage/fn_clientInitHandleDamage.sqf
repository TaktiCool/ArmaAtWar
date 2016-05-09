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

// Varaibles for Cached Damage handler
GVAR(damageWaitIsRunning) = false;
GVAR(cachedDamage) = GVAR(selections) apply {[0]};;
GVAR(killPlayerInNextFrame) = false;

["entityCreated", {
    (_this select 0) params ["_entity"];
    if (_entity isKindOf "CABaseMan") then {
        if !(_entity getVariable [QGVAR(reviveEventhandlerAdded), false]) then {
            _entity addEventHandler ["HandleDamage", FUNC(handleDamage)];

            // Disable vanilla healing
            _entity addEventHandler ["HitPart", {0}];
            _entity addEventHandler ["Hit", {0}];

            // register that the player
            _entity setVariable [QGVAR(reviveEventhandlerAdded), true];
        };
    };
}] call CFUNC(addEventhandler);

[QGVAR(remoteHandleDamageEvent), {
    (_this select 0) call FUNC(handleDamageCached);
}] call CFUNC(addEventhandler);
