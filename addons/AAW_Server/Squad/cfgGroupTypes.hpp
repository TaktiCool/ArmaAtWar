class CfgGroupTypes {
    activeGroupTypes[] = {"Rifle", "Weapon", "Recon", "Vehicle", "Helicopter", "Mortar", "Logistic"};
    class Rifle {
        displayName = "Rifle";
        groupSize = 9;
        requiredGroups = 0;
        requiredPlayers = 1;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
    };
    class Weapon: Rifle {
        displayName = "Heavy";
        requiredGroups = 0;
        requiredPlayers = 10;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
    };
    class Recon {
        displayName = "Recon";
        groupSize = 4;
        requiredGroups = 0;
        requiredPlayers = 50;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_recon.paa";
    };
    class Vehicle {
        displayName = "Crew";
        groupSize = 4;
        requiredGroups = 0;
        requiredPlayers = 30;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_armor.paa";
    };
    class Helicopter: Vehicle {
        displayName = "Heli";
        requiredPlayers = 30;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_air.paa";
    };
    class Mortar {
        displayName = "Mortar";
        groupSize = 4;
        requiredGroups = 0;
        requiredPlayers = 40;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_mortar.paa";
    };

    class Logistic {
        displayName = "Logistic";
        groupSize = 4;
        requiredGroups = 0;
        requiredPlayers = 10;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_support.paa";
    };
};
