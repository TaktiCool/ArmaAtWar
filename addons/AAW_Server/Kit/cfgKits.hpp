class cfgKits {
    class BaseRifleman {
        scope = 1;
        kitGroup = "Unlimited";
        availableInGroups[] = {"Rifle", "Weapon"};

        // Display
        displayName = "Rifleman";
        icon = "";
        UIIcon = "\A3\ui_f\data\gui\rsc\rscdisplayarsenal\primaryweapon_ca.paa";
        mapIcon = "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa";
        compassIcon[] = {"a3\ui_f\data\map\Markers\Military\dot_ca.paa", 3.6};

        // Special attributes
        isLeader = 0;
        isMedic = 0;
        isEngineer = 0;
        isPilot = 0;
        isCrew = 0;
    };
    class BaseSquadLeader: BaseRifleman {
        availableInGroups[] = {"Rifle", "Weapon"};

        displayName = "Squad Leader";
        icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
        UIIcon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
        mapIcon = "\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa";
        compassIcon[] = {"a3\ui_f\data\gui\cfg\ranks\corporal_gs.paa", 1.3};
        // Special attributes
        isLeader = 1;
    };
    class BaseMedic: BaseRifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Rifle", "Weapon"};

        displayName = "Medic";
        icon = "\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa";
        UIIcon = "a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
        mapIcon = "\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa";
        compassIcon[] = {"a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa", 2};
        // Special attributes
        isMedic = 1;
    };
    class BaseAutomaticRifleman: BaseRifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Rifle"};

        displayName = "Automatic Rifleman";
        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\mg_ca.paa";

    };
    class BaseGrenadier: BaseRifleman {
        kitGroup = "Specialized";
        availableInGroups[] = {"Rifle"};

        displayName = "Grenadier";
        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\gl_ca.paa";
    };
    class BaseMarksman: BaseRifleman {
        kitGroup = "Specialized";
        availableInGroups[] = {"Rifle"};

        displayName = "Marksman";
        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\srifle_ca.paa";
    };
    class BaseAntiAir: BaseRifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Weapon"};

        displayName = "Anti Air";
        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\aa_ca.paa";
    };
    class BaseLightAntiTank: BaseRifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Rifle"};

        displayName = "Light Anti Tank";
        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\at_ca.paa";
    };
    class BaseAntiTank: BaseRifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Weapon"};

        displayName = "Anti Tank";
        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\at_ca.paa";
    };
    class BaseMachineGunner: BaseAutomaticRifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Weapon"};

        displayName = "Machine Gunnner";
        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\mg_ca.paa";
    };
    class BaseAmmoBearer: BaseRifleman {
        availableInGroups[] = {"Weapon"};

        displayName = "Ammo Bearer";
    };
    class BaseCrewman: BaseRifleman {
        availableInGroups[] = {"Vehicle"};

        displayName = "Crewman";
        // Special attributes
        isCrew = 1;
    };
    class BasePilot: BaseRifleman {
        availableInGroups[] = {"Helicopter"};

        displayName = "Pilot";
        // Special attributes
        isPilot = 1;
    };

    class BaseSniper: BaseRifleman {
        kitGroup = "Limited";
        availableInGroups[] = {"Recon"};

        displayName = "Sniper";
        UIIcon = "a3\ui_f\data\IGUI\Cfg\WeaponIcons\srifle_ca.paa";
    };
    class BaseSpotter: BaseRifleman {
        availableInGroups[] = {"Recon"};

        displayName = "Spotter";
        UIIcon = "A3\ui_f\data\gui\rsc\rscdisplayarsenal\binoculars_ca.paa";
    };

    class BaseEngineer : BaseRifleman {
        availableInGroups[] = {"Logistic"};

        displayName = "Engineer";
        isEngineer = 1;
    };
    class BaseEngineerLead : BaseEngineer {
        displayName = "Lead Engineer";
        isLeader = 1;
    };

    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\AAF.hpp"
    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\CSAT_Tropic.hpp"
    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\CSAT.hpp"
    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\CTRG.hpp"
    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\NATO_Tropic.hpp"
    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\NATO.hpp"

    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\IFA3_GER.hpp"
    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\IFA3_RUS.hpp"
    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\IFA3_UK.hpp"
    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\IFA3_US.hpp"

    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\RHS_US.hpp"
    #include "\tc\AAW\addons\AAW_Server\Kit\Kits\RHS_RUS.hpp"
};
