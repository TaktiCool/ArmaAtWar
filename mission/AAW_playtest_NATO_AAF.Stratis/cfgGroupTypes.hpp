class GroupTypes {
    class Rifle {
        displayName = "Rifle";
        groupSize = 9;
        requiredGroups = 0;
        requiredPlayers = 1;
        mapIcon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
    };
    class Weapon: Rifle {
        displayName = "Heavy";
        requiredGroups = 2;
        requiredPlayers = 15;

        mapIcon = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
    };
    class Recon {
        displayName = "Recon";
        groupSize = 4;
        requiredGroups = 3;
        requiredPlayers = 20;

        mapIcon = "\A3\ui_f\data\map\markers\nato\b_recon.paa";
    };
    class Vehicle {
        displayName = "Crew";
        groupSize = 4;
        requiredGroups = 1;
        requiredPlayers = 10;

        mapIcon = "\A3\ui_f\data\map\markers\nato\b_armor.paa";
    };
    class Helicopter: Vehicle {
        displayName = "Heli";
        requiredPlayers = 15;

        mapIcon = "\A3\ui_f\data\map\markers\nato\b_air.paa";
    };
    /* Disabled Until we have Units that fit in to the Logistic Group
    class Logistic {
        displayName = "Logistic";
        groupSize = 4;
        requiredGroups = 2;
        requiredPlayers = 10;

        mapIcon = "\A3\ui_f\data\map\markers\nato\b_support.paa";
    };
    */
};
