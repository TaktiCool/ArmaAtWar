// ------------------------------------
// RHS_US
// ------------------------------------

class RHS_US_Rifleman {
    uniform[] = {"rhs_uniform_cu_ocp_101st"};
    vest[] = {"rhsusf_spcs_ocp_rifleman"};
    headgear[] = {"rhsusf_ach_helmet_ocp"};
    //goggle[] = {};
    //backpack[] = {};
    primaryWeapon[] = {"rhs_weap_m4a1_carryhandle"};
    primaryWeaponOptic[] = {"rhsusf_acc_ACOG"};
    //primaryWeaponMuzzle[] = {};
    primaryWeaponBarrel[] = {"rhsusf_acc_anpeq15_bk"};
    primaryWeaponResting[] = {"rhsusf_acc_grip3"};
    primaryWeaponLoadedMagazine[] = {"rhs_mag_30Rnd_556x45_M855A1_Stanag"};
    //secondaryWeapon[] = {};
    //secondaryWeaponOptic[] = {};
    //secondaryWeaponMuzzle[] = {};
    //secondaryWeaponBarrel[] = {};
    //secondaryWeaponResting[] = {};
    //secondaryWeaponLoadedMagazine[] = {};
    handgun[] = {"rhsusf_weap_m9"};
    //handgunOptic[] = {};
    //handgunMuzzle[] = {};
    //handgunBarrel[] = {};
    //handgunResting[] = {};
    handgunLoadedMagazine[] = {"rhsusf_mag_15Rnd_9x19_FMJ"};
    //binocular[] = {};
    //magazines[] = {};
    //items[] = {};
    //itemsUniform[] = {};
    itemsVest[] = {{"rhs_mag_30Rnd_556x45_M855A1_Stanag", 5}, {"rhsusf_mag_15Rnd_9x19_FMJ", 1}, {"rhs_mag_m67",1}, {"rhs_mag_an_m8hc", 2}, {"rhsusf_ANPVS_14", 1}};
    //itemsBackpack[] = {};
    linkedItems[] = {"ItemWatch", "ItemCompass", "ItemMap"};

    removeAllWeapons = 1;
    removeAllItems = 1;
    removeAllAssignedItems = 1;
};

class RHS_US_LightAntiTank : RHS_US_Rifleman {
    secondaryWeapon[] = {"rhs_weap_M136"};
};

class RHS_US_SquadLeader : RHS_US_Rifleman {
    vest[] = {"rhsusf_spcs_ocp_squadleader"};
    headgear[] = {"rhsusf_ach_helmet_headset_ocp"};
    backpack[] = {"B_AssaultPack_mcamo"};
    binocular[] = {"Binocular"};
    itemsBackpack[] = {{"rhs_mag_m18_red", 1}, {"rhs_mag_m18_green", 1}, {"rhs_mag_mk84", 1}};
};

class RHS_US_Medic : RHS_US_Rifleman {
    vest[] = {"rhsusf_spcs_ocp_medic"};
    backpack[] = {"B_Carryall_cbr"};
    itemsBackpack[] = {{"FirstAidKit", 4}, {"Medikit", 1}};
};

class RHS_US_AutomaticRifleman : RHS_US_Rifleman {
    vest[] = {"rhsusf_spcs_ocp_saw"};
    backpack[] = {"rhsusf_assault_eagleaiii_ocp"};
    primaryWeapon[] = {"rhs_weap_m249_pip_L"};
    primaryWeaponOptic[] = {"rhsusf_acc_ELCAN"};
    primaryWeaponBarrel[] = {"rhsusf_acc_anpeq16a"};
    primaryWeaponResting[] = {"rhsusf_acc_saw_bipod"};
    primaryWeaponLoadedMagazine[] = {"rhsusf_200Rnd_556x45_mixed_soft_pouch_coyote"};
    itemsVest[] = {{"rhsusf_mag_15Rnd_9x19_FMJ", 1}, {"rhs_mag_m67",1}, {"rhs_mag_an_m8hc", 2}, {"rhsusf_ANPVS_14", 1}};
    itemsBackpack[] = {{"rhsusf_200Rnd_556x45_mixed_soft_pouch_coyote", 3}};
};

