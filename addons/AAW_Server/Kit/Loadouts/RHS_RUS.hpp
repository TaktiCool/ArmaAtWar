// ------------------------------------
// RHS_RUS
// ------------------------------------

class RHS_RUS_Rifleman {
    uniform[] = {"rhs_uniform_vkpo_gloves"};
    vest[] = {"rhs_6b45_rifleman"};
    headgear[] = {"rhs_6b47_emr_1"};
    //goggle[] = {};
    //backpack[] = {};
    primaryWeapon[] = {"rhs_weap_ak74m"};
    primaryWeaponOptic[] = {"rhs_acc_1p29"};
    //primaryWeaponMuzzle[] = {};
    primaryWeaponBarrel[] = {"rhs_acc_perst1ik"};
    //primaryWeaponResting[] = {};
    primaryWeaponLoadedMagazine[] = {"rhs_30Rnd_545x39_7N10_AK"};
    //secondaryWeapon[] = {};
    //secondaryWeaponOptic[] = {};
    //secondaryWeaponMuzzle[] = {};
    //secondaryWeaponBarrel[] = {};
    //secondaryWeaponResting[] = {};
    //secondaryWeaponLoadedMagazine[] = {};
    handgun[] = {"rhs_weap_pya"};
    //handgunOptic[] = {};
    //handgunMuzzle[] = {};
    //handgunBarrel[] = {};
    //handgunResting[] = {};
    handgunLoadedMagazine[] = {"rhs_mag_9x19_17"};
    //binocular[] = {};
    //magazines[] = {};
    //items[] = {};
    //itemsUniform[] = {};
    itemsVest[] = {{"rhs_30Rnd_545x39_7N10_AK", 5}, {"rhs_mag_9x19_17", 1}, {"rhs_mag_rgo",1}, {"rhssaf_mag_brd_m83_white", 2}, {"rhs_1PN138", 1}};
    //itemsBackpack[] = {};
    linkedItems[] = {"ItemWatch", "ItemCompass", "ItemMap"};

    removeAllWeapons = 1;
    removeAllItems = 1;
    removeAllAssignedItems = 1;
};

class RHS_RUS_LightAntiTank : RHS_RUS_Rifleman {
    secondaryWeapon[] = {"rhs_weap_rpg26"};
};

class RHS_RUS_SquadLeader : RHS_RUS_Rifleman {
    vest[] = {"rhs_6b45_off"};
    headgear[] = {"rhs_6b47_6m2_1"};
    backpack[] = {"rhs_rd54_emr1"};
    binocular[] = {"Binocular"};
    itemsBackpack[] = {{"rhssaf_mag_brd_m83_red", 1}, {"rhssaf_mag_brd_m83_green", 1}, {"rhs_mag_zarya2", 1}};
};

class RHS_RUS_Medic : RHS_RUS_Rifleman {
    backpack[] = {"rhs_tortila_emr"};
    itemsBackpack[] = {{"FirstAidKit", 4}, {"Medikit", 1}};
};

class RHS_RUS_AutomaticRifleman : RHS_RUS_Rifleman {
    vest[] = {"rhs_6b45_mg"};
    backpack[] = {"rhs_rk_sht_30_emr"};
    primaryWeapon[] = {"rhs_weap_rpk74m"};
    primaryWeaponOptic[] = {"rhs_acc_1p63"};
    primaryWeaponLoadedMagazine[] = {"rhs_45Rnd_545X39_7N6M_AK"};
    itemsVest[] = {{"rhs_mag_9x19_17", 1}, {"rhs_mag_rgo",1}, {"rhssaf_mag_brd_m83_white", 2}, {"rhs_1PN138", 1}};
    itemsBackpack[] = {{"rhs_45Rnd_545X39_7N6M_AK", 8}};
};

class RHS_RUS_Grenadier : RHS_RUS_Rifleman {
    vest[] = {"rhs_6b45_grn"};
    backpack[] = {"rhs_rd54_emr1"};
    primaryWeapon[] = {"rhs_weap_ak74m_gp25"};
    itemsBackpack[] = {{"rhs_VOG25", 10}, {"rhs_GRD40_Red", 1}, {"rhs_GRD40_White", 1}, {"rhs_VG40OP_white", 1}};
};

