// ------------------------------------
// CSAT Tropic
// ------------------------------------
class CSAT_Tropic_StandardHandgun : CfgCLibLoadoutsClassBase {
    handgun[] = {"hgun_Pistol_01_F"};
    magazines[] = {{"11Rnd_45ACP_Mag", 2}};
};

class CSAT_Tropic_StandardAssaultRifle : CfgCLibLoadoutsClassBase {
    primaryWeapon[] = {"arifle_CTAR_ghex_F"};
    primaryWeaponOptics[] = {"optic_Aco"};
    primaryWeaponMuzzle[] = {"acc_pointer_IR"};
    magazines[] = {{"30Rnd_580x42_Mag_Tracer_F", 5}};
};


class CSAT_Tropic_StandardSoldier : A3_StandardSoldier {
    uniform[] = {"U_O_T_Soldier_F"};
    vest[] = {"V_HarnessO_ghex_F"};
    headgear[] = {"H_HelmetO_ghex_F"};


    class PrimaryWeaponClass : CSAT_Tropic_StandardAssaultRifle{};
    class HandgunClass : CSAT_Tropic_StandardHandgun{};
};

class CSAT_Tropic_Rifleman : CSAT_Tropic_StandardSoldier {
    items[] = {"HandGrenade"};
};

class CSAT_Tropic_SquadLeader : CSAT_Tropic_StandardSoldier {
    headgear[] = {"H_HelmetLeaderO_ghex_F"};
    linkedItems[] = {"Binocular"};

    class PrimaryWeaponClass : CSAT_Tropic_StandardAssaultRifle{
        primaryWeaponOptic[] = {"optic_Arco_ghex_F"};
    };

    class SignalGrenadesClass : A3_SignalGrenades{};
};

class CSAT_Tropic_Medic : CSAT_Tropic_StandardSoldier {
    backpack[] = {"B_FieldPack_ghex_F"};

    class MedicalsClass : A3_MedicClassMedicals{};
    class SignalGrenadesClass : A3_SignalGrenades{};
};

class CSAT_Tropic_AutomaticRifleman : CSAT_Tropic_StandardSoldier {
    class PrimaryWeaponClass : CSAT_Tropic_StandardAssaultRifle{
        primaryWeapon[] = {"arifle_CTARS_ghex_F"};
        primaryWeaponResting[] = {"bipod_01_F_blk"};
        magazines[] = {{"100Rnd_580x42_Mag_F", 3}};
    };
};

class CSAT_Tropic_Grenadier : CSAT_Tropic_StandardSoldier {
    class GrenadesClass : A3_GrenadierGrenades {};
    class PrimaryWeaponClass : CSAT_Tropic_StandardAssaultRifle{
        primaryWeapon[] = {"arifle_CTAR_GL_ghex_F"};
    };
};

class CSAT_Tropic_Marksman : CSAT_Tropic_StandardSoldier {
    class PrimaryWeaponClass : CSAT_Tropic_StandardAssaultRifle{
        primaryWeaponOptic[] = {"optic_Arco_ghex_F"};
        primaryWeaponResting[] = {"bipod_01_F_blk"};
    };
};

class CSAT_Tropic_AntiAir : CSAT_Tropic_StandardSoldier {
    backpack[] = {"B_FieldPack_ocamo"};
    secondaryWeapon[] = {"launch_O_Titan_F"};
    magazines[] = {{"Titan_AA", 2}};
};

class CSAT_Tropic_LightAntiTank : CSAT_Tropic_StandardSoldier {
    backpack[] = {"B_AssaultPack_ocamo"};
    secondaryWeapon[] = {"launch_RPG32_ghex_F"};
    magazines[] = {{"RPG32_F", 3}};
};

class CSAT_Tropic_AntiTank : CSAT_Tropic_StandardSoldier {
    backpack[] = {"B_FieldPack_ocamo"};
    secondaryWeapon[] = {"launch_O_Titan_short_ghex_F"};
    magazines[] = {{"Titan_AT", 2}};
};

class CSAT_Tropic_Crewman : CSAT_Tropic_StandardSoldier {
    headgear[] = {"H_HelmetCrew_O_ghex_F"};
    class PrimaryWeaponClass : CSAT_Tropic_StandardAssaultRifle{
        primaryWeapon[] = {"arifle_Katiba_C_F"};
        magazines[] = {{"30Rnd_65x39_caseless_green", 3}};
    };
};

class CSAT_Tropic_Pilot : CSAT_Tropic_Crewman {
    uniform[] = {"U_O_HeliPilotCoveralls"};
    headgear[] = {"H_PilotHelmetHeli_O"};
};

class CSAT_Tropic_Sniper : CSAT_Tropic_StandardSoldier {
    uniform[] = {"U_O_T_FullGhillie_tna_F"};
    class PrimaryWeaponClass : CSAT_Tropic_StandardAssaultRifle{
        primaryWeapon[] = {"srifle_GM6_F"};
        primaryWeaponOptic[] = {"optic_LRPS"};
        magazines[] = {{"5Rnd_127x108_Mag", 7}};
    };
};

class CSAT_Tropic_Spotter : CSAT_Tropic_StandardSoldier {
    uniform[] = {"U_O_T_FullGhillie_tna_F"};
    linkedItems[] = {"Rangefinder"};
    class PrimaryWeaponClass : CSAT_Tropic_StandardAssaultRifle{
        primaryWeaponOptic[] = {"optic_Hamr"};
        primaryWeaponResting[] = {"bipod_01_F_blk"};
    };
};
