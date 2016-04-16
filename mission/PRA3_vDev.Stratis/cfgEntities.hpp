class ModuleLogistic {
    isDragable = 1;
    cargoIsLoadable = 0;
    cargoCapacity = 30;
    cargoSize = 60;
    logisticOffset[] = {0,0,5};
};

class LogisticVehicle : ModuleLogistic {
    isDragable = 0;
    cargoIsLoadable = 0;
};

class ModuleTickets {
    ticketValue = 1;
};

class TicketsCars : ModuleTickets {
    ticketValue = 5;
};

class TicketsTrucks : ModuleTickets {
    ticketValue = 10;
};

class TicketsTanks : ModuleTickets {
    ticketValue = 20;
};

class TicketsHelicopter : ModuleTickets {
    ticketValue = 50;
};

class ModuleVehicleRespawn {
    condition = "time > 0";
    side = "UNKNOWN";
    respawnTime = -1; // disabled
};

class VehicleRespawnWest : ModuleVehicleRespawn {
    side = "WEST";
};

class VehicleRespawnEast : ModuleVehicleRespawn {
    side = "EAST";
};

class VehicleRespawnIndependent : ModuleVehicleRespawn {
    side = "INDEPENDENT";
};

class CfgEntities {
    // abstact classes


    // mission objects
    // -- Blufor -- //
    // Cars
    class vr_hunter_0 {
        class vr : VehicleRespawnWest {
            respawnTime = 10; // 10 seconds
        };
        class t : TicketsCars {};
    };
    class vr_hunter_1: vr_hunter_0 {};

    // Trucks
    class vr_HEMMTTrans_0 : vr_hunter_0 {
        class vr : VehicleRespawnWest {
            ticketValue = 10;
            respawnTime = 20;
        };
        class t : TicketsTrucks {};
    };
    class vr_HEMMTTrans_1: vr_HEMMTTrans_0 {};

    class vr_HEMMTRep_0: vr_HEMMTTrans_0 {};
    class vr_HEMMTFuel_0: vr_HEMMTTrans_0 {};
    class vr_HEMMTAmmo_0: vr_HEMMTTrans_0 {};

    class vr_HEMMTLog_0: vr_HEMMTTrans_0 {};
    class vr_HEMMTLog_1: vr_HEMMTTrans_0 {};

    // Tanks
    class vr_slammer_0 {
        class vr : VehicleRespawnWest {
            condition = "time > 60";
            respawnTime = 10; // 10 seconds
        };
        class t : TicketsTanks {};
    };
    class vr_slammer_1 : vr_slammer_0 {};


    // Air
    class vr_ghosthawk_0 {
        class vr : VehicleRespawnWest {
            respawnTime = 60;
        };
        class t : TicketsHelicopter {};
    };
    class vr_ghosthawk_1: vr_ghosthawk_0 {};

    class vr_Huron_0: vr_ghosthawk_0 {
        class vr : VehicleRespawnWest {
            condition = "time > 60";
            respawnTime = 60; // 10 seconds
        };
        class t : TicketsHelicopter {
            ticketValue = 100;
        };
    };


    // -- Opfor -- //
    // Car
    class vr_ifrit_0 {
        class vr : VehicleRespawnEast {
            respawnTime = 10; // 10 seconds
        };
        class t : TicketsCars {};
    };
    class vr_ifrit_1: vr_ifrit_0 {};

    // Trucks
    class vr_ZamakTrans_0 {
        class vr : VehicleRespawnEast {
            ticketValue = 10;
            respawnTime = 20;
        };
        class t : TicketsTrucks {};
    };
    class vr_ZamakTrans_1: vr_ZamakTrans_0 {};

    class vr_ZamakRep_0: vr_ZamakTrans_0 {};
    class vr_ZamakFuel_0: vr_ZamakTrans_0 {};
    class vr_ZamakAmmo_0: vr_ZamakTrans_0 {};

    class vr_ZamakLog_0: vr_ZamakTrans_0 {};
    class vr_ZamakLog_1: vr_ZamakTrans_0 {};

    // Tanks
    class vr_varsuk_0 {
        class vr : VehicleRespawnEast {
            condition = "time > 60";
            respawnTime = 10; // 10 seconds
        };
        class t : TicketsTanks {};
    };
    class vr_varsuk_1: vr_varsuk_0 {};

    // Air
    class vr_orca_0 {
        class vr : VehicleRespawnEast {
            respawnTime = 60;
        };
        class t : TicketsHelicopter {};
    };
    class vr_orca_1: vr_orca_0 {};

    class vr_Taru_0: vr_orca_0 {
        respawnTime = 60;
        ticketValue = 100;
        condition = "time > 60";
    };

    // Logistic
    class Land_CargoBox_V1_F {
        class l : ModuleLogistic {
            cargoIsLoadable = 1;
            cargoCapacity = 10;
            cargoSize = 20;
        };
    };

    class B_Slingload_01_Cargo_F {
        class l : ModuleLogistic {};
    };

    class B_Heli_Transport_01_F {
        class l : LogisticVehicle {
            cargoCapacity = 50;
        };
    };

    class B_Heli_Transport_03_F {
        class l : LogisticVehicle {
            cargoCapacity = 100;
        };
    };

};
