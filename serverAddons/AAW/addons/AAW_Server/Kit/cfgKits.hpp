class cfgKits {
    class NATO {
        class Rifleman {
            scope = 1;
            kitGroup = "Unlimited";
            availableInGroups[] = {"Rifle", "Weapon", "Mortar"};

            // Display
            displayName = "Rifleman";
            icon = "";
            UIIcon = "\A3\ui_f\data\gui\rsc\rscdisplayarsenal\primaryweapon_ca.paa";
            mapIcon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
            compassIcon[] = {"a3\ui_f\data\map\Markers\Military\dot_ca.paa", 3.6};

            // Special attributes
            isLeader = 0;
            isMedic = 0;
            isEngineer = 0;
            isPilot = 0;
            isCrew = 0;

            // Primary weapon
            primaryWeapon = "arifle_MX_F";
            primaryAttachments[] = {"optic_Aco","acc_pointer_IR"};
            primaryMagazine = "30Rnd_65x39_caseless_mag";
            primaryMagazineCount = 6;
            primaryMagazineTracer = "30Rnd_65x39_caseless_mag_Tracer";
            primaryMagazineTracerCount = 0;

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
            items[] = {"FirstAidKit","FirstAidKit","FirstAidKit", "HandGrenade","HandGrenade", "SmokeShell", "SmokeShell", "SmokeShellGreen", "SmokeShellRed"};
        };
        class Officer: Rifleman {
            availableInGroups[] = {"Rifle", "Weapon", "Mortar"};

            displayName = "Officer";

            isLeader = 1;

            secondaryWeapon = "Binocular";

            primaryAttachments[] = {"optic_Arco","acc_pointer_IR"};
            backpack = "B_AssaultPack_rgr";
            items[] = {{"FirstAidKit", 3}, {"HandGrenade", 2}, {"SmokeShell", 4}, {"SmokeShellGreen", 3}, {"SmokeShellRed", 3}};
            icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
            UIIcon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
            mapIcon = "\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa";
            compassIcon[] = {"a3\ui_f\data\gui\cfg\ranks\corporal_gs.paa", 1.3};
        };
        class Medic: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle", "Weapon"};

            displayName = "Medic";

            isMedic = 1;

            primaryWeapon = "arifle_MXC_F";
            backpack = "B_AssaultPack_rgr";
            items[] = {{"FirstAidKit", 10}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed", "Medikit"};

            icon = "\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa";
            UIIcon = "a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
            mapIcon = "\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa";
            compassIcon[] = {"a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa", 2};
        };
        class AutomaticRifleman: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            displayName = "Automatic Rifleman";

            primaryWeapon = "LMG_Mk200_F";
            primaryAttachments[] = {"acc_pointer_IR","bipod_01_F_blk"};
            primaryMagazine = "200Rnd_65x39_cased_Box";
            primaryMagazineCount = 0;
            primaryMagazineTracer = "200Rnd_65x39_cased_Box_Tracer";
            primaryMagazineTracerCount = 3;
            backpack = "B_AssaultPack_rgr";
            items[] = {{"FirstAidKit", 2}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed"};

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\mg_ca.paa";
        };
        class Grenadier: Rifleman {
            kitGroup = "Specialized";
            availableInGroups[] = {"Rifle"};

            displayName = "Grenadier";

            primaryWeapon = "arifle_MX_GL_F";
            items[] += {{"1Rnd_HE_Grenade_shell", 6}, {"1Rnd_Smoke_Grenade_shell", 3}};

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\gl_ca.paa";
        };
        class Marksman: Rifleman {
            kitGroup = "Specialized";
            availableInGroups[] = {"Rifle"};

            displayName = "Marksman";

            primaryWeapon = "srifle_EBR_F";
            primaryAttachments[] = {"optic_DMS","bipod_01_F_blk"};
            primaryMagazine = "20Rnd_762x51_Mag";
            primaryMagazineCount = 5;

            secondaryWeapon = "Rangefinder";

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\srifle_ca.paa";
        };
        class DemolitionExpert: Rifleman {
            kitGroup = "Specialized";
            availableInGroups[] = {"Rifle"};

            backpack = "B_AssaultPack_rgr";

            items[] = {{"FirstAidKit", 2}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed", "DemoCharge_Remote_Mag", {"SatchelCharge_Remote_Mag", 2}};

            displayName = "Demolition Expert";

            UIIcon = "\A3\ui_f\data\gui\rsc\rscdisplayarsenal\primaryweapon_ca.paa";
        };
        class Engineer: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            displayName = "Engineer";

            isEngineer = 1;

            UIIcon = "a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
        };
        class AntiAir: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Weapon"};

            displayName = "AA Rifleman";

            secondaryWeapon = "launch_B_Titan_F";
            secondaryMagazine = "Titan_AA";
            secondaryMagazineCount = 2;
            backpack = "B_AssaultPack_rgr";

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\aa_ca.paa";
        };
        class LightAntiTank: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            secondaryWeapon = "launch_NLAW_F";
            secondaryMagazine = "NLAW_F";
            secondaryMagazineCount = 2;
            backpack = "B_AssaultPack_rgr";
            displayName = "LAT Rifleman";

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\at_ca.paa";
        };
        class HeavyAntiTank: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Weapon"};

            displayName = "HAT Rifleman";

            secondaryWeapon = "launch_B_Titan_short_F";
            secondaryMagazine = "Titan_AT";
            secondaryMagazineCount = 2;
            backpack = "B_TacticalPack_mcamo";
            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\at_ca.paa";
        };
        class HeavyMachineGun: AutomaticRifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Weapon"};

            displayName = "HMG Rifleman";
            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\mg_ca.paa";
        };
        class AmmoBearer: Rifleman {
            availableInGroups[] = {"Weapon"};

            displayName = "Ammo Bearer";

            backpack = "B_AssaultPack_rgr";
            items[] += {{"200Rnd_65x39_cased_Box_Tracer", 3}};
        };
        class Crewman: Rifleman {
            availableInGroups[] = {"Vehicle"};

            displayName = "Crewman";

            uniform = "U_B_HeliPilotCoveralls";
            headGear = "H_HelmetCrew_B";
            primaryMagazineCount = 2;

            isCrew = 1;
        };
        class Pilot: Rifleman {
            availableInGroups[] = {"Helicopter"};

            displayName = "Pilot";

            uniform = "U_B_HeliPilotCoveralls";
            headGear = "H_PilotHelmetHeli_B";
            primaryMagazineCount = 2;

            isPilot = 1;
        };
        class Sniper: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Recon"};

            displayName = "Sniper";

            uniform = "U_B_FullGhillie_lsh";
            backpack = "B_AssaultPack_rgr";

            primaryWeapon = "srifle_LRR_F";
            primaryAttachments[] = {"optic_LRPS","bipod_01_F_blk"};

            primaryMagazine = "7Rnd_408_Mag";
            primaryMagazineCount = 5;
            primaryMagazineTracerCount = 0;

            secondaryWeapon = "Rangefinder";

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\srifle_ca.paa";
            assignedItems[] += {"Rangefinder"};
        };
        class Spotter: Rifleman {
            availableInGroups[] = {"Recon"};

            displayName = "Spotter";
            UIIcon = "A3\ui_f\data\gui\rsc\rscdisplayarsenal\binoculars_ca.paa";

            uniform = "U_B_FullGhillie_lsh";
            primaryAttachments[] = {"optic_Arco"};
            secondaryWeapon = "Rangefinder";
            assignedItems[] += {"Rangefinder"};
        };
        class Specialist: Rifleman {
            availableInGroups[] = {"Recon"};

            displayName = "Specialist";
        };
    };
    class AAF {
        class Rifleman {
            scope = 1;
            kitGroup = "Unlimited";
            availableInGroups[] = {"Rifle", "Weapon", "Mortar"};

            // Display
            displayName = "Rifleman";
            icon = "";
            UIIcon = "\A3\ui_f\data\gui\rsc\rscdisplayarsenal\primaryweapon_ca.paa";
            mapIcon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
            compassIcon[] = {"a3\ui_f\data\map\Markers\Military\dot_ca.paa", 3.6};

            // Special attributes
            isLeader = 0;
            isMedic = 0;
            isEngineer = 0;
            isPilot = 0;
            isCrew = 0;

            // Primary weapon
            primaryWeapon = "arifle_Mk20_F";
            primaryAttachments[] = {"optic_ACO_grn","acc_pointer_IR"};
            primaryMagazine = "30Rnd_556x45_Stanag";
            primaryMagazineCount = 6;
            primaryMagazineTracer = "30Rnd_556x45_Stanag_Tracer_Green";
            primaryMagazineTracerCount = 0;

            // Secondary weapon
            secondaryWeapon = "";
            secondaryMagazine = "";
            secondaryMagazineCount = 0;

            // Handgun weapon
            handgunWeapon = "hgun_ACPC2_F";
            handgunMagazine = "9Rnd_45ACP_Mag";
            handgunMagazineCount = 2;

            // Uniform
            uniform = "U_I_CombatUniform";
            vest = "V_PlateCarrierIA1_dgtl";
            backpack = "";
            headGear = "H_HelmetIA_net";

            // Items
            assignedItems[] = {"ItemWatch", "ItemCompass", "ItemRadio", "ItemMap", "ItemGPS"};
            items[] = {"FirstAidKit","FirstAidKit","FirstAidKit", "HandGrenade","HandGrenade", "SmokeShell", "SmokeShell", "SmokeShellGreen", "SmokeShellRed"};
        };
        class Officer: Rifleman {
            availableInGroups[] = {"Rifle", "Weapon", "Mortar"};

            displayName = "Officer";

            isLeader = 1;

            secondaryWeapon = "Binocular";

            primaryAttachments[] = {"optic_MRCO","acc_pointer_IR"};
            backpack = "B_TacticalPack_rgr";
            items[] = {{"FirstAidKit", 3}, {"HandGrenade", 2}, {"SmokeShell", 4}, {"SmokeShellGreen", 3}, {"SmokeShellRed", 3}};
            icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
            UIIcon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
            mapIcon = "\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa";
            compassIcon[] = {"a3\ui_f\data\gui\cfg\ranks\corporal_gs.paa", 1.3};
        };
        class Medic: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle", "Weapon"};

            displayName = "Medic";
            //mapIcon = "";
            //compassIcon[] = {"a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa", 2};

            isMedic = 1;

            primaryWeapon = "arifle_Mk20C_F";

            icon = "\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa";
            UIIcon = "a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
            mapIcon = "\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa";
            compassIcon[] = {"a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa", 2};

            backpack = "B_TacticalPack_rgr";
            items[] = {{"FirstAidKit", 3}, {"Medikit", 1}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed"};
        };
        class AutomaticRifleman: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            displayName = "Automatic Rifleman";

            primaryWeapon = "LMG_Mk200_F";
            primaryAttachments[] = {"acc_pointer_IR","bipod_01_F_blk"};
            primaryMagazine = "200Rnd_65x39_cased_Box";
            primaryMagazineCount = 0;
            primaryMagazineTracer = "200Rnd_65x39_cased_Box_Tracer";
            primaryMagazineTracerCount = 3;
            backpack = "B_TacticalPack_rgr";
            items[] = {{"FirstAidKit", 2}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed"};

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\mg_ca.paa";
        };
        class Grenadier: Rifleman {
            kitGroup = "Specialized";
            availableInGroups[] = {"Rifle"};

            displayName = "Grenadier";

            primaryWeapon = "arifle_Mk20_GL_F";
            items[] += {{"1Rnd_HE_Grenade_shell", 6}, {"1Rnd_Smoke_Grenade_shell", 3}};

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\gl_ca.paa";
        };
        class Marksman: Rifleman {
            kitGroup = "Specialized";
            availableInGroups[] = {"Rifle"};

            displayName = "Marksman";

            primaryWeapon = "srifle_EBR_F";
            primaryAttachments[] = {"optic_DMS","bipod_01_F_blk"};

            primaryMagazine = "20Rnd_762x51_Mag";
            primaryMagazineCount = 5;

            secondaryWeapon = "Rangefinder";

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\srifle_ca.paa";
            assignedItems[] += {"Rangefinder"};
        };
    	class DemolitionExpert: Rifleman {
            kitGroup = "Specialized";
            availableInGroups[] = {"Rifle"};

            backpack = "B_TacticalPack_rgr";

            items[] = {{"FirstAidKit", 2}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed", "DemoCharge_Remote_Mag", {"SatchelCharge_Remote_Mag", 2}};

            displayName = "Demolition Expert";

            mapIcon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        };
        class Engineer: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            displayName = "Engineer";

            isEngineer = 1;
            items[] += {"ToolKit"};
            UIIcon = "a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
        };
        class AntiAir: Rifleman {
            kitGroup = "Specialized";
            availableInGroups[] = {"Weapon"};

            displayName = "AA Rifleman";

            secondaryWeapon = "launch_I_Titan_F";
            secondaryMagazine = "Titan_AA";
            secondaryMagazineCount = 2;
            backpack = "B_AssaultPack_dgtl";
            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\aa_ca.paa";
        };
        class LightAntiTank: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            displayName = "LAT Rifleman";

            secondaryWeapon = "launch_NLAW_F";
            secondaryMagazine = "NLAW_F";
            secondaryMagazineCount = 2;
            backpack = "B_AssaultPack_dgtl";

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\at_ca.paa";
        };
        class HeavyAntiTank: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Weapon"};

            displayName = "HAT Rifleman";

            secondaryWeapon = "launch_I_Titan_short_F";
            secondaryMagazine = "Titan_AT";
            secondaryMagazineCount = 2;
            backpack = "B_TacticalPack_ocamo";
            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\at_ca.paa";
        };
        class HeavyMachineGun: AutomaticRifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Weapon"};

            displayName = "HMG Rifleman";
            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\mg_ca.paa";
        };
        class AmmoBearer: Rifleman {
            availableInGroups[] = {"Weapon"};

            displayName = "Ammo Bearer";

            backpack = "B_TacticalPack_rgr";
            items[] = {{"200Rnd_65x39_cased_Box_Tracer", 3}};
        };
        class Crewman: Rifleman {
            availableInGroups[] = {"Vehicle"};

            displayName = "Crewman";

            uniform = "U_I_CombatUniform";
            headGear = "H_HelmetCrew_I";
            primaryMagazineCount = 2;

            isCrew = 1;
        };
        class Pilot: Rifleman {
            availableInGroups[] = {"Helicopter"};

            displayName = "Pilot";
            uniform = "U_I_PilotCoveralls";
            headGear = "H_PilotHelmetHeli_I";
            primaryMagazineCount = 2;

            isPilot = 1;
        };
        class Sniper: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Recon"};

            displayName = "Sniper";

            uniform = "U_I_GhillieSuit";
            backpack = "B_TacticalPack_ocamo";

            primaryWeapon = "srifle_GM6_F";
            primaryAttachments[] = {"optic_LRPS","bipod_01_F_blk"};

            primaryMagazine = "5Rnd_127x108_Mag";
            primaryMagazineCount = 7;
            primaryMagazineTracerCount = 0;

            secondaryWeapon = "Rangefinder";

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\srifle_ca.paa";
            assignedItems[] += {"Rangefinder"};


        };
        class Spotter: Rifleman {
            availableInGroups[] = {"Recon"};

            displayName = "Spotter";
            UIIcon = "A3\ui_f\data\gui\rsc\rscdisplayarsenal\binoculars_ca.paa";

            uniform = "U_I_GhillieSuit";
            primaryAttachments[] = {"optic_MRCO"};
            secondaryWeapon = "Rangefinder";
            assignedItems[] += {"Rangefinder"};
        };
        class Specialist: Rifleman {
            availableInGroups[] = {"Recon"};

            displayName = "Specialist";
        };
    };
    class CSAT {
        class Rifleman {
            scope = 1;
            kitGroup = "Unlimited";
            availableInGroups[] = {"Rifle", "Weapon", "Mortar"};

            // Display
            displayName = "Rifleman";
            icon = "";
            UIIcon = "\A3\ui_f\data\gui\rsc\rscdisplayarsenal\primaryweapon_ca.paa";
            mapIcon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
            compassIcon[] = {"a3\ui_f\data\map\Markers\Military\dot_ca.paa", 3.6};

            // Special attributes
            isLeader = 0;
            isMedic = 0;
            isEngineer = 0;
            isPilot = 0;
            isCrew = 0;

            // Primary weapon
            primaryWeapon = "arifle_Katiba_F";
            primaryAttachments[] = {"optic_ACO_grn","acc_pointer_IR"};
            primaryMagazine = "30Rnd_65x39_caseless_green";
            primaryMagazineCount = 0;
            primaryMagazineTracer = "30Rnd_65x39_caseless_green_mag_Tracer";
            primaryMagazineTracerCount = 5;

            // Secondary weapon
            secondaryWeapon = "";
            secondaryMagazine = "";
            secondaryMagazineCount = 0;

            // Handgun weapon
            handgunWeapon = "hgun_Rook40_F";
            handgunMagazine = "16Rnd_9x21_Mag";
            handgunMagazineCount = 2;

            // Uniform
            uniform = "U_O_CombatUniform_ocamo";
            vest = "V_HarnessO_brn";
            backpack = "";
            headGear = "H_HelmetO_ocamo";

            // Items
            assignedItems[] = {"ItemWatch", "ItemCompass", "ItemRadio", "ItemMap", "ItemGPS"};
            items[] = {"FirstAidKit","FirstAidKit","FirstAidKit", "HandGrenade","HandGrenade", "SmokeShell", "SmokeShell", "SmokeShellGreen", "SmokeShellRed"};
        };
        class Officer: Rifleman {
            availableInGroups[] = {"Rifle", "Weapon"};

            displayName = "Squad Leader";

            isLeader = 1;

            secondaryWeapon = "Binocular";

            primaryAttachments[] = {"optic_Hamr","acc_pointer_IR"};
            backpack = "B_TacticalPack_ocamo";
            items[] = {{"FirstAidKit", 3}, {"HandGrenade", 2}, {"SmokeShell", 4}, {"SmokeShellGreen", 3}, {"SmokeShellRed", 3}};
            icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
            UIIcon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
            mapIcon = "\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa";
            compassIcon[] = {"a3\ui_f\data\gui\cfg\ranks\corporal_gs.paa", 1.3};
        };
        class Medic: Rifleman {
            kitGroup = "Specialized";
            availableInGroups[] = {"Rifle", "Weapon"};

            displayName = "Medic";
            //mapIcon = "";
            //compassIcon[] = {"a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa", 2};

            isMedic = 1;

            primaryWeapon = "arifle_Katiba_C_F";

            icon = "\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa";
            UIIcon = "a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
            mapIcon = "\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa";
            compassIcon[] = {"a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa", 2};

            backpack = "B_TacticalPack_ocamo";
            items[] = {{"FirstAidKit", 3}, {"Medikit", 1}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed"};
        };
        class AutomaticRifleman: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            displayName = "Automatic Rifleman";

            primaryWeapon = "LMG_Zafir_F";
            primaryAttachments[] = {"acc_pointer_IR","bipod_01_F_blk"};
            primaryMagazine = "150Rnd_762x54_Box";
            primaryMagazineCount = 0;
            primaryMagazineTracer = "150Rnd_762x54_Box_Tracer";
            primaryMagazineTracerCount = 4;
            backpack = "B_TacticalPack_ocamo";
            items[] = {{"FirstAidKit", 2}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed"};

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\mg_ca.paa";
        };
        class Grenadier: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            displayName = "Grenadier";

            primaryWeapon = "arifle_Katiba_GL_F";
            items[] += {{"1Rnd_HE_Grenade_shell", 6}, {"1Rnd_Smoke_Grenade_shell", 3}};

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\gl_ca.paa";
        };
        class Marksman: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            displayName = "Marksman";

            primaryWeapon = "srifle_DMR_01_F";
            primaryAttachments[] = {"optic_DMS","bipod_01_F_blk"};

            primaryMagazine = "10Rnd_762x54_Mag";
            primaryMagazineCount = 10;

            secondaryWeapon = "Rangefinder";

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\srifle_ca.paa";
            assignedItems[] += {"Rangefinder"};
        };
        class DemolitionExpert: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            backpack = "B_TacticalPack_ocamo";

            items[] = {{"FirstAidKit", 2}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed", "DemoCharge_Remote_Mag", {"SatchelCharge_Remote_Mag", 2}};

            displayName = "Demolition Expert";

            mapIcon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        };
        class Engineer: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            displayName = "Engineer";

            isEngineer = 1;
            items[] += {"ToolKit"};
            UIIcon = "a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa";
        };
        class AntiAir: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            displayName = "AA Rifleman";

            secondaryWeapon = "launch_O_Titan_F";
            secondaryMagazine = "Titan_AA";
            secondaryMagazineCount = 2;
            backpack = "B_TacticalPack_ocamo";
            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\aa_ca.paa";
        };
        class LightAntiTank: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Rifle"};

            displayName = "LAT Rifleman";

            secondaryWeapon = "launch_RPG32_F";
            secondaryMagazine = "RPG32_F";
            secondaryMagazineCount = 2;
            backpack = "B_TacticalPack_ocamo";

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\at_ca.paa";
        };
        class HeavyAntiTank: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Weapon"};

            displayName = "HAT Rifleman";

            secondaryWeapon = "launch_O_Titan_short_F";
            secondaryMagazine = "Titan_AT";
            secondaryMagazineCount = 2;
            backpack = "B_TacticalPack_ocamo";
            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\at_ca.paa";
        };
        class HeavyMachineGun: AutomaticRifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Weapon"};

            displayName = "HMG Rifleman";
            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\mg_ca.paa";
        };
        class AmmoBearer: Rifleman {
            availableInGroups[] = {"Weapon"};

            displayName = "Ammo Bearer";

            backpack = "B_TacticalPack_ocamo";
            items[] = {{"150Rnd_762x54_Box", 3}};
        };
        class Crewman: Rifleman {
            availableInGroups[] = {"Vehicle", "Helicopter"};

            displayName = "Crewman";

            uniform = "U_O_CombatUniform_ocamo";
            headGear = "H_HelmetCrew_O";
            primaryMagazineCount = 2;

            isCrew = 1;
        };
        class Pilot: Rifleman {
            availableInGroups[] = {"Helicopter"};

            displayName = "Pilot";
            uniform = "U_O_PilotCoveralls";
            headGear = "H_PilotHelmetHeli_O";
            primaryMagazineCount = 2;

            isPilot = 1;
        };
        class Sniper: Rifleman {
            kitGroup = "Limited";
            availableInGroups[] = {"Recon"};

            displayName = "Sniper";

            uniform = "U_O_GhillieSuit";
            backpack = "B_TacticalPack_ocamo";

            primaryWeapon = "srifle_GM6_F";
            primaryAttachments[] = {"optic_LRPS","bipod_01_F_blk"};

            primaryMagazine = "5Rnd_127x108_Mag";
            primaryMagazineCount = 7;
            primaryMagazineTracerCount = 0;

            secondaryWeapon = "Rangefinder";

            UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\srifle_ca.paa";
            assignedItems[] += {"Rangefinder"};


        };
        class Spotter: Rifleman {
            availableInGroups[] = {"Recon"};

            displayName = "Spotter";
            UIIcon = "A3\ui_f\data\gui\rsc\rscdisplayarsenal\binoculars_ca.paa";

            uniform = "U_O_GhillieSuit";
            primaryAttachments[] = {"optic_Hamr"};
            secondaryWeapon = "Rangefinder";
            assignedItems[] += {"Rangefinder"};
        };
        class Specialist: Rifleman {
            availableInGroups[] = {"Recon"};

            displayName = "Specialist";
        };
    };
};
