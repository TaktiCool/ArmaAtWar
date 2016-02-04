/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/

disableSerialization;

#define KITDIALOG 6969
//--- PRA3_LoadoutSelector
#define IDC_PRA3_LOADOUTSELECTOR_KS_TITLE		20771
#define IDC_PRA3_LOADOUTSELECTOR_KS_TITLERESTRICTION	20772
#define IDC_PRA3_LOADOUTSELECTOR_KS_TITLEABILITIES	20773
#define IDC_PRA3_LOADOUTSELECTOR_KS_LISTBOXCLASSLIST	21271
#define IDC_PRA3_LOADOUTSELECTOR_KS_LISTBOXRESTRICITONS	21272
#define IDC_PRA3_LOADOUTSELECTOR_KS_LISTBOXABILITIES	21273
#define IDC_PRA3_LOADOUTSELECTOR_KS_BUTTONAPPLY		21371
#define IDC_PRA3_LOADOUTSELECTOR_KS_BUTTONBASIC		21372
#define IDC_PRA3_LOADOUTSELECTOR_KS_BUTTONCREW		21373
#define IDC_PRA3_LOADOUTSELECTOR_KS_BUTTONSPEC		21374
#define IDC_PRA3_LOADOUTSELECTOR_KS_BACKGROUND		21971


_ctrl = findDisplay KITDIALOG displayCtrl IDC_PRA3_LOADOUTSELECTOR_KS_LISTBOXCLASSLIST;

_classData = call compile (_ctrl lbData lbCurSel _ctrl);
systemChat str _classData;
_classType = _classData select 0;
systemChat str _classType;
_className = _classData select 1;
systemChat str _className;


if (playerSide == east) then {
	_baseKit = getText (missionConfigFile >> "CfgProjectRealityArma3Classes" >> _classType >> _className >> "kitE");
	systemChat _baseKit;

	_loadout = [player, configfile >> "CfgVehicles" >> _baseKit] call BIS_fnc_loadInventory;
	systemchat str _loadout;
};
if (playerSide == west) then {
	_baseKit = getText (missionConfigFile >> "CfgProjectRealityArma3Classes" >> _classType >> _className >> "kitW");
	systemChat _baseKit;

	_loadout = [player, configfile >> "CfgVehicles" >> _baseKit] call BIS_fnc_loadInventory;
	systemchat str _loadout;
};


{
	player setVariable [_x, (getNumber (missionConfigFile >> "CfgProjectRealityArma3Classes" >> _classType >> _className >> _x)), true];
}
forEach ["isLeader","isFARPAuthorised","isCombatPilot","isLogisticPilot","isLogisticCrew","isVehicleCommander","isVehicleCrew","isRecon"];

player setVariable ["unitRole", (getText (missionConfigFile >> "CfgProjectRealityArma3Classes" >> _classType >> _className >> "displayName")) , true];

closeDialog 0;

//Setup extras to be added to kits below.
