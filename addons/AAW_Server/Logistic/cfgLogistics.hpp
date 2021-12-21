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
            picture = "\A3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Basic Ammo Box";
            content[] = {{"30Rnd_65x39_caseless_mag", 40}, {"100Rnd_65x39_caseless_mag_Tracer", 8}, {"11Rnd_45ACP_Mag", 9}, {"1Rnd_HE_Grenade_shell", 8}, {"NLAW_F", 4}, {"1Rnd_Smoke_Grenade_shell", 4}, {"SmokeShell", 15}, {"SmokeShellGreen", 5}, {"SmokeShellRed", 5}, {"HandGrenade", 6}};
            picture = "\A3\ui_f\data\gui\cfg\respawnroles\assault_ca.paa";
        };

        class AdvancedAmmoBox : BasicAmmoBox {
            displayName = "Advanced Ammo Box";
            content[] = {{"30Rnd_65x39_caseless_mag", 10}, {"7Rnd_408_Mag", 10}, {"SmokeShell", 10},  {"HandGrenade", 3}};
        };

        class HeavyAmmoBox : BasicAmmoBox {
            displayName = "Heavy Ammo Box";
            content[] = {{"NLAW_F", 6}, {"Titan_AT", 2}, {"Titan_AA", 2}};
            resources = 8;
        };

        class FOBBox {
            displayName = "FOB Box";
            classname = "B_CargoNet_01_ammo_F";
            content[] = {};
            removeDefaultLoadout = 1;
            resources = 50;
            picture = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
        };

        class MortarBox {
            displayName = "Mortar Box";
            classname = "Box_NATO_Wps_F";
            content[] = {{"B_Mortar_01_support_F", 1}, {"B_Mortar_01_weapon_F", 1}};
            removeDefaultLoadout = 1;
            resources = 50;
            picture = "\A3\modules_f_curator\data\portraitordnancemortar_ca.paa";
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
            picture = "\A3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Basic Ammo Box";
            content[] = {{"30Rnd_65x39_caseless_green", 40}, {"150Rnd_762x54_Box_Tracer", 5}, {"11Rnd_45ACP_Mag", 9}, {"1Rnd_HE_Grenade_shell", 8}, {"RPG32_F", 4}, {"1Rnd_Smoke_Grenade_shell", 4}, {"SmokeShell", 15}, {"SmokeShellGreen", 5}, {"SmokeShellRed", 5}, {"HandGrenade", 6}};
            picture = "\A3\ui_f\data\gui\cfg\respawnroles\assault_ca.paa";
        };

        class AdvancedAmmoBox : BasicAmmoBox {
            displayName = "Advanced Ammo Box";
            content[] = {{"30Rnd_65x39_caseless_green", 10}, {"5Rnd_127x108_Mag", 10}, {"SmokeShell", 20},  {"HandGrenade", 3}};
        };

        class HeavyAmmoBox : BasicAmmoBox {
            displayName = "Heavy Ammo Box";
            content[] = {{"RPG32_F", 6}, {"Titan_AT", 2}, {"Titan_AA", 2}};
            resources = 8;
        };

        class FOBBox {
            displayName = "FOB Box";
            classname = "O_CargoNet_01_ammo_F";
            removeDefaultLoadout = 1;
            resources = 50;
            picture = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
        };

        class MortarBox {
            displayName = "Mortar Box";
            classname = "Box_East_Wps_F";
            content[] = {{"O_Mortar_01_support_F", 1}, {"O_Mortar_01_weapon_F", 1}};
            removeDefaultLoadout = 1;
            resources = 50;
            picture = "\A3\modules_f_curator\data\portraitordnancemortar_ca.paa";
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
          picture = "\A3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
        };

        class BasicAmmoBox : MedicalBox {
          displayName = "Basic Ammo Box";
          content[] = {{"30Rnd_556x45_Stanag", 40}, {"200Rnd_65x39_cased_Box_Tracer", 4}, {"16Rnd_9x21_Mag", 9}, {"1Rnd_HE_Grenade_shell", 8}, {"NLAW_F", 4}, {"1Rnd_Smoke_Grenade_shell", 4}, {"SmokeShell", 15}, {"SmokeShellGreen", 5}, {"SmokeShellRed", 5}, {"HandGrenade", 6}};
          picture = "\A3\ui_f\data\gui\cfg\respawnroles\assault_ca.paa";
        };

        class AdvancedAmmoBox : BasicAmmoBox {
          displayName = "Advanced Ammo Box";
          content[] = {{"30Rnd_556x45_Stanag", 10}, {"5Rnd_127x108_Mag", 10}, {"SmokeShell", 20}, {"SmokeShellGreen", 10}, {"SmokeShellRed", 10}};
        };

        class HeavyAmmoBox : BasicAmmoBox {
          displayName = "Heavy Ammo Box";
          content[] = {{"NLAW_F", 6}, {"Titan_AT", 2}, {"Titan_AA", 2}};
          resources = 8;
        };

        class FOBBox {
          displayName = "FOB Box";
          classname = "I_CargoNet_01_ammo_F";
          content[] = {};
          removeDefaultLoadout = 1;
          resources = 50;
          picture = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
        };

        class MortarBox {
            displayName = "Mortar Box";
            classname = "Box_IND_Wps_F";
            content[] = {{"I_Mortar_01_support_F", 1}, {"I_Mortar_01_weapon_F", 1}};
            removeDefaultLoadout = 1;
            resources = 50;
            picture = "\A3\modules_f_curator\data\portraitordnancemortar_ca.paa";
        };
    };

    class RHS_US {
        objectToSpawn[] = {"mainBaseFlagWest"};
        resources = 100; // at Beginning of Round
        resourcesMax = 500; // maximal resources
        resourceGrowth[] = {1, 12}; // [resources, per seconds]

        class FOBBox {
            displayName = "FOB Box";
            classname = "B_CargoNet_01_ammo_F";
            content[] = {};
            removeDefaultLoadout = 1;
            resources = 50;
            picture = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
        };

        class MedicalBox {
            displayName = "Medical Box";
            classname = "Box_NATO_Ammo_F";
            content[] = {{"FirstAidKit", 30}};
            removeDefaultLoadout = 1;
            resources = 5;
            picture = "\A3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Basic Ammo Box";
            content[] = {
                {"rhs_mag_30Rnd_556x45_M855A1_Stanag", 30},
                {"rhsusf_200Rnd_556x45_mixed_soft_pouch_coyote", 4},
                {"20Rnd_762x51_Mag", 8},
                {"rhsusf_mag_15Rnd_9x19_FMJ", 9},
                {"rhs_mag_M433_HEDP", 8},
                {"rhs_mag_m714_White", 4},
                {"rhs_mag_m67", 6},
                {"rhs_mag_an_m8hc", 15},
                {"rhs_mag_m18_red", 5},
                {"rhs_mag_m18_green", 5}
            };
            picture = "\A3\ui_f\data\gui\cfg\respawnroles\assault_ca.paa";
        };

        class AdvancedAmmoBox : BasicAmmoBox {
            displayName = "Advanced Ammo Box";
            content[] = {
                {"rhsusf_100Rnd_762x51_m62_tracer", 10},
                {"rhsusf_5Rnd_300winmag_xm2010", 15},
                {"rhs_mag_an_m8hc", 10},
                {"rhs_mag_m67", 3}
            };
        };

        class HeavyAmmoBox : BasicAmmoBox {
            displayName = "Heavy Ammo Box";
            content[] = {
                {"rhs_weap_M136", 3},
                {"rhs_mag_maaws_HEAT", 2},
                {"rhs_fim92_mag", 2}
            };
            resources = 8;
        };
    };

    class RHS_RUS {
        objectToSpawn[] = {"mainBaseFlagEast"};
        resources = 100; // at Beginning of Round
        resourcesMax = 500; // maximal resources
        resourceGrowth[] = {1, 12}; // [resources, per seconds]

        class FOBBox {
            displayName = "FOB Box";
            classname = "O_CargoNet_01_ammo_F";
            removeDefaultLoadout = 1;
            resources = 50;
            picture = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
        };

        class MedicalBox {
            displayName = "Medical Box";
            classname = "Box_East_Ammo_F";
            content[] = {{"FirstAidKit", 30}};
            removeDefaultLoadout = 1;
            resources = 5;
            picture = "\A3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Basic Ammo Box";
            content[] = {
                {"rhs_30Rnd_545x39_7N10_AK", 30},
                {"rhs_45Rnd_545X39_7N6M_AK", 20},
                {"rhs_10Rnd_762x54mmR_7N14", 15},
                {"rhs_mag_9x19_17", 9},
                {"rhs_VOG25", 8},
                {"rhs_GRD40_White", 4},
                {"rhs_mag_rgo", 6},
                {"rhssaf_mag_brd_m83_white", 15},
                {"rhssaf_mag_brd_m83_red", 5},
                {"rhssaf_mag_brd_m83_green", 5}
            };
            picture = "\A3\ui_f\data\gui\cfg\respawnroles\assault_ca.paa";
        };

        class AdvancedAmmoBox : BasicAmmoBox {
            displayName = "Advanced Ammo Box";
            content[] = {
                {"150Rnd_762x54_Box_Tracer", 6},
                {"rhs_10Rnd_762x54mmR_7N14", 8},
                {"rhssaf_mag_brd_m83_white", 10},
                {"rhs_mag_rgo", 3}
            };
        };

        class HeavyAmmoBox : BasicAmmoBox {
            displayName = "Heavy Ammo Box";
            content[] = {
                {"rhs_weap_rpg26", 3},
                {"rhs_rpg7_PG7VL_mag", 2},
                {"rhs_mag_9k38_rocket", 2}
            };
            resources = 8;
        };
    };
};
