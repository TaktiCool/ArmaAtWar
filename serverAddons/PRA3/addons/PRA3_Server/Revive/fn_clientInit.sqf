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

["playerChanged", {
    (_this select 0) params ["_newPlayer"];
    _newPlayer addEventHandler ["HandleDamage", FUNC(damageHandler)];

}] call CFUNC(addEventhandler);

["Respawn", {
    (_this select 0) params ["_newUnit"];

    _newUnit setVariable [QGVAR(bleedingRate), 0];
    _newUnit setVariable [QGVAR(bloodLevel), 1];
    _newUnit setVariable [QGVAR(isUnconscious), false, true];
}] call CFUNC(addEventHandler);


call FUNC(bleedOut);
call FUNC(forceRespawnAction);
call FUNC(healAction);
call FUNC(reviveAction);
call FUNC(dragAction);
call FUNC(unloadAction);
