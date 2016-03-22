class GroupTypes {
    class Rifle {
        displayName = "Rifle";
        groupSize = 9;
        requiredGroups = 0;
        requiredPlayers = 1;
    };
    class Weapon: Rifle {
        displayName = "Heavy";
        requiredGroups = 2;
        requiredPlayers = 15;
    };
    class Recon {
        displayName = "Recon";
        groupSize = 4;
        requiredGroups = 3;
        requiredPlayers = 20;
    };
    class Vehicle {
        displayName = "Crew";
        groupSize = 4;
        requiredGroups = 1;
        requiredPlayers = 10;
    };
    class Helicopter: Vehicle {
        displayName = "Heli";
        requiredPlayers = 15;
    };
    class Mortar {
        displayName = "Mortar";
        groupSize = 3;
        requiredGroups = 3;
        requiredPlayers = 20;
    };
};
class KitGroups {
    class Unlimited {
        requiredGroupMembersPerKit = 1;
    };
    class Limited {
        requiredGroupMembersPerKit = 2;
    };
    class Specialized {
        requiredGroupMembersPerKit = 4;
    };
};
