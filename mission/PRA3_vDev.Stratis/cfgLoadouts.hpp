class Loadouts {
    class west {
        class Rifleman {
            scope = 1;

            // Special attributes
            isMedic = 0;
            isEngineer = 0;
            isPilot = 0;
            isVehicleCrew = 0;
            isLeader = 0;

            // Primary Weapon
            PrimaryWeapon = "arifle_MX_F";
            PrimaryAttachments[] = {"optic_Aco","acc_pointer_IR"};
            PrimaryMagazine = "30Rnd_65x39_caseless_mag";
            PrimaryMagazineTracer = " 30Rnd_65x39_caseless_mag_Tracer";
            PrimaryMagazineCount = 5;
            PrimaryMagazineTracerCount = 3;

            // SecoundaryWeapon
            SecoundaryWeapon = "";
            SecoundaryMagazine = "";
            SecoundaryMagazineCount = 0;

            // Hand Weapon
            HandWeapon = "hgun_Pistol_heavy_01_F";
            HandGundMagazine = "11Rnd_45ACP_Mag";
            HandGundMagazineCount = 2;

            // Uniform
            Uniform = "U_B_CombatUniform_mcam";
            Vest = "V_PlateCarrier2_rgr";
            Backpack = "";
            HeadGear = "H_HelmetB";

            AssignedItems[] = {"ItemWatch", "ItemCompass", "ItemRadio", "ItemMap", "ItemGPS"};
            Items[] = {{"FirstAidKit", 3}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed"};
        };
        class Leader: Rifleman {
            isLeader = 1;
            AssignedItems[] += {"Binocular"};
            PrimaryAttachments[] = {"optic_Hamr","acc_pointer_IR"};
            Backpack = "B_AssaultPack_rgr";
            Items[] = {{"FirstAidKit", 3}, {"HandGrenade", 2}, {"SmokeShell", 4}, {"SmokeShellGreen", 3}, {"SmokeShellRed", 3}};

        };
        class automaticrifleman: Rifleman {
            PrimaryWeapon = "LMG_Mk200_F";
            PrimaryAttachments[] = {"acc_pointer_IR","bipod_01_F_blk",""};
            PrimaryMagazine = "200Rnd_65x39_cased_Box";
            PrimaryMagazineTracer = "200Rnd_65x39_cased_Box_Tracer";
            PrimaryMagazineCount = 2;
            PrimaryMagazineTracerCount = 3;
            Backpack = "B_AssaultPack_rgr";
            Items[] = {{"FirstAidKit", 2}, {"HandGrenade", 2}, {"SmokeShell", 2}, "SmokeShellGreen", "SmokeShellRed"};
        };
        class Genadier: Rifleman {
            PrimaryWeapon = "arifle_MX_GL_F";
        };
        class Medic: Rifleman {
            isMedic = 1;
            PrimaryWeapon = "arifle_MXC_F";
            Backpack = "";
            AssignedItems[] += {};
        };
        class AntiTank: Rifleman {
            isLeader = 1;
            AssignedItems[] += {};
        };
    };
    class east: west;
};
