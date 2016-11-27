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
    side = "GUER";
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
    class vr_HEMMTTrans_0 : vr_hunter_0 {
        respawnTime = 180;
        ticketValue = 15;
    };
    class vr_HEMMTTrans_1 : vr_HEMMTTrans_0 {};

    class vr_HEMMTRep_0 : vr_HEMMTTrans_0 {};
    class vr_HEMMTFuel_0 : vr_HEMMTTrans_0 {};
    class vr_HEMMTAmmo_0 : vr_HEMMTTrans_0 {};

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
    class vr_strider_1 : vr_strider_0 {};

    class vr_striderHMG_0 : vr_strider_0 {
        ticketValue = 50;
    };
    class vr_striderHMG_1 : vr_striderHMG_0 {};

    class vr_striderGMG_0 : vr_striderHMG_0 {};

    // Trucks
    class vr_ZamakTrans_0 : vr_strider_0 {
        ticketValue = 20;
        respawnTime = 180;
        cargoCapacity = 50;
    };
    class vr_ZamakTrans_1 : vr_ZamakTrans_0 {};

    class vr_ZamakRep_0 : vr_ZamakTrans_0 {};
    class vr_ZamakFuel_0 : vr_ZamakTrans_0 {};
    class vr_ZamakAmmo_0 : vr_ZamakTrans_0 {};

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
    class vr_mohawk_0 : defaultIndependent {
        respawnTime = 600;
        ticketValue = 50;
    };
    class vr_mohawk_1: vr_mohawk_0 {};

    class vr_hellcat_0 : defaultIndependent {
        respawnTime = 900;
        ticketValue = 75;
    };

    /*
    Logistic Config
    */

    //Crates
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

    class CargoNet_01_ammo_base_F : B_Slingload_01_Cargo_F {
        isLoadable = 1;
        cargoSize = 20;
        cargoCapacity = 10;
        logisticOffset[] = {0, 0, 0};
    };

    // Light Helos
    class Heli_Light_01_base_F {
        cargoCapacity = 15;
    };

    class Heli_Light_02_base_F : Heli_Light_01_base_F {
    };

    class Heli_Light_03_base_F : Heli_Light_01_base_F {
    };

    // Transport Helos
    class Heli_Transport_01_base_F {
      cargoCapacity = 50;
    };

    class Heli_Transport_02_base_F : Heli_Transport_01_base_F {
    };

    class Heli_Transport_03_base_F : Heli_Transport_01_base_F {
    };

    class Heli_Transport_04_base_F : Heli_Transport_01_base_F {
    };

    // Trucks
    class Truck_01_base_F {
        cargoCapacity = 50;
    };
    class Truck_02_base_F: Truck_01_base_F {
    };

    class Truck_03_base_F: Truck_01_base_F {
    };

    // MRAPs
    class MRAP_01_base_F {
        cargoCapacity = 20;
    };

    class MRAP_02_base_F : MRAP_01_base_F {
    };

    class MRAP_03_base_F : MRAP_01_base_F {
    };

    //Wheeled APCs
    class APC_Wheeled_01_base_F {
        cargoCapacity = 25;
    };

    class APC_Wheeled_02_base_F : APC_Wheeled_01_base_F {
    };

    class APC_Wheeled_03_base_F : APC_Wheeled_01_base_F {
    };

    //Tracked APCs
    class APC_Tracked_01_base_F {
        cargoCapacity = 25;
    };

    class APC_Tracked_base_F : APC_Tracked_01_base_F {
    };

    class APC_Tracked_03_base_F : APC_Tracked_01_base_F {
    };

    //Tanks
    class MBT_01_base_F {
        cargoCapacity = 10;
    };

    class MBT_02_base_F : MBT_01_base_F {
    };

    class MBT_03_base_F : MBT_01_base_F {
    };

};
