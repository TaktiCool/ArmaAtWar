#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Code for Action

    Parameter(s):
    0: Argument Name <TYPE>

    Returns:
    0: Return Name <TYPE>
*/
(_this select 3) params ["_item"];

if (GVAR(MedicItemSelected) == "") then {
    PRA3_Player action ["SwitchWeapon", PRA3_Player, PRA3_Player, 99];
} else {
    call FUNC(removeOldAction);
};


GVAR(MedicItemSelected) = _item;


// Create a weapon holder and fill it with the dummy item.
private _weaponHolder = createVehicle ["GroundWeaponHolder", [0, 0, 0], [], 0, "NONE"];
_weaponHolder addItemCargoGlobal [_item, 1];

// Attach it to the right hand.
_weaponHolder attachTo [PRA3_Player, [-0.1, 0.6, -0.15], "rwrist"];
["setVectorDirAndUp", [_weaponHolder, [[0, 0, -1], [0, 1, 0]]]] call CFUNC(globalEvent);

//[[_weaponHolder, [[0, 0, -1], [0, 1, 0]]], "setVectorDirAndUp"] call CFNC(execRemoteFnc);

// And prevent it from being accessed.
["enableSimulation", [_weaponHolder, false]] call CFUNC(serverEvent);

_config = configFile >> "CfgActions" >> "SwitchWeapon";
if ((primaryWeapon PRA3_Player != "") && getNumber (_config >> "show") == 1) then {
    // Add the action and store the id to remove it on grenade mode exit.
    GVAR(CancelAction) = PRA3_Player addAction [format [getText (_config >> "text"), getText (configFile >> "CfgWeapons" >> primaryWeapon PRA3_Player >> "displayName")], {
        // Switch back to the primary weapon.
        PRA3_Player action ["SwitchWeapon", PRA3_Player, PRA3_Player, 0];
    }, nil, getNumber (_config >> "priority"), getNumber (_config >> "showWindow") == 1, getNumber (_config >> "hideOnUse") == 1, getText (_config >> "shortcut")];
};

[{
    disableSerialization;

    ([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutRsc [UIVAR(MedicalProgress),"PLAIN",0.2];
    private _display = uiNamespace getVariable [UIVAR(MedicalProgress),displayNull];
    {
        (_display displayCtrl _x) ctrlSetFade 1;
        (_display displayCtrl _x) ctrlCommit 0;
        nil
    } count [3001, 3002, 3003];

    (_display displayCtrl 3004) ctrlSetFade 0;
    (_display displayCtrl 3004) ctrlCommit 0;


    if (isNil QGVAR(mouseActionPFHID)) then {
        GVAR(mouseActionPFHID) = [{
            disableSerialization;

            private _helpText = "";

            if (GVAR(MedicItemSelected) == "FirstAidKit") then {
                if ((cursorTarget getVariable [QGVAR(bloodLoss), 0]) != 0) then {
                    _helpText = "<img size='1.5' image='\a3\3DEN\Data\Displays\Display3DEN\Hint\lmb_ca.paa'/> to bandage a comrade<br />";
                };
                if ((PRA3_Player getVariable [QGVAR(bloodLoss), 0]) != 0) then {
                    _helpText = _helpText + "<img size='1.5' image='\a3\3DEN\Data\Displays\Display3DEN\Hint\rmb_ca.paa'/> to bandage yourself<br />";
                };
            };

            if (GVAR(MedicItemSelected) == "Medikit") then {
                if (((cursorTarget getVariable [QGVAR(bloodLoss), 0]) == 0) && !((cursorTarget getVariable [QGVAR(DamageSelection), [0,0,0,0,0,0,0]]) isEqualTo [0,0,0,0,0,0,0])) then {
                    _helpText = "<img size='1.5' image='\a3\3DEN\Data\Displays\Display3DEN\Hint\lmb_ca.paa'/> to heal a comrade<br />";
                };
                if (((PRA3_Player getVariable [QGVAR(bloodLoss), 0]) == 0) && !((PRA3_Player getVariable [QGVAR(DamageSelection), [0,0,0,0,0,0,0]]) isEqualTo [0,0,0,0,0,0,0])) then {
                    _helpText = _helpText + "<img size='1.5' image='\a3\3DEN\Data\Displays\Display3DEN\Hint\rmb_ca.paa'/> to heal yourself<br />";
                };
            };


            private _display = uiNamespace getVariable [UIVAR(MedicalProgress),displayNull];
            if (isNull _display) exitWith {
                [_this select 1] call CFUNC(removePerFrameHandler);
                GVAR(mouseActionPFHID) = nil;
            };

            if (_helpText != ctrlText (_display displayCtrl 3004)) then {
                (_display displayCtrl 3004) ctrlSetStructuredText parseText _helpText;
                (_display displayCtrl 3004) ctrlCommit 0;
            };
        }, 0.5] call CFUNC(addPerFrameHandler);
    };
}, {isNull (uiNamespace getVariable [UIVAR(MedicalProgress),displayNull])}] call CFUNC(waitUntil);


// Store the weapon holder to remove it on grenade mode exit.
GVAR(MedicItemHolder) = _weaponHolder;
