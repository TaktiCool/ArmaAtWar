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

_ctrl = _this select 0;
_index = _this select 1;
_handle = _this select 2;
_type = _this select 3;

_ctrl = findDisplay KITDIALOG displayCtrl IDC_PRA3_LOADOUTSELECTOR_KS_LISTBOXABILITIES;
lbClear _ctrl;
{
	if (configName(_x) == _type) then {

		if (getNumber (_x >> "isLeader") == 1) then { _ctrl lbAdd "Group Leader" };
		if (getNumber (_x >> "isFARPAuthorised") == 1) then {_ctrl lbAdd "Can build FARP"};
		if (getNumber (_x >> "isCombatPilot") == 1) then {_ctrl lbAdd "Can pilot CAS"};
		if (getNumber (_x >> "isLogisticPilot") == 1) then {_ctrl lbAdd "Can pilot Logi Heli"};
		if (getNumber (_x >> "isLogisticCrew") == 1) then {_ctrl lbAdd "Can crew Logi Heli"};
		if (getNumber (_x >> "isVehicleCommander") == 1) then {_ctrl lbAdd "Can command armed veh."};
		if (getNumber (_x >> "isVehicleCrew") == 1) then {_ctrl lbAdd "Can drive/gun armed veh"};
		if (getNumber (_x >> "isRecon") == 1) then {_ctrl lbAdd "Is a recon unit"};
	};

} foreach ("isclass _x" configclasses (missionConfigFile >> "CfgProjectRealityArma3Classes" >> _handle));

