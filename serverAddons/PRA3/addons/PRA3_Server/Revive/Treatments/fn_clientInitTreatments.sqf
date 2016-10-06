#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas, NetFusion

    Description:
    Initializes treatment system

    Parameter(s):
    None

    Returns:
    None
*/

/*
 * WEAPON SWITCHING
 */
[QGVAR(SwitchWeapon), {
    params ["_item"];

    // Restore old action
    [QGVAR(RestoreWeapon)] call CFUNC(localEvent);

    // Move the weapon on back
    CLib_Player action ["SwitchWeapon", CLib_Player, CLib_Player, 99];

    // Create a simple object
    private _modelName = getText (configFile >> "CfGWeapons" >> _item >> "model");
    if ((_modelName select [0, 1]) == "\") then {
        _modelName = _modelName select [1, count _modelName - 1];
    };
    if ((_modelName select [count _modelName - 4, 4]) != ".p3d") then {
        _modelName = _modelName + ".p3d";
    };
    private _fakeWeapon = createSimpleObject [_modelName, [0, 0, 0]];

    // Attach it to the right hand
    _fakeWeapon attachTo [CLib_Player, [0, 0, -0.2], "rwrist"];
    if (_item != "medikit") then {
        ["setVectorDirAndUp", [_fakeWeapon, [[0, 0, -1], [0, 1, 0]]]] call CFUNC(globalEvent);
    };

    // Store the weapon holder to remove it on restoring real weapon.
    CLib_Player setVariable [QGVAR(fakeWeapon), _fakeWeapon];
    CLib_Player setVariable [QGVAR(fakeWeaponName), _item];

    // Create an action to restore main weapon. Use the vanilla switch weapon action data.
    private _actionConfig = configFile >> "CfgActions" >> "SwitchWeapon";
    if ((primaryWeapon CLib_Player != "") && getNumber (_actionConfig >> "show") == 1) then {
        // Add the action and store the id to remove it on grenade mode exit.
        private _restoreWeaponActionId = CLib_Player addAction [format [getText (_actionConfig >> "text"), getText (configFile >> "CfgWeapons" >> (primaryWeapon CLib_Player) >> "displayName")], {
            // Switch back to the primary weapon.
            CLib_Player action ["SwitchWeapon", CLib_Player, CLib_Player, 0];
        }, nil, getNumber (_actionConfig >> "priority"), getNumber (_actionConfig >> "showWindow") == 1, getNumber (_actionConfig >> "hideOnUse") == 1, getText (_actionConfig >> "shortcut")];
        CLib_Player setVariable [QGVAR(restoreWeaponAction), _restoreWeaponActionId];
    };

    // If player lose the item by scripts
    [{
        params ["_item", "_id"];

        if (CLib_Player getVariable [QGVAR(fakeWeaponName), ""] == "") exitWith {
            _id call CFUNC(removePerFrameHandler);
        };

        if (!(_item in (items CLib_Player))) then {
            CLib_Player action ["SwitchWeapon", CLib_Player, CLib_Player, 0];
        };
    }, 0, _item] call CFUNC(addPerFrameHandler);
}] call CFUNC(addEventHandler);

[QGVAR(RestoreWeapon), {
    CLib_Player setVariable [QGVAR(fakeWeaponName), ""];

    // Get the weapon holder and delete it.
    private _fakeWeapon = CLib_Player getVariable [QGVAR(fakeWeapon), objNull];
    deleteVehicle _fakeWeapon;

    // Remove the exit action if it exists.
    private _restoreWeaponActionId = CLib_Player getVariable [QGVAR(restoreWeaponAction), -1];
    if (_restoreWeaponActionId > -1) then {
        CLib_Player removeAction _restoreWeaponActionId;
    };
}] call CFUNC(addEventHandler);

// Reset values on death
[QGVAR(Killed), {
    (_this select 0) params ["_unit"];

    CLib_Player setVariable [QGVAR(fakeWeapon), nil];
    CLib_Player setVariable [QGVAR(fakeWeaponName), nil];
    CLib_Player setVariable [QGVAR(restoreWeaponAction), nil];

    CLib_Player setVariable [QGVAR(medicalActionRunning), ""];
}] call CFUNC(addEventHandler);

// To restore default behaviour if the weapon is changed use currentWeaponChanged EH.
["currentWeaponChanged", {
    (_this select 0) params ["_currentWeapon", "_oldWeapon"];

    if (_currentWeapon != "") then {
        [QGVAR(RestoreWeapon)] call CFUNC(localEvent);
    };
}] call CFUNC(addEventHandler);

["vehicleChanged", {
    [QGVAR(RestoreWeapon)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

/*
 * MEDICAL ACTIONS
 */
GVAR(medicalActionRunning) = "";
GVAR(medicalActionTarget) = objNull;
GVAR(inhibitKeyPressEH) = -1;
[QGVAR(StartMedicalAction), {
    (_this select 0) params ["_action", "_target"];

    GVAR(medicalActionRunning) = _action;
    GVAR(medicalActionTarget) = _target;
    _target setVariable [QGVAR(medicalActionRunning), _action, true];

    // Publish time
    _target setVariable [QGVAR(treatmentStartTime), serverTime, true];

    [QGVAR(RegisterTreatment), _target, [CLib_Player, _action]] call CFUNC(targetEvent);

    GVAR(inhibitKeyPressEH) = (findDisplay 46) displayAddEventHandler ["KeyDown", {
        params ["_ctrl", "_key"];

        // Handle ESC Key
        if (_key == 1) then {
            [QGVAR(StopMedicalAction), false] call CFUNC(localEvent);
        };

        false;
    }];
}] call CFUNC(addEventHandler);

[QGVAR(StopMedicalAction), {
    (_this select 0) params ["_finished"];

    [QGVAR(DeregisterTreatment), GVAR(medicalActionTarget), [CLib_Player, GVAR(medicalActionRunning), _finished]] call CFUNC(targetEvent);

    GVAR(medicalActionRunning) = "";
    GVAR(medicalActionTarget) = objNull;
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", GVAR(inhibitKeyPressEH)];
}] call CFUNC(addEventHandler);

GVAR(currentTreatingUnits) = [];
[QGVAR(RegisterTreatment), {
    (_this select 0) params ["_unit"];

    GVAR(currentTreatingUnits) pushBackUnique _unit;

    [QGVAR(PrepareTreatment), _this select 0] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[QGVAR(DeregisterTreatment), {
    (_this select 0) params ["_unit"];

    GVAR(currentTreatingUnits) = GVAR(currentTreatingUnits) - [_unit];
    if (GVAR(currentTreatingUnits) isEqualTo []) then {
        CLib_Player setVariable [QGVAR(medicalActionRunning), "", true];
    };
    CLib_Player setVariable [QGVAR(treatmentStartTime), serverTime, true];
    [QGVAR(PrepareTreatment), _this select 0] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);