class RHS_RUS_Marksman : RHS_RUS_Rifleman {
    primaryWeapon[] = {"rhs_weap_svdp"};
    primaryWeaponOptic[] = {"rhs_acc_pso1m21"};
    primaryWeaponLoadedMagazine[] = {"rhs_10Rnd_762x54mmR_7N14"};
    itemsVest[] = {{"rhs_10Rnd_762x54mmR_7N14", 9}, {"rhs_mag_9x19_17", 1}, {"rhs_mag_rgo",1}, {"rhssaf_mag_brd_m83_white", 2}, {"rhs_1PN138", 1}};
};

class RHS_RUS_AntiAir : RHS_RUS_Rifleman {
    backpack[] = {"rhs_rk_sht_30_emr"};
    secondaryWeapon[] = {"rhs_weap_igla"};
    secondaryWeaponLoadedMagazine[] = {"rhs_mag_9k38_rocket"};
    itemsBackpack[] = {{"rhs_mag_9k38_rocket", 1}};
};

class RHS_RUS_AntiTank : RHS_RUS_AntiAir {
    backpack[] = {"rhs_rpg_6b3"};
    secondaryWeapon[] = {"rhs_weap_rpg7"};
    secondaryWeaponLoadedMagazine[] = {"rhs_rpg7_PG7VL_mag"};
    itemsBackpack[] = {{"rhs_rpg7_PG7VL_mag", 1}, {"rhs_rpg7_OG7V_mag", 1}};
};

class RHS_RUS_MachineGunner : RHS_RUS_AutomaticRifleman {
    primaryWeapon[] = {"rhs_weap_pkp"};
    primaryWeaponLoadedMagazine[] = {"150Rnd_762x54_Box_Tracer"};
    itemsBackpack[] = {{"150Rnd_762x54_Box_Tracer", 4}};
};

class RHS_RUS_AmmoBearer : RHS_RUS_Rifleman {
    backpack[] = {"rhs_rpg_6b3"};
    itemsBackpack[] = {{"rhs_mag_zarya2", 1}, {"rhssaf_mag_brd_m83_white", 1}, {"rhs_rpg7_PG7VL_mag", 2}, {"rhs_rpg7_OG7V_mag", 1}};
};

class RHS_RUS_Crewman : RHS_RUS_Rifleman {
    vest[] = {"rhs_6b45"};
    headgear[] = {"rhs_6b48"};
    primaryWeapon[] = {};
    itemsVest[] = {{"rhs_mag_9x19_17", 2}};
};

class RHS_RUS_Pilot : RHS_RUS_Crewman {
    headgear[] = {"H_PilotHelmetHeli_O"};
};

class RHS_RUS_Sniper : RHS_RUS_Marksman {
    uniform[] = {"U_O_FullGhillie_lsh"};
    primaryWeapon[] = {"rhs_weap_svdp_wd_npz"};
    primaryWeaponOptic[] = {"rhs_acc_dh520x56"};
    primaryWeaponLoadedMagazine[] = {"rhs_10Rnd_762x54mmR_7N14"};
    itemsVest[] = {{"rhs_10Rnd_762x54mmR_7N14", 10}, {"rhs_mag_9x19_17", 1}, {"rhs_mag_rgo",1}, {"rhssaf_mag_brd_m83_white", 2}, {"rhs_1PN138", 1}};
};

class RHS_RUS_Spotter : RHS_RUS_Rifleman {
    uniform[] = {"U_O_FullGhillie_lsh"};
    binocular[] = {"Rangefinder"};
};

class RHS_RUS_MortarGunner : RHS_RUS_Rifleman {
    backpack[] = {"RHS_Podnos_Gun_Bag"};
};

class RHS_RUS_MortarSupport : RHS_RUS_Rifleman {
    backpack[] = {"RHS_Podnos_Bipod_Bag"};
};
