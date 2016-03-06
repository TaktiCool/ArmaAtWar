class Loadouts {
    class West {
        class Rifleman {
            condition = "true";
            groupMaxCount = 99;
            globalMaxCount = 99;
            scope = 1;
            displayName = "Rifleman";
            icon = "";
            UIicon = "";

            // Special attributes
            isMedic = 0;
            isEngineer = 0;
            isPilot = 0;
            isVehicleCrew = 0;
            isLeader = 0;

            // Primary weapon
            primaryWeapon = "arifle_MX_F";
            primaryAttachments[] = {"optic_Aco","acc_pointer_IR"};
            primaryMagazine = "30Rnd_65x39_caseless_mag";
            primaryMagazineTracer = "30Rnd_65x39_caseless_mag_Tracer";
            primaryMagazineCount = 5;
            primaryMagazineTracerCount = 3;
            primarySecondMagazine = "";
            primarySecondMagazineCount = 0;

            // Secondary weapon
            secondaryWeapon = "";
            secondaryMagazine = "";
            secondaryMagazineCount = 0;

            // Handgun weapon
            handgunWeapon = "hgun_Pistol_heavy_01_F";
            handgunMagazine = "11Rnd_45ACP_Mag";
            handgunMagazineCount = 2;

            // Uniform
            uniform = "U_B_CombatUniform_mcam";
            vest = "V_PlateCarrier2_rgr";
            backpack = "";
            headGear = "H_HelmetB";

            // Items
            assignedItems[] = {"ItemWatch", "ItemCompass", "ItemRadio", "ItemMap", "ItemGPS"};
            items[] = {{"FirstAidKit", 3}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed"};
        };
        class Leader: Rifleman {
            condition = "PRA3_player == leader PRA3_player";
            groupMaxCount = 1;
            globalMaxCount = 99;
            isLeader = 1;
            assignedItems[] += {"Binocular"};
            primaryAttachments[] = {"optic_Hamr","acc_pointer_IR"};
            backpack = "B_AssaultPack_rgr";
            items[] = {{"FirstAidKit", 3}, {"HandGrenade", 2}, {"SmokeShell", 4}, {"SmokeShellGreen", 3}, {"SmokeShellRed", 3}};
            icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";

        };
        class AutomaticRifleman: Rifleman {
            condition = "{_x getVariable [] == _loadoutName} count (units groups) < _maxCountGroup";
            groupMaxCount = 2;
            globalMaxCount = 99;
            primaryWeapon = "LMG_Mk200_F";
            primaryAttachments[] = {"acc_pointer_IR","bipod_01_F_blk",""};
            primaryMagazine = "200Rnd_65x39_cased_Box";
            primaryMagazineTracer = "200Rnd_65x39_cased_Box_Tracer";
            primaryMagazineCount = 2;
            primaryMagazineTracerCount = 3;
            backpack = "B_AssaultPack_rgr";
            items[] = {{"FirstAidKit", 2}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed"};
        };
        class Grenadier: Rifleman {
            condition = "{_x getVariable [] == _loadoutName} count (units groups) < _maxCountGroup";
            groupMaxCount = 2;
            globalMaxCount = 99;
            primaryWeapon = "arifle_MX_GL_F";
            primarySecondMagazine = "1Rnd_HE_Grenade_shell";
            primarySecondMagazineCount = 6;
        };
        class Medic: Rifleman {
            condition = "{_x getVariable ['PRA3_loadout_class'] == _loadoutName} count (units groups) < _maxCountGroup";
            groupMaxCount = 2;
            globalMaxCount = 99;
            isMedic = 1;
            primaryWeapon = "arifle_MXC_F";
            backpack = "";
            assignedItems[] += {};
            icon = "\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa";
        };
        class AntiTank: Rifleman {
            condition = "{_x getVariable [] == _loadoutName} count (units groups) < _maxCountGroup";
            groupMaxCount = 2;
            globalMaxCount = 99;
            isLeader = 1;
            assignedItems[] += {};
        };
    };
    class East : West {
    };
};