class RHS_US_Grenadier : RHS_US_Rifleman {
    vest[] = {"rhsusf_spcs_ocp_grenadier"};
    backpack[] = {"B_AssaultPack_mcamo"};
    primaryWeapon[] = {"rhs_weap_m4a1_m320"};
    primaryWeaponResting[] = {""};
    itemsBackpack[] = {{"rhs_mag_M433_HEDP", 10}, {"rhs_mag_m713_Red", 1}, {"rhs_mag_m714_White", 1}, {"rhs_mag_M583A1_white", 1}};
};

class RHS_US_Marksman : RHS_US_Rifleman {
    vest[] = {"rhsusf_spcs_ocp_sniper"};
    primaryWeapon[] = {"arifle_SPAR_03_blk_F"};
    primaryWeaponOptic[] = {"rhsusf_acc_M8541_mrds"};
    primaryWeaponBarrel[] = {"rhsusf_acc_anpeq16a"};
    primaryWeaponResting[] = {"rhsusf_acc_harris_bipod"};
    primaryWeaponLoadedMagazine[] = {"20Rnd_762x51_Mag"};
    itemsVest[] = {{"20Rnd_762x51_Mag", 6}, {"rhsusf_mag_15Rnd_9x19_FMJ", 1}, {"rhs_mag_m67",1}, {"rhs_mag_an_m8hc", 2}, {"rhsusf_ANPVS_14", 1}};
};

class RHS_US_AntiAir : RHS_US_Rifleman {
    backpack[] = {"rhsusf_assault_eagleaiii_ocp"};
    secondaryWeapon[] = {"rhs_weap_fim92"};
    secondaryWeaponLoadedMagazine[] = {"rhs_fim92_mag"};
    itemsBackpack[] = {{"rhs_fim92_mag", 1}};
};

class RHS_US_AntiTank : RHS_US_AntiAir {
    secondaryWeapon[] = {"rhs_weap_maaws"};
    secondaryWeaponLoadedMagazine[] = {"rhs_mag_maaws_HEAT"};
    itemsBackpack[] = {{"rhs_mag_maaws_HEAT", 1}, {"rhs_mag_maaws_HEDP", 1}};
};

class RHS_US_MachineGunner : RHS_US_AutomaticRifleman {
    vest[] = {"rhsusf_spcs_ocp_machinegunner"};
    primaryWeapon[] = {"rhs_weap_m240B"};
    primaryWeaponLoadedMagazine[] = {"rhsusf_100Rnd_762x51_m62_tracer"};
    itemsBackpack[] = {{"rhsusf_100Rnd_762x51_m62_tracer", 6}};
};

class RHS_US_AmmoBearer : RHS_US_Rifleman {
    vest[] = {"rhsusf_spcs_ocp_teamleader"};
    backpack[] = {"B_Carryall_cbr"};
    itemsBackpack[] = {{"rhs_mag_mk84", 1}, {"rhs_mag_an_m8hc", 1}, {"rhs_mag_maaws_HEAT", 2}, {"rhs_mag_maaws_HEDP", 1}};
};

class RHS_US_Crewman : RHS_US_Rifleman {
    vest[] = {"rhsusf_spcs_ocp_crewman"};
    headgear[] = {"rhsusf_cvc_alt_helmet"};
    primaryWeapon[] = {};
    itemsVest[] = {{"rhsusf_mag_15Rnd_9x19_FMJ", 2}};
};

class RHS_US_Pilot : RHS_US_Crewman {
    headgear[] = {"rhsusf_hgu56p_visor_green"};
};

class RHS_US_Sniper : RHS_US_Marksman {
    uniform[] = {"U_B_FullGhillie_lsh"};
    primaryWeapon[] = {"rhs_weap_XM2010"};
    primaryWeaponOptic[] = {"optic_LRPS"};
    primaryWeaponLoadedMagazine[] = {"rhsusf_5Rnd_300winmag_xm2010"};
    itemsVest[] = {{"rhsusf_5Rnd_300winmag_xm2010", 10}, {"rhsusf_mag_15Rnd_9x19_FMJ", 1}, {"rhs_mag_m67",1}, {"rhs_mag_an_m8hc", 2}, {"rhsusf_ANPVS_14", 1}};
};

class RHS_US_Spotter : RHS_US_Rifleman {
    uniform[] = {"U_B_FullGhillie_lsh"};
    binocular[] = {"Rangefinder"};
};

class RHS_US_MortarGunner : RHS_US_Rifleman {
    backpack[] = {"rhs_M252_Gun_Bag"};
};

class RHS_US_MortarSupport : RHS_US_Rifleman {
    backpack[] = {"rhs_M252_Bipod_Bag"};
};
