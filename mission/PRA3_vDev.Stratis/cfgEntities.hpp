class CfgEntities {
    // abstact classes
    class defaultVehicle {
        scope = 0; // abstact class
        condition = "true";
        side = "UNKNOWN";
        respawnTime = -1; // disabled
        ticketValue = 5;
    };

    class defaultWest : defaultVehicle {
        side = "WEST";
    };

    class defaultEast : defaultVehicle {
        scope = 0; //abstact class
        side = "EAST";
    };

    class defaultIndependent : defaultVehicle {
        scope = 0; //abstact class
        side = "INDEPENDENT";
    };

    // mission objects
    // -- Blufor -- //
    // Cars
    class vr_hunter_0 : defaultWest {
        scope = 1;
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

    // Tanks
    class vr_slammer_0 : vr_hunter_0 {
        scope = 1;
        condition = "time > 60";
        ticketValue = 20;
    };
    class vr_slammer_1 : vr_slammer_0 {};


    // Air
    class vr_ghosthawk_0 : defaultWest {
        scope = 1;
        respawnTime = 60;
        ticketValue = 50;
    };
    class vr_ghosthawk_1: vr_ghosthawk_0 {};

    class vr_Huron_0: vr_ghosthawk_0 {
        respawnTime = 60;
        ticketValue = 100;
        condition = "time > 60";
    };


    // -- Opfor -- //
    // Car
    class vr_ifrit_0 : defaultEast {
        scope = 1;
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

    // Tanks
    class vr_varsuk_0 : vr_ifrit_0 {
        scope = 1;
        condition = "time > 60";
        ticketValue = 20;
    };
    class vr_varsuk_1: vr_varsuk_0 {};

    // Air
    class vr_orca_0 : defaultEast {
        scope = 1;
        respawnTime = 60; // 10 seconds
        ticketValue = 50;
    };
    class vr_orca_1: vr_orca_0 {};

    class vr_Taru_0: vr_orca_0 {
        respawnTime = 60;
        ticketValue = 100;
        condition = "time > 60";
    };

    // Logistic
    class Land_CargoBox_V1_F {
        isDragable = 1;
        cargoIsLoadable = 1;
        cargoCapicity = 10;
        cargoSize = 20;
    };

    class B_Slingload_01_Cargo_F {
        isDragable = 1;
        cargoIsLoadable = 0;
        cargoCapicity = 30;
        cargoSize = 60;
        logisticOffset[] = {0,0,5};
    };

    class B_Heli_Transport_01_F {
        cargoCapicity = 50;
    };

    class B_Heli_Transport_03_F {
        cargoCapicity = 100;
    };

};
