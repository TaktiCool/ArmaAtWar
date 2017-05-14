class cfgLogistics {

    class NATO {
        objectToSpawn[] = {"mainBaseFlagWest"};
        resources = 100; // at Beginning of Round
        resourcesMax = 500; // maximal resources
        resourceGrowth[] = {1, 12}; // [resources, per seconds]
        class MedicalBox {
            displayName = "Medical Box";
            classname = "Box_NATO_Ammo_F";
            content[] = {{"FirstAidKit", 30}};
            removeDefaultLoadout = 1;
            resources = 5;
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Basic Ammo Box";
            content[] = {{"30Rnd_65x39_caseless_mag", 40}, {"100Rnd_65x39_caseless_mag_Tracer", 8}, {"11Rnd_45ACP_Mag", 9}, {"1Rnd_HE_Grenade_shell", 8}, {"NLAW_F", 4}, {"1Rnd_Smoke_Grenade_shell", 4}, {"SmokeShell", 15}, {"SmokeShellGreen", 5}, {"SmokeShellRed", 5}, {"HandGrenade", 6}};
            removeDefaultLoadout = 1;
        };

        class AdvancedAmmoBox : MedicalBox {
            displayName = "Advanced Ammo Box";
            content[] = {{"30Rnd_65x39_caseless_mag", 10}, {"7Rnd_408_Mag", 10}, {"SmokeShell", 10},  {"HandGrenade", 3}};
            removeDefaultLoadout = 1;
        };

        class HeavyAmmoBox : MedicalBox {
            displayName = "Heavy Ammo Box";
            content[] = {{"NLAW_F", 6}, {"Titan_AT", 2}, {"Titan_AA", 2}};
            removeDefaultLoadout = 1;
            resources = 8;
        };

        class FOBBox {
            displayName = "FOB Box";
            classname = "B_CargoNet_01_ammo_F";
            content[] = {};
            removeDefaultLoadout = 1;
            resources = 50;
        };
    };

    class CSAT {
        objectToSpawn[] = {"mainBaseFlagEast"};
        resources = 100; // at Beginning of Round
        resourcesMax = 500; // maximal resources
        resourceGrowth[] = {1, 12}; // [resources, per seconds]
        class MedicalBox {
            displayName = "Medical Box";
            classname = "Box_East_Ammo_F";
            content[] = {{"FirstAidKit", 30}};
            removeDefaultLoadout = 1;
            resources = 5;
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Basic Ammo Box";
            content[] = {{"30Rnd_65x39_caseless_green", 40}, {"150Rnd_762x54_Box_Tracer", 5}, {"11Rnd_45ACP_Mag", 9}, {"1Rnd_HE_Grenade_shell", 8}, {"RPG32_F", 4}, {"1Rnd_Smoke_Grenade_shell", 4}, {"SmokeShell", 15}, {"SmokeShellGreen", 5}, {"SmokeShellRed", 5}, {"HandGrenade", 6}};
            removeDefaultLoadout = 1;
        };

        class AdvancedAmmoBox : MedicalBox {
            displayName = "Advanced Ammo Box";
            content[] = {{"30Rnd_65x39_caseless_green", 10}, {"5Rnd_127x108_Mag", 10}, {"SmokeShell", 20},  {"HandGrenade", 3}};
            removeDefaultLoadout = 1;
        };

        class HeavyAmmoBox : MedicalBox {
            displayName = "Heavy Ammo Box";
            content[] = {{"RPG32_F", 6}, {"Titan_AT", 2}, {"Titan_AA", 2}};
            removeDefaultLoadout = 1;
            resources = 8;
        };

        class FOBBox {
            displayName = "FOB Box";
            classname = "O_CargoNet_01_ammo_F";
            removeDefaultLoadout = 1;
            resources = 50;
        };
    };
    class AAF {
        objectToSpawn[] = {"mainBaseFlagGuer"};
        resources = 100; // at Beginning of Round
        resourcesMax = 500; // maximal resources
        resourceGrowth[] = {1, 12}; // [resources, per seconds]
        class MedicalBox {
          displayName = "Medical Box";
          classname = "Box_IND_Ammo_F";
          content[] = {{"FirstAidKit", 30}};
          removeDefaultLoadout = 1;
          resources = 5;
        };

        class BasicAmmoBox : MedicalBox {
          displayName = "Basic Ammo Box";
          content[] = {{"30Rnd_556x45_Stanag", 40}, {"200Rnd_65x39_cased_Box_Tracer", 4}, {"16Rnd_9x21_Mag", 9}, {"1Rnd_HE_Grenade_shell", 8}, {"NLAW_F", 4}, {"1Rnd_Smoke_Grenade_shell", 4}, {"SmokeShell", 15}, {"SmokeShellGreen", 5}, {"SmokeShellRed", 5}, {"HandGrenade", 6}};
          removeDefaultLoadout = 1;
        };

        class AdvancedAmmoBox : MedicalBox {
          displayName = "Advanced Ammo Box";
          content[] = {{"30Rnd_556x45_Stanag", 10}, {"5Rnd_127x108_Mag", 10}, {"SmokeShell", 20}, {"SmokeShellGreen", 10}, {"SmokeShellRed", 10}};
          removeDefaultLoadout = 1;
        };

        class HeavyAmmoBox : MedicalBox {
          displayName = "Heavy Ammo Box";
          content[] = {{"NLAW_F", 6}, {"Titan_AT", 2}, {"Titan_AA", 2}};
          removeDefaultLoadout = 1;
          resources = 8;
        };

        class FOBBox {
          displayName = "FOB Box";
          classname = "I_CargoNet_01_ammo_F";
          content[] = {};
          removeDefaultLoadout = 1;
          resources = 50;
        };
    };

};
