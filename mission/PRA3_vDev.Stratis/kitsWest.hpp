class Kits {
    class Rifleman {
        scope = 1;
        kitGroup = "Unlimited";
        availableInGroups[] = {"Rifle", "Weapon", "Mortar"};

        // Display
        displayName = "Rifleman";
        icon = "";
        UIIcon = "a3\ui_f\data\IGUI\Cfg\Actions\gear_ca.paa";

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
        primaryMagazineCount = 5;
        primaryMagazineTracer = "30Rnd_65x39_caseless_mag_Tracer";
        primaryMagazineTracerCount = 3;

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
    class Officer: Rifleman {
        availableInGroups[] = {"Rifle", "Weapon"};

        displayName = "Squad Leader";

        isLeader = 1;

        assignedItems[] += {"Binocular"};
        primaryAttachments[] = {"optic_Hamr","acc_pointer_IR"};
        backpack = "B_AssaultPack_rgr";
        items[] = {{"FirstAidKit", 3}, {"HandGrenade", 2}, {"SmokeShell", 4}, {"SmokeShellGreen", 3}, {"SmokeShellRed", 3}};
        icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
        UIIcon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
    };
    class Medic: Rifleman {
        kitGroup = "Specialized";
        availableInGroups[] = {"Rifle", "Weapon"};

        displayName = "Medic";

        isMedic = 1;

        primaryWeapon = "arifle_MXC_F";
        backpack = "B_AssaultPack_rgr";
        assignedItems[] += {};
        items[] = {{"FirstAidKit", 10}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed", "Medikit"};

        icon = "\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa";
        UIIcon = "a3\ui_f\data\Revive\medikit_ca.paa";
    };
    class AutomaticRifleman: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Rifle"};

        displayName = "Automatic Rifleman";

        primaryWeapon = "LMG_Mk200_F";
        primaryAttachments[] = {"acc_pointer_IR","bipod_01_F_blk"};
        primaryMagazine = "200Rnd_65x39_cased_Box";
        primaryMagazineCount = 2;
        primaryMagazineTracer = "200Rnd_65x39_cased_Box_Tracer";
        primaryMagazineTracerCount = 3;
        backpack = "B_AssaultPack_rgr";
        items[] = {{"FirstAidKit", 2}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed"};

        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\mg_ca.paa";
    };
    class Grenadier: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Rifle"};

        displayName = "Grenadier";

        primaryWeapon = "arifle_MX_GL_F";
        items[] += {{"1Rnd_HE_Grenade_shell", 6}};

        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\gl_ca.paa";
    };
    class Marksman: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Rifle"};

        displayName = "Marksman";

        primaryWeapon = "20Rnd_762x51_Mag";
        primaryAttachments[] = {"optic_DMS","bipod_01_F_blk"};
        primaryMagazine = "srifle_EBR_F";
        primaryMagazineCount = 5;

        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\srifle_ca.paa";
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
        availableInGroups[] = {"Rifle"};

        displayName = "AA Rifleman";

        secondaryWeapon = "launch_B_Titan_F";
        secondaryMagazine = "Titan_AA";
        secondaryMagazineCount = 1;
        backpack = "B_AssaultPack_rgr";

        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\aa_ca.paa";
    };
    class LightAntiTank: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Rifle"};

        secondaryWeapon = "launch_NLAW_F";
        secondaryMagazine = "NLAW_F";
        secondaryMagazineCount = 1;
        backpack = "B_AssaultPack_rgr";
        displayName = "LAT Rifleman";

        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\at_ca.paa";
    };
    class HeavyAntiTank: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Weapon"};

        displayName = "HAT Rifleman";
    };
    class HeavyMachineGun: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Weapon"};

        displayName = "HMG Rifleman";
    };
    class AmmoBearer: Rifleman {
        availableInGroups[] = {"Weapon"};

        displayName = "Ammo Bearer";
    };
    class Crewman: Rifleman {
        availableInGroups[] = {"Vehicle", "Helicopter"};

        displayName = "Crewman";

        isCrew = 1;
    };
    class Pilot: Rifleman {
        availableInGroups[] = {"Helicopter"};

        displayName = "Pilot";

        isPilot = 1;
    };
    class Sniper: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Recon"};

        displayName = "Sniper";
    };
    class Spotter: Rifleman {
        availableInGroups[] = {"Recon"};

        displayName = "Spotter";
    };
    class Specialist: Rifleman {
        availableInGroups[] = {"Recon"};

        displayName = "Specialist";
    };
    class MortarOperator: Rifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Mortar"};

        displayName = "Mortar Operator";
    };
};
