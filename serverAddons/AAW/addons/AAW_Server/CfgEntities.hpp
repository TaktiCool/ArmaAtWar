class defaultVehicle {
    respawnCondition = "true";
    side = "UNKNOWN";
    respawnTime = -1; // disabled
    ticketValue = 2;
    abandonedVehicleRadius = 200;
    abandonedVehicleTime = 300;
};

class CfgEntities {

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

    class ReammoBox_F : Box_Nato_Ammo_F {};

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

    /*
    Vehicle Config
    */
    // TRUCKS
    class Truck_01_base_F {
        side = "WEST";
        cargoCapacity = 50;
        respawnTime = 180;
        ticketValue = 10;
    };

    class Truck_02_base_F : Truck_01_base_F{
        side = "GUER";
    };

    class O_Truck_02_Ammo_F {
        side = "EAST";
    };

    class O_Truck_02_box_F {
        side = "EAST";
    };

    class O_Truck_02_fuel_F {
        side = "EAST";
    };

    class O_Truck_02_medical_F {
        side = "EAST";
    };

    class O_Truck_02_transport_F {
        side = "EAST";
    };

    class O_Truck_02_covered_F {
        side = "EAST";
    };

    class Truck_03_base_F : Truck_01_base_F {
        side = "EAST";
    };

    // MRAPs
    class MRAP_01_base_F : defaultVehicle {
        side = "WEST";
        cargoCapacity = 20;
        respawnTime = 300;
        ticketValue = 10;
    };

    class MRAP_01_gmg_base_F : MRAP_01_base_F {
        ticketValue = 15;
    };

    class MRAP_02_base_F : MRAP_01_base_F {
        side = "EAST";
    };

    class MRAP_02_gmg_base_F : MRAP_01_gmg_base_F {
        side = "EAST";
    };

    class MRAP_03_base_F : MRAP_01_base_F {
        side = "GUER";
    };

    class MRAP_03_gmg_base_F : MRAP_01_gmg_base_F {
        side = "GUER";
    };

    // Tanks
    class MBT_01_base_F : defaultVehicle {
        side = "WEST";
        cargoCapacity = 10;
        respawnTime = 600;
        ticketValue = 30;
    };

    class MBT_02_base_F : MBT_01_base_F {
        side = "EAST";
    };

    class MBT_03_base_F : MBT_01_base_F {
        side = "GUER";
    };

    // APCs
    class APC_Wheeled_01_base_F : defaultVehicle {
        side = "WEST";
        cargoCapacity = 25;
        respawnTime = 420;
        ticketValue = 20;
    };

    class APC_Wheeled_02_base_F : APC_Wheeled_01_base_F {
        side = "EAST";
    };

    class APC_Wheeled_03_base_F : APC_Wheeled_01_base_F {
        side = "GUER";
    };

    class APC_Tracked_01_base_F : APC_Wheeled_01_base_F {};

    class APC_Tracked_02_base_F : APC_Wheeled_01_base_F {
        side = "EAST";
    };

    class APC_Tracked_03_base_F : APC_Wheeled_01_base_F {
        side = "GUER";
    };

    // Helicopters
    // WEST
    class Heli_Attack_01_base_F : defaultVehicle { //AH-99 Blackfoot
        side = "WEST";
        respawnTime = 600;
        ticketValue = 30;
    };

    class Heli_Light_01_base_F : Heli_Attack_01_base_F { //MH-9 Hummingbird
        cargoCapacity = 15;
        respawnTime = 300;
        ticketValue = 20;
    };

    class Heli_Light_01_armed_base_F : Heli_Light_01_base_F { //MH-9 Pawnee
        cargoCapacity = 0;
        respawnTime = 420;
        ticketValue = 25;
    };

    class Heli_Transport_01_base_F : Heli_Attack_01_base_F { //UH-80 Ghost Hawk
        cargoCapacity = 50;
        respawnTime = 300;
        ticketValue = 20;
    };

    class Heli_Transport_03_base_F : Heli_Attack_01_base_F { // CH-67 Huron
        cargoCapacity = 100;
        respawnTime = 420;
        ticketValue = 25;
    };

    // EAST
    class Heli_Attack_02_base_F : defaultVehicle { //Mi-48 Kajman
        cargoCapacity = 25;
        side = "EAST";
        respawnTime = 600;
        ticketValue = 35;
    };

    class Heli_Light_02_base_F : Heli_Attack_02_base_F { //PO-30 Orca
        cargoCapacity = 50;
        respawnTime = 420;
        ticketValue = 30;
    };

    class Heli_Light_02_unarmed_base_F : Heli_Light_02_base_F { //PO-30 Orca (unarmed)
        respawnTime = 300;
        ticketValue = 20;
    };

    //TODO: Taru versions

    //GUER
    class Heli_Transport_02_base_F : defaultVehicle { //CH-49 Mohawk
        side = "GUER";
        cargoCapacity = 70;
        respawnTime = 420;
        ticketValue = 25;
    };

    class Heli_light_03_base_F : Heli_Transport_02_base_F { //WY-55 Hellcat
        cargoCapacity = 40;
        respawnTime = 420;
        ticketValue = 20;
    };

    class Heli_light_03_unarmed_base_F : Heli_light_03_base_F { //WY-55 Hellcat (unarmed)
        cargoCapacity = 50;
        respawnTime = 300;
        ticketValue = 15;
    };


};
