class CSAT_Tropic {
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
        primaryWeapon = "arifle_CTAR_ghex_F";
        primaryAttachments[] = {"optic_Aco","acc_pointer_IR"};
        primaryMagazine = "30Rnd_580x42_Mag_F";
        primaryMagazineCount = 7;
        primaryMagazineTracer = "30Rnd_580x42_Mag_Tracer_F";
        primaryMagazineTracerCount = 0;

        // Secondary weapon
        secondaryWeapon = "";
        secondaryMagazine = "";
        secondaryMagazineCount = 0;

        // Handgun weapon
        handgunWeapon = "hgun_Pistol_01_F";
        handgunMagazine = "11Rnd_45ACP_Mag";
        handgunMagazineCount = 2;

        // Uniform
        uniform = "U_O_T_Soldier_F";
        vest = "V_HarnessO_ghex_F";
        backpack = "";
        headGear = "H_HelmetO_ghex_F";

        // Items
        assignedItems[] = {"ItemWatch", "ItemCompass", "ItemRadio", "ItemMap", "ItemGPS"};
        items[] = {{"FirstAidKit",2}, {"HandGrenade",2}, {"SmokeShell", 2}};
    };
    class Officer: Rifleman {
        availableInGroups[] = {"Rifle", "Weapon", "Mortar"};

        displayName = "Squad Leader";

        headGear = "H_HelmetLeaderO_ghex_F";

        isLeader = 1;

        secondaryWeapon = "Binocular";
        primaryMagazineCount = 5;

        primaryAttachments[] = {"optic_Arco_ghex_F","acc_pointer_IR"};

        items[] = {{"FirstAidKit", 2}, {"HandGrenade", 1}, {"SmokeShell", 2}, "SmokeShellRed", "SmokeShellGreen"};
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

        primaryMagazineCount = 5;
        backpack = "B_FieldPack_ghex_F";
        items[] = {{"FirstAidKit", 4}, {"HandGrenade", 1}, {"SmokeShell", 4}, "SmokeShellRed", "SmokeShellGreen", "Medikit"};

        icon = "\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa";
        UIIcon = "a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
        mapIcon = "\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa";
        compassIcon[] = {"a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa", 2};
    };
    class AutomaticRifleman: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Rifle"};

        displayName = "Automatic Rifleman";

        primaryWeapon = "arifle_CTARS_ghex_F";
        primaryAttachments[] = {"optic_Aco","acc_pointer_IR"};
        primaryMagazine = "100Rnd_580x42_Mag_F";
        primaryMagazineCount = 0;
        primaryMagazineTracer = "100Rnd_580x42_Mag_Tracer_F";
        primaryMagazineTracerCount = 2;
        //backpack = "B_AssaultPack_rgr";
        items[] = {{"FirstAidKit", 2}, {"HandGrenade", 1}, {"SmokeShell", 2}};

        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\mg_ca.paa";
    };
    class Grenadier: Rifleman {
        kitGroup = "Specialized";
        availableInGroups[] = {"Rifle"};

        displayName = "Grenadier";

        primaryWeapon = "arifle_CTAR_GL_ghex_F";
        items[] = {{"FirstAidKit",2}, {"HandGrenade",2}, {"SmokeShell", 2}, {"1Rnd_HE_Grenade_shell", 8}, {"1Rnd_Smoke_Grenade_shell", 4}, {"1Rnd_SmokeRed_Grenade_shell", 2}, {"1Rnd_SmokeGreen_Grenade_shell", 2}};

        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\gl_ca.paa";
    };
    class Marksman: Rifleman {
        kitGroup = "Specialized";
        availableInGroups[] = {"Rifle"};

        displayName = "Marksman";

        primaryAttachments[] = {"optic_Arco_ghex_F"};
        primaryMagazineCount = 5;

        items[] = {{"FirstAidKit", 2}, {"HandGrenade", 1}, {"SmokeShell", 2}};

        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\srifle_ca.paa";
    };
    class AntiAir: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Weapon"};

        displayName = "AA Rifleman";

        secondaryWeapon = "launch_O_Titan_ghex_F";
        secondaryMagazine = "Titan_AA";
        secondaryMagazineCount = 2;
        backpack = "B_FieldPack_ocamo";
        primaryMagazineCount = 5;
        items[] = {{"FirstAidKit", 2}, {"HandGrenade", 1}, {"SmokeShell", 2}};
        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\aa_ca.paa";
    };
    class LightAntiTank: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Rifle"};
        primaryMagazineCount = 5;
        secondaryWeapon = "launch_RPG32_ghex_F";
        secondaryMagazine = "RPG32_F";
        secondaryMagazineCount = 3;
        backpack = "B_AssaultPack_ocamo";
        displayName = "LAT Rifleman";
        items[] = {{"FirstAidKit", 2}, {"HandGrenade", 1}, {"SmokeShell", 2}};
        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\at_ca.paa";
    };
    class HeavyAntiTank: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Weapon"};

        displayName = "HAT Rifleman";
        primaryMagazineCount = 5;
        secondaryWeapon = "launch_O_Titan_short_ghex_F";
        secondaryMagazine = "Titan_AT";
        secondaryMagazineCount = 2;
        items[] = {{"FirstAidKit", 2}, {"HandGrenade", 1}, {"SmokeShell", 2}};
        backpack = "B_FieldPack_ocamo";
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

        backpack = "B_AssaultPack_ocamo";
        items[] = {{"FirstAidKit",2}, {"HandGrenade",2}, {"SmokeShell", 2}, {"100Rnd_580x42_Mag_Tracer_F", 3}};
    };
    class Crewman: Rifleman {
        availableInGroups[] = {"Vehicle"};

        displayName = "Crewman";

        headGear = "H_HelmetCrew_O_ghex_F";
        primaryMagazineCount = 3;
        vest = "";

        items[] = {{"FirstAidKit", 2}, {"SmokeShell", 2}};

        isCrew = 1;
    };
    class HelicopterPilot: Rifleman {
        availableInGroups[] = {"Helicopter"};

        displayName = "Pilot";

        primaryWeapon = "arifle_MXC_F";

        uniform = "U_O_HeliPilotCoveralls";
        headGear = "H_PilotHelmetHeli_B";
        primaryMagazineCount = 3;
        vest = "";

        items[] = {{"FirstAidKit", 2}, {"SmokeShell", 2}};

        isPilot = 1;
    };

    class Sniper: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Recon"};

        displayName = "Sniper";

        uniform = "U_O_T_FullGhillie_tna_F";

        primaryWeapon = "srifle_GM6_F";
        primaryAttachments[] = {"optic_LRPS"};

        primaryMagazine = "5Rnd_127x108_Mag";
        primaryMagazineCount = 7;
        primaryMagazineTracerCount = 0;

        items[] = {{"FirstAidKit", 2}, {"HandGrenade", 1}, {"SmokeShell", 1}};

        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\srifle_ca.paa";
    };
    class Spotter: Rifleman {
        availableInGroups[] = {"Recon"};

        displayName = "Spotter";
        UIIcon = "A3\ui_f\data\gui\rsc\rscdisplayarsenal\binoculars_ca.paa";

        uniform = "U_O_T_FullGhillie_tna_F";
        secondaryWeapon = "Rangefinder";

        primaryAttachments[] = {"optic_Hamr"};
        primaryMagazineCount = 5;
        primaryMagazineTracerCount = 0;

        items[] = {{"FirstAidKit", 2}, {"HandGrenade", 1}, {"SmokeShell", 1}};
    };
    class Specialist: Rifleman {
        availableInGroups[] = {"Recon"};

        displayName = "Specialist";
    };
};
