class TestLoadout : CfgCLibLoadoutsClassBase {
    uniform[] = {"U_B_CombatUniform_mcam"};
    vest[] = {"V_PlateCarrier1_rgr"};
    headgear[] = {"H_HelmetB_camo"};
    primaryWeapon[] = {"arifle_MX_F"};
    primaryWeaponOptic[] = {"optic_Hamr"};
    primaryWeaponLoadedMagazine[] = {"30Rnd_65x39_caseless_mag_Tracer"};
    handgun[] = {"hgun_P07_F"};
    handgunLoadedMagazine[] = {"16Rnd_9x21_Mag"};
    magazines[] = {{"16Rnd_9x21_Mag",3},{"30Rnd_65x39_caseless_mag_Tracer",8}};
    items[] = {{"ACE_EarPlugs", 1}, {"ACE_fieldDressing", 15}, {"ACE_morphine", 2},{"SmokeShellGreen", 1}, {"SmokeShellRed", 1}, {"MiniGrenade", 2}};
    linkedItems[] = {"ItemWatch","ItemCompass"};
    removeAllAssingedItems = 1;
};
