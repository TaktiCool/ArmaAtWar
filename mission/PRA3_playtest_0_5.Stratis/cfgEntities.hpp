class defaultVehicle {
    respawnCondition = "true";
    side = "UNKNOWN";
    respawnTime = -1; // disabled
    ticketValue = 2;
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
        respawnTime = 300; // 5 min
    };
    class vr_hunter_1: vr_hunter_0 {};

    class vr_hunter_2: vr_hunter_0 {};

    class vr_hunterHMG_0: vr_hunter_0 {
        respawnTime = 600; // 10 min
        ticketValue = 4;
    };

    // Trucks
    class vr_HEMMTTrans_0: vr_hunter_0 {
        ticketValue = 2;
        respawnTime = 600;
    };
    class vr_HEMMTTrans_1: vr_HEMMTTrans_0 {};

    class vr_HEMMTRepair_0: vr_HEMMTTrans_0 {};
    class vr_HEMMTFuel_0: vr_HEMMTTrans_0 {};
    class vr_HEMMTAmmo_0: vr_HEMMTTrans_0 {};

    // APCs
    class vr_marshall_0 : vr_hunter_0 {
        respawnTime = 1200; // 30 min
        ticketValue = 10;
    };

    // Air
    class vr_ghosthawk_0 : defaultWest {
        respawnTime = 1200;
        ticketValue = 5;
    };

    // -- Opfor -- //
    // Car
    class vr_ifrit_0 : defaultEast {
        respawnTime = 300; // 5 min
    };
    class vr_ifrit_1: vr_ifrit_0 {};
    class vr_ifrit_2: vr_ifrit_0 {};
    class vr_ifritHMG_0: vr_ifrit_0 {
        respawnTime = 600; // 10 min
        ticketValue = 4;
    };

    // Trucks
    class vr_ZamakTrans_0: vr_ifrit_0 {
        ticketValue = 2;
        respawnTime = 600;
    };
    class vr_ZamakTrans_1: vr_ZamakTrans_0 {};

    class vr_TempestRepair_0: vr_ZamakTrans_0 {};
    class vr_ZamakFuel_0: vr_ZamakTrans_0 {};
    class vr_TempestAmmo_0: vr_ZamakTrans_0 {};

    // APCs
    class vr_marid_0 : vr_ifrit_0 {
        respawnTime = 1200;
        ticketValue = 10;
    };

    // Air
    class vr_orca_0 : defaultEast {
        respawnTime = 1200;
        ticketValue = 5;
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

    class O_Heli_Light_02_unarmed_F : Heli_Transport_01_base_F {
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
        cargoCapacity = 50;
    };

    class O_Truck_02_transport_F : B_Truck_01_Covered_F {
    };

    class B_MRAP_01_F {
        cargoCapacity = 20;
    };

    class B_MRAP_01_hmg_F : B_MRAP_01_F {
    };

    class O_MRAP_02_F : B_MRAP_01_F {
    };

    class B_MRAP_02_hmg_F : B_MRAP_01_F {
    };

    class B_APC_Wheeled_01_cannon_F : B_MRAP_01_F {
    };

    class O_APC_Wheeled_02_rcws_F : B_APC_Wheeled_01_cannon_F {
    };

    class B_HMG_01_high_F {
        isDragable = 1;
        isLoadable = 1;
    };
    class O_HMG_01_high_F: B_HMG_01_high_F {};
};
