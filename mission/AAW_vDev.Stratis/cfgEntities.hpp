class baseSupplyObject {
    supplyUses = -1;
};

class CfgEntities {
    /*
    // mission objects
    // -- Blufor -- //
    // Cars
    class vr_hunter_0 : defaultWest {
        respawnTime = 10; // 10 seconds
    };
    class vr_hunter_1: vr_hunter_0 {};

    // Trucks
    class vr_HEMMTTrans_0: vr_hunter_0 {
        ticketValue = 10;
        respawnTime = 20;
    };
    class vr_HEMMTTrans_1: vr_HEMMTTrans_0 {};

    class vr_HEMMTRep_0: vr_HEMMTTrans_0 {};
    class vr_HEMMTFuel_0: vr_HEMMTTrans_0 {};
    class vr_HEMMTAmmo_0: vr_HEMMTTrans_0 {};

    class vr_HEMMTLog_0: vr_HEMMTTrans_0 {};
    class vr_HEMMTLog_1: vr_HEMMTTrans_0 {};
*/
    // Tanks
    class vr_slammer_0 {
        respawnCondition = "time > 60";
    };
    class vr_slammer_1 : vr_slammer_0 {};

    // Air
/*
    class vr_ghosthawk_0 : defaultWest {
        respawnTime = 60;
        ticketValue = 50;
    };
    class vr_ghosthawk_1: vr_ghosthawk_0 {};
*/
    class vr_Huron_0 {
        respawnCondition = "time > 60";
    };

    // Supply
    class vr_vehicleAmmo_0 : baseSupplyObject {
        rearmAmount = 1;
    };
    class vr_fuelContainer_0 : baseSupplyObject {
        refuelAmount = 1;
    };
    class vr_repairContainer_0 : baseSupplyObject {
        repairAmount = 1;
    };

/*
    // -- Opfor -- //
    // Car
    class vr_ifrit_0 : defaultEast {
        respawnTime = 10; // 10 seconds
    };
    class vr_ifrit_1: vr_ifrit_0 {};

    // Trucks
    class vr_ZamakTrans_0: vr_ifrit_0 {
        ticketValue = 10;
        respawnTime = 20;
    };
    class vr_ZamakTrans_1: vr_ZamakTrans_0 {};

    class vr_ZamakRep_0: vr_ZamakTrans_0 {};
    class vr_ZamakFuel_0: vr_ZamakTrans_0 {};
    class vr_ZamakAmmo_0: vr_ZamakTrans_0 {};

    class vr_ZamakLog_0: vr_ZamakTrans_0 {};
    class vr_ZamakLog_1: vr_ZamakTrans_0 {};
*/
    // Tanks
    class vr_varsuk_0 {
        respawnCondition = "time > 60";
        //ticketValue = 20;
    };
    class vr_varsuk_1: vr_varsuk_0 {};
/*
    // Air
    class vr_orca_0 : defaultEast {
        respawnTime = 60; // 10 seconds
        ticketValue = 50;
    };
    class vr_orca_1: vr_orca_0 {};
*/
    class vr_Taru_0 {
        //respawnTime = 60;
        //ticketValue = 100;
        respawnCondition = "time > 60";
    };

    // Supply
    class vr_vehicleAmmo_1 : baseSupplyObject {
        rearmAmount = 1;
    };
    class vr_fuelContainer_1 : baseSupplyObject {
        refuelAmount = 1;
    };
    class vr_vehicleParts_0 : baseSupplyObject {
        repairAmount = 1;
    };
/*
    // Logistic
    class Box_Nato_Ammo_F {
        isDragable = 1;
        isLoadable = 1;
        cargoCapacity = 3;
        cargoSize = 5;
    };

    class Box_East_Ammo_F : Box_Nato_Ammo_F {};

    class Box_IND_Ammo_F : Box_Nato_Ammo_F {};

    class ReammoBox_F : Box_Nato_Ammo_F {};

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
    */
};
