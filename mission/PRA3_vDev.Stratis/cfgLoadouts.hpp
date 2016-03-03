class Loadouts {
    class West {
        class Rifleman {

            scope = 1;
            displayName = "Rifleman";

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
            primarySecoundMagazine = "";
            primarySecoundMagazineCount = 0;

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
            isLeader = 1;
            assignedItems[] += {"Binocular"};
            primaryAttachments[] = {"optic_Hamr","acc_pointer_IR"};
            backpack = "B_AssaultPack_rgr";
            items[] = {{"FirstAidKit", 3}, {"HandGrenade", 2}, {"SmokeShell", 4}, {"SmokeShellGreen", 3}, {"SmokeShellRed", 3}};

        };
        class AutomaticRifleman: Rifleman {
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
            primaryWeapon = "arifle_MX_GL_F";
        };
        class Medic: Rifleman {
            isMedic = 1;
            primaryWeapon = "arifle_MXC_F";
            backpack = "";
            assignedItems[] += {};
        };
        class AntiTank: Rifleman {
            isLeader = 1;
            assignedItems[] += {};
        };
    };
    class East : West {
    };
};
