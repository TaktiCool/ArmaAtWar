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


_canApplyKit = true;
_ctrl = findDisplay KITDIALOG displayCtrl IDC_PRA3_LOADOUTSELECTOR_KS_LISTBOXRESTRICITONS;
lbClear _ctrl;
{
	if (configName(_x) == _type) then {

		

		if (leader group player != player && getNumber(_x >> "mustBeLeader") == 1) then
		{
			_ctrl lbAdd "Group Leader";
			_canApplyKit = false;
		};
		if ({side _x == playerSide} count playableUnits < getNumber(_x >> "minTeamSize")) then 
		{
			_ctrl lbAdd format ["Min. Team Size: %1", getNumber(_x >> "minTeamSize")];
			_canApplyKit = false;
		};
		if (count units group player < getNumber(_x >> "minGroupSize")) then 
		{
			_ctrl lbAdd format ["Min. Grp Size: %1", getNumber(_x >> "minGroupSize")];
			_canApplyKit = false;
		};
		if ({_x getVariable ["unitRole", ""] == _type} count units group player >= getNumber(_x >> "maxPerSquad")) then 
		{
			_ctrl lbAdd format ["Max roles / Sqd.: %1", getNumber(_x >> "maxPerSquad")];
			_canApplyKit = false;
		};
		if ({_x getVariable ["unitRole", ""] == _type && side _x == playerSide} count playableUnits >= getNumber(_x >> "maxPerTeam")) then 
		{
			_ctrl lbAdd format ["Max roles / Team.: %1", getNumber(_x >> "maxPerTeam")];
			_canApplyKit = false;
		};
		if ((getText(_x >> "requiredLeaderRole") != "") && (leader group player getVariable ["unitRole", ""] != getText(_x >> "requiredLeaderRole"))) then 
		{
			_search = getText(_x >> "requiredLeaderRole");
			_ctrl lbAdd format ["Leaders Role: %1", getText(missionConfigFile >> "CfgProjectRealityArma3Classes" >> _handle >> _search >> "displayNameShort")];
			_canApplyKit = false;
		};
	};

} foreach ("isclass _x" configclasses (missionConfigFile >> "CfgProjectRealityArma3Classes" >> _handle));


_ctrl = findDisplay KITDIALOG displayCtrl IDC_PRA3_LOADOUTSELECTOR_KS_BUTTONAPPLY;
_ctrl ctrlEnable _canApplyKit;