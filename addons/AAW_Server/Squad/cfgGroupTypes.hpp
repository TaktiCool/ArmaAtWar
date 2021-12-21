class CfgGroupTypes {
    activeGroupTypes[] = {"Rifle", "Weapon", "Recon", "Vehicle", "Helicopter", "Mortar", "Logistic"};
    class Rifle {
        displayName = "Rifle";
        groupSize = 9;
        requiredGroups = 0;
        requiredPlayers = 1;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
        maxGroupsOfType = 0;
    };
    class Weapon: Rifle {
        displayName = "Heavy";
        requiredGroups = 0;
        requiredPlayers = 10;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
        maxGroupsOfType = 0;
    };
    class Recon {
        displayName = "Recon";
        groupSize = 4;
        requiredGroups = 0;
        requiredPlayers = 50;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_recon.paa";
        maxGroupsOfType = 0;
    };
    class Vehicle {
        displayName = "Crew";
        groupSize = 4;
        requiredGroups = 0;
        requiredPlayers = 30;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_armor.paa";
        maxGroupsOfType = 0;
    };
    class Helicopter: Vehicle {
        displayName = "Heli";
        requiredPlayers = 30;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_air.paa";
        maxGroupsOfType = 0;
    };
    class Mortar {
        displayName = "Mortar";
        groupSize = 4;
        requiredGroups = 0;
        requiredPlayers = 40;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_mortar.paa";
        maxGroupsOfType = 0;
    };

    class Logistic {
        displayName = "Logistic";
        groupSize = 4;
        requiredGroups = 0;
        requiredPlayers = 10;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_support.paa";
        maxGroupsOfType = 0;
    };
};
