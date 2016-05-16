#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas, NetFusion

    Description:
    Handle fatigue effects

    Parameter(s):
    None

    Returns:
    None
*/
// @todo replace with fatigue framework
[QGVAR(Hit), {
    (_this select 0) params ["_unit", "_selectionName", "_newDamage", "_totalDamage"];

    if (_selectionName in ["leg_l", "leg_r"] && _totalDamage > ([QGVAR(Settings_maxDamageOnLegsBeforWalking), 0.7] call CFUNC(getSetting))) then {
        ["forceWalk","Revive",true] call PRA3_Core_fnc_setStatusEffect;
    };
}] call CFUNC(addEventHandler);

[QGVAR(DeregisterTreatment), {
    (_this select 0) params ["_unit", "_action", "_finished"];

    // Only handle healing here
    if (_action != "HEAL" ||!(isForcedWalk PRA3_Player)) exitWith {};

    if (_finished) then { //@todo maybe a value check for legs is better
        ["forceWalk","Revive",false] call PRA3_Core_fnc_setStatusEffect;
    };
}] call CFUNC(addEventHandler);
