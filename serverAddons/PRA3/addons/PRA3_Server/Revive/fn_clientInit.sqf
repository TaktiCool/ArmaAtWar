#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Client Init of Revive Module

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(Settings), missionConfigFile >> "PRA3" >> "CfgRevive"] call CFUNC(loadSettings);

GVAR(selections) = ["", "head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];

// Varaibles for Cached Damage handler

GVAR(damageWaitIsRunning) = false;
GVAR(cachedDamage) = GVAR(selections) apply {[0]};;
GVAR(killPlayerInNextFrame) = false;
// HitEffects
call FUNC(blood);
call FUNC(fatigue);
call FUNC(unconscious);

// Treatments
call FUNC(bandage);
call FUNC(heal);
call FUNC(revive);

// Reset all EH on playerChanged event
//@todo playerChanged is not triggered on mission start
["playerChanged", {
    (_this select 0) params ["_newPlayer", "_oldPlayer"];
    _newPlayer addEventHandler ["HandleDamage", FUNC(handleDamage)];

    // Disable vanilla healing
    _newPlayer addEventHandler ["HitPart", {0}];
    _newPlayer addEventHandler ["Hit", {0}];
}] call CFUNC(addEventHandler);

[QGVAR(Killed), {
    (_this select 0) params ["_unit"];

    [_unit, QGVAR(selectionDamage), GVAR(selections) apply {0}] call CFUNC(setVariablePublic);

    [_unit, QGVAR(HealingProgress), 0] call CFUNC(setVariablePublic);
    [_unit, QGVAR(HealingRate), 0] call CFUNC(setVariablePublic);
    [_unit, QGVAR(HealingTimestamp), -1] call CFUNC(setVariablePublic);
}] call CFUNC(addEventHandler);

// Broadcast variable again on respawn
["Respawn", {
    (_this select 0) params ["_newUnit"];

    _newUnit setVariable [QGVAR(selectionDamage), _newUnit getVariable [QGVAR(selectionDamage), GVAR(selections) apply {0}], true];
}] call CFUNC(addEventHandler);
