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
_index = lbCurSel _ctrl;
_handle = (call compile (_ctrl lbData _index)) select 0;
_type = (call compile (_ctrl lbData _index)) select 1;

[_ctrl, _index, _handle, _type] execVM "gui\loadout\scripts\kitRestrictionCheck.sqf";
[_ctrl, _index, _handle, _type] execVM "gui\loadout\scripts\kitAbilityCheck.sqf";



