class cfgLogistic {
    objectToSpawn[] = {"mainBaseFlagWest_0", "mainBaseFlagWest_1"};
    class MedicalBox {
      displayName = "Medical Box";
      classname = "Box_NATO_Ammo_F";
      content[] = {{"FirstAidKit", 20}, {"Medikit", 1}};
      removeDefaultLoadout = 1;
    };

    class BasicAmmoBox : MedicalBox {
      displayName = "Basic Ammo Box";
      content[] = {{"30Rnd_65x39_caseless_mag_Tracer", 30}, {"200Rnd_65x39_cased_Box_Tracer", 5}, {"11Rnd_45ACP_Mag", 9}, {"20Rnd_762x51_Mag", 5}, {"1Rnd_HE_Grenade_shell", 6}, {"NLAW_F", 2}, {"1Rnd_Smoke_Grenade_shell", 3}, {"SmokeShell", 10}, {"SmokeShellGreen", 5}, {"SmokeShellRed", 5}};
      removeDefaultLoadout = 1;
    };

    class AdvancedAmmoBox : MedicalBox {
      displayName = "Advanced Ammo Box";
      content[] = {{"30Rnd_65x39_caseless_mag_Tracer", 30}, {"7Rnd_408_Mag", 10}, {"SmokeShell", 20}, {"SmokeShellGreen", 10}, {"SmokeShellRed", 10}};
      removeDefaultLoadout = 1;
    };

    class HeavyAmmoBox : MedicalBox {
      displayName = "Heavy Ammo Box";
      content[] = {{"NLAW_F", 6}, {"Titan_AT", 2}, {"Titan_AA", 2}};
      removeDefaultLoadout = 1;
    };

    class FOBBox {
      displayName = "FOB Box";
      classname = "B_CargoNet_01_ammo_F";
      content[] = {};
      removeDefaultLoadout = 1;
    };
};
