class defaultVehicle {
    respawnCondition = "true";
    side = "UNKNOWN";
    respawnTime = -1; // disabled
    ticketValue = 2;
    abandonedVehicleRadius = 200;
    abandonedVehicleTime = 300;
};

class defaultWest : defaultVehicle {
    side = "WEST";
};

class defaultEast : defaultVehicle {
    side = "EAST";
};

class defaultIndependent : defaultVehicle {
    side = "INDEPENDENT";
};

class CfgEntities {

    // mission objects
    // -- Blufor -- //
    // Cars
    class vr_hunter_0 : defaultWest {
        respawnTime = 300;
        ticketValue = 25;
    };
    class vr_hunter_1: vr_hunter_0 {};

    class vr_hunterHMG_0 : defaultWest {
        respawnTime = 600;
        ticketValue = 50;
    };
    class vr_hunterHMG_1 : vr_hunterHMG_0 {
        ticketValue = 50;
    };

    class vr_hunterGMG_0 : vr_hunterHMG_0 {};


    // Trucks
    class vr_HEMMTTrans_0: vr_hunter_0 {
        respawnTime = 180;
        ticketValue = 15;
    };
    class vr_HEMMTTrans_1: vr_HEMMTTrans_0 {};

    class vr_HEMMTRep_0: vr_HEMMTTrans_0 {};
    class vr_HEMMTFuel_0: vr_HEMMTTrans_0 {};
    class vr_HEMMTAmmo_0: vr_HEMMTTrans_0 {};

    // Tanks
    class vr_marshall_0 : vr_hunter_0 {
        respawnTime = 600;
        ticketValue = 75;
    };

    class vr_panther_0 : vr_marshall_0 {};

    class vr_slammer_0 : vr_hunter_0 {
        respawnTime = 900;
        ticketValue = 75;
    };


    // Air
    class vr_ghosthawk_0 : defaultWest {
        respawnTime = 600;
        ticketValue = 50;
    };
    class vr_ghosthawk_1 : vr_ghosthawk_0 {};

    class vr_pawnee_0 : vr_ghosthawk_0 {
        respawnTime = 900;
        ticketValue = 75;
    };


    // -- AAF -- //
    // Car
    class vr_strider_0 : defaultIndependent {
        ticketValue = 20;
        respawnTime = 300;
    };
    class vr_strider_1: vr_strider_0 {};

    class vr_striderHMG_0 : vr_strider_0 {
        ticketValue = 50;
    };
    class vr_striderHMG_1 : vr_striderHMG_0 {};

    class vr_striderGMG_1 : vr_striderHMG_0 {};

    // Trucks
    class vr_ZamakTrans_0: vr_strider_0 {
        ticketValue = 20;
        respawnTime = 180;
    };
    class vr_ZamakTrans_1: vr_ZamakTrans_0 {};

    class vr_ZamakRep_0: vr_ZamakTrans_0 {};
    class vr_ZamakFuel_0: vr_ZamakTrans_0 {};
    class vr_ZamakAmmo_0: vr_ZamakTrans_0 {};

    // Tanks
    class vr_gorgon_0 : vr_strider_0 {
        respawnTime = 600;
        ticketValue = 75;
    };

    class vr_mora_0 : vr_gorgon_0 {};

    class vr_kuma_0 : vr_strider_0 {
        respawnTime = 900;
        ticketValue = 100;
    };

    // Air
    class vr_mohawk_0 : defaultEast {
        respawnTime = 600;
        ticketValue = 50;
    };
    class vr_mohawk_1: vr_mohawk_0 {};

    class vr_hellcat_0 : defaultEast {
        respawnTime = 900;
        ticketValue = 75;
    };

    };

    // Logistic
    class Box_Nato_Ammo_F {
        isDragable = 1;
        isLoadable = 1;
        cargoCapacity = 3;
        cargoSize = 5;
    };

    class Box_East_Ammo_F : Box_Nato_Ammo_F {
    };

    class Box_IND_Ammo_F : Box_Nato_Ammo_F {
    };

    class Land_CargoBox_V1_F {
        isDragable = 1;
        isLoadable = 1;
        cargoCapacity = 20;
        cargoSize = 25;
    };

    class B_Slingload_01_Cargo_F {
        isDragable = 1;
        isLoadable = 0;
        cargoCapacity = 50;
        cargoSize = 60;
        logisticOffset[] = {0,0,5};
    };

    class Heli_Transport_01_base_F {
        cargoCapacity = 20;
    };

    class Heli_Transport_02_base_F : Heli_Transport_01_base_F {
    };

    class Heli_Transport_03_base_F {
        cargoCapacity = 50;
    };

    class Heli_Transport_04_base_F : Heli_Transport_03_base_F {
    };


    class O_Truck_02_covered_F {
        cargoCapacity = 50;
    };

    class O_Truck_03_covered_F : O_Truck_02_covered_F {
    };

    class O_Truck_03_transport_F : O_Truck_02_covered_F {
    };

    class B_Truck_01_Box_F {
        cargoCapacity = 80;
    };

    class B_Truck_01_Covered_F {
        cargoCapacity = 50;
    };

    class B_Truck_01_transport_F : B_Truck_01_Covered_F {
    };

    class B_MRAP_01_F {
        cargoCapacity = 20;
    };

    class O_MRAP_02_F : B_MRAP_01_F {
    };
    class B_HMG_01_high_F {
        isDragable = 1;
        isLoadable = 1;
    };
    class O_HMG_01_high_F: B_HMG_01_high_F {};

    class CargoNet_01_ammo_base_F : B_Slingload_01_Cargo_F {
        isLoadable = 1;
        cargoSize = 20;
        cargoCapacity = 10;
        logisticOffset[] = {0, 0, 0};
    };
};
