/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/
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

disableSerialization;

_handle = _this select 0;

_ctrl = findDisplay KITDIALOG displayCtrl IDC_PRA3_LOADOUTSELECTOR_KS_LISTBOXCLASSLIST;
lbClear _ctrl;
{
		_ctrl lbAdd gettext (_x >> "displayName");
		_ctrl lbSetPicture [_foreachindex, gettext (_x >> "texture")];
		_ctrl lbSetData [_foreachindex, str [_handle, configName (_x)] ];
		_rowData = call compile (_ctrl lbData _foreachindex);
		_ctrl lbSetTooltip [_foreachindex, str _rowData];
} foreach ("isclass _x" configclasses (missionConfigFile >> "CfgProjectRealityArma3Classes" >> _handle));
_ctrl lbsetcursel 0;