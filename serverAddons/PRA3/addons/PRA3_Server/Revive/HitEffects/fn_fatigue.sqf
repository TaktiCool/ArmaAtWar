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
// TODO replace with fatigue framework
[QGVAR(Hit), {
    (_this select 0) params ["_unit", "_selectionName", "_newDamage", "_totalDamage"];

    if (_selectionName in ["leg_l", "leg_r"] && _totalDamage > ([QGVAR(Settings_maxDamageOnLegsBeforWalking), 0.7] call CFUNC(getSetting))) then {
        ["forceWalk","Revive",true] call CFUNC(setStatusEffect);
    };
}] call CFUNC(addEventHandler);

[QGVAR(DeregisterTreatment), {
    (_this select 0) params ["_unit", "_action", "_finished"];

    // Only handle healing here
    if (_action != "HEAL" ||!(isForcedWalk Clib_Player)) exitWith {};

    if (_finished) then { // TODO maybe a value check for legs is better
        ["forceWalk","Revive",false] call CFUNC(setStatusEffect);
    };
}] call CFUNC(addEventHandler);
