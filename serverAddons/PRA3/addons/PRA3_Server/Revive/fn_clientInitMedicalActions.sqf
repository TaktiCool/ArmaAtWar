#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Initialize the Medical Actions

    Parameter(s):
    -

    Returns:
    -
*/

GVAR(MedicItemSelected) = "";
GVAR(MedicItemActivated) = -1;
GVAR(MedicItemHolder) = objNull;
GVAR(MedicItemProgress) = 0;
GVAR(CancelAction) = -1;
GVAR(beginTickTime) = -1;
GVAR(reviveKeyPressed) = false;

DFUNC(removeOldAction) = {
    if (GVAR(MedicItemSelected) != "" && !isNull GVAR(MedicItemHolder)) then {
        disableSerialization;

        GVAR(MedicItemSelected) = "";
        deleteVehicle GVAR(MedicItemHolder);
        PRA3_Player removeAction GVAR(CancelAction);
        GVAR(MedicItemActivated) = -1;
        GVAR(MedicItemProgress) = 0;
    };
};

// @Todo write it Function based
[
    "First Aid Kit", PRA3_Player, 0, {
        "FirstAidKit" in (items PRA3_Player) && {GVAR(MedicItemSelected) != "FirstAidKit"} && !(PRA3_Player getVariable [QGVAR(isUnconscious), false]) && PRA3_Player isEqualTo vehicle PRA3_Player
    },
    FUNC(itemAction), ["FirstAidKit"]
] call CFUNC(addAction);

[
    "Medikit", PRA3_Player, 0, {
        "Medikit" in (items PRA3_Player) && {GVAR(MedicItemSelected) != "Medikit"} && !(PRA3_Player getVariable [QGVAR(isUnconscious), false]) && PRA3_Player isEqualTo vehicle PRA3_Player
    },
    FUNC(itemAction), ["Medikit"]
] call CFUNC(addAction);


// To exit the grenade mode if the weapon is changed use currentWeaponChanged EH.
["currentWeaponChanged", {
    (_this select 0) params ["_currentWeapon", "_oldWeapon"];

    if (_currentWeapon != "") then {
        ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutFadeOut 0;
        call FUNC(removeOldAction);
    };

}] call CFUNC(addEventhandler);

{
    [_x, {call FUNC(removeOldAction);}] call CFUNC(addEventhandler);
    nil
} count ["vehicleChanged", "assignedVehicleRoleChanged"];

["missionStarted", {
    call FUNC(reviveAction);
    call FUNC(healingAction);
}] call CFUNC(addEventhandler);
