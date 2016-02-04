#include "defines.hpp"
class PRA3_KitSelector
{
	idd = 6969;
	movingEnable = false;
	enableSimulation = 1;

	onLoad = "['basic'] execVM 'gui\loadout\scripts\popKitBox.sqf'";
	
	class controls
	{
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by JohnnyShootos, v1.063, #Wogyvu)
	////////////////////////////////////////////////////////

		class KS_Background: IGUIBack
		{
			idc = IDC_PRA3_LOADOUTSELECTOR_KS_BACKGROUND;
			x = 0.376692 * safezoneW + safezoneX;
			y = 0.321508 * safezoneH + safezoneY;
			w = 0.246617 * safezoneW;
			h = 0.263041 * safezoneH;
		};
		class KS_ListboxClassList: RscListbox
		{
			idc = IDC_PRA3_LOADOUTSELECTOR_KS_LISTBOXCLASSLIST;
			x = 0.381096 * safezoneW + safezoneX;
			y = 0.349691 * safezoneH + safezoneY;
			w = 0.118904 * safezoneW;
			h = 0.225464 * safezoneH;
			colorText[] = {1,1,1,1};

			onLBSelChanged = "_this execVM 'gui\loadout\scripts\lbUpdate.sqf';";
		};
		class KS_ListboxRestricitons: RscListbox
		{
			idc = IDC_PRA3_LOADOUTSELECTOR_KS_LISTBOXRESTRICITONS;
			x = 0.508808 * safezoneW + safezoneX;
			y = 0.349691 * safezoneH + safezoneY;
			w = 0.110097 * safezoneW;
			h = 0.084549 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class KS_ListboxAbilities: RscListbox
		{
			idc = IDC_PRA3_LOADOUTSELECTOR_KS_LISTBOXABILITIES;
			x = 0.508808 * safezoneW + safezoneX;
			y = 0.453028 * safezoneH + safezoneY;
			w = 0.110097 * safezoneW;
			h = 0.084549 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class KS_ButtonApply: RscButton
		{
			idc = IDC_PRA3_LOADOUTSELECTOR_KS_BUTTONAPPLY;
			text = "Apply Kit"; //--- ToDo: Localize;
			x = 0.508808 * safezoneW + safezoneX;
			y = 0.537577 * safezoneH + safezoneY;
			w = 0.110097 * safezoneW;
			h = 0.0375773 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.25};
			action = "[] execVM 'gui\loadout\scripts\applyKitButton.sqf'";
		};
		class KS_Title: RscText
		{
			idc = IDC_PRA3_LOADOUTSELECTOR_KS_TITLE;
			text = "PR:AIII - Loadout Selector"; //--- ToDo: Localize;
			x = 0.376692 * safezoneW + safezoneX;
			y = 0.302719 * safezoneH + safezoneY;
			w = 0.246617 * safezoneW;
			h = 0.0187887 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class KS_ButtonBasic: RscButton
		{
			idc = IDC_PRA3_LOADOUTSELECTOR_KS_BUTTONBASIC;
			text = "Basic"; //--- ToDo: Localize;
			x = 0.381096 * safezoneW + safezoneX;
			y = 0.330902 * safezoneH + safezoneY;
			w = 0.0264232 * safezoneW;
			h = 0.0187887 * safezoneH;
			colorText[] = {1,1,1,1};
			action = "['basic'] execVM 'gui\loadout\scripts\popKitBox.sqf'";
		};
		class KS_ButtonCrew: RscButton
		{
			idc = IDC_PRA3_LOADOUTSELECTOR_KS_BUTTONCREW;
			text = "Crew"; //--- ToDo: Localize;
			x = 0.411923 * safezoneW + safezoneX;
			y = 0.330902 * safezoneH + safezoneY;
			w = 0.0264232 * safezoneW;
			h = 0.0187887 * safezoneH;
			colorText[] = {1,1,1,1};
			action = "['crew'] execVM 'gui\loadout\scripts\popKitBox.sqf'";
		};
		class KS_ButtonSpec: RscButton
		{
			idc = IDC_PRA3_LOADOUTSELECTOR_KS_BUTTONSPEC;
			text = "Spec"; //--- ToDo: Localize;
			x = 0.44275 * safezoneW + safezoneX;
			y = 0.330902 * safezoneH + safezoneY;
			w = 0.0264232 * safezoneW;
			h = 0.0187887 * safezoneH;
			colorText[] = {1,1,1,1};
			action = "['spec'] execVM 'gui\loadout\scripts\popKitBox.sqf'";
		};
		class KS_TitleRestriction: RscText
		{
			idc = IDC_PRA3_LOADOUTSELECTOR_KS_TITLERESTRICTION;
			text = "Restrictions:"; //--- ToDo: Localize;
			x = 0.508808 * safezoneW + safezoneX;
			y = 0.330902 * safezoneH + safezoneY;
			w = 0.105693 * safezoneW;
			h = 0.0187887 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};
		class KS_TitleAbilities: RscText
		{
			idc = IDC_PRA3_LOADOUTSELECTOR_KS_TITLEABILITIES;
			text = "Abilities:"; //--- ToDo: Localize;
			x = 0.508808 * safezoneW + safezoneX;
			y = 0.43424 * safezoneH + safezoneY;
			w = 0.105693 * safezoneW;
			h = 0.0187887 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////
	};
};