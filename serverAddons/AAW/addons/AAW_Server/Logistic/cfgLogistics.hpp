#define COST_MEDICAL_BOX 1000
#define COST_BASIC_AMMO_BOX 5000
#define COST_FOB_BOX 20000

class cfgLogistics {

    class NATO {
        supplySourceObjects[] = {"mainBaseFlagWest"};
        supplyPoints = 50000; // at Beginning of Round
        supplyPointsMax = 100000; // maximal resources
        supplyPointsGrowth[] = {1000, 20}; // [supplyPoints, per seconds]
        class MedicalBox {
            displayName = "Medical Box";
            classname = "Box_NATO_Ammo_F";
            supplyCost = COST_MEDICAL_BOX;
            removeDefaultLoadout = 1;
            picture = "\A3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
            class Attributes {
                supplyType[] = {"Medical"};
                supplyCapacity = COST_MEDICAL_BOX;
                supplyPoints = COST_MEDICAL_BOX;
            };
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Ammo Box";
            picture = "\A3\ui_f\data\gui\cfg\respawnroles\assault_ca.paa";
            supplyCost = COST_BASIC_AMMO_BOX;
            class Attributes {
                supplyType[]  = {"AmmoInfantery"};
                supplyCapacity = COST_BASIC_AMMO_BOX;
                supplyPoints = COST_BASIC_AMMO_BOX;
            };
        };

        class FOBBox {
            displayName = "FOB Box";
            classname = "B_CargoNet_01_ammo_F";
            removeDefaultLoadout = 1;
            supplyCost = COST_FOB_BOX;
            picture = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
            class Attributes {
                FOBBoxObject = 1;
            };
        };
    };

    class CSAT {
        supplySourceObjects[] = {"mainBaseFlagEast"};
        supplyPoints = 50000; // at Beginning of Round
        supplyPointsMax = 100000; // maximal resources
        supplyPointsGrowth[] = {100, 20}; // [supplyPoints, per seconds]
        class MedicalBox {
            displayName = "Medical Box";
            classname = "Box_East_Ammo_F";
            removeDefaultLoadout = 1;
            supplyCost = COST_MEDICAL_BOX;
            picture = "\A3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
            class Attributes {
                supplyType[] = {"Medical"};
                supplyCapacity = COST_MEDICAL_BOX;
                supplyPoints = COST_MEDICAL_BOX;
            };
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Ammo Box";
            picture = "\A3\ui_f\data\gui\cfg\respawnroles\assault_ca.paa";
            supplyCost = COST_BASIC_AMMO_BOX;
            class Attributes {
                supplyType[]  = {"AmmoInfantery"};
                supplyCapacity = COST_BASIC_AMMO_BOX;
                supplyPoints = COST_BASIC_AMMO_BOX;
            };
        };


        class FOBBox {
            displayName = "FOB Box";
            classname = "O_CargoNet_01_ammo_F";
            supplyCost = COST_FOB_BOX;
            removeDefaultLoadout = 1;
            resources = 50;
            picture = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
            class Attributes {
                FOBBoxObject = 1;
            };
        };
    };
    class AAF {
        supplySourceObjects[] = {"mainBaseFlagGuer"};
        supplyPoints = 50000; // at Beginning of Round
        supplyPointsMax = 100000; // maximal resources
        supplyPointsGrowth[] = {100, 20}; // [supplyPoints, per seconds]
        class MedicalBox {
            displayName = "Medical Box";
            classname = "Box_IND_Ammo_F";
            removeDefaultLoadout = 1;
            picture = "\A3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
            supplyCost = COST_MEDICAL_BOX;
            class Attributes {
                supplyType[] = {"Medical"};
                supplyCapacity = COST_MEDICAL_BOX;
                supplyPoints = COST_MEDICAL_BOX;
            };
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Ammo Box";
            picture = "\A3\ui_f\data\gui\cfg\respawnroles\assault_ca.paa";
            supplyCost = COST_BASIC_AMMO_BOX;
            class Attributes {
                supplyType[]  = {"AmmoInfantery"};
                supplyCapacity = COST_BASIC_AMMO_BOX;
                supplyPoints = COST_BASIC_AMMO_BOX;
            };
        };

        class FOBBox {
            displayName = "FOB Box";
            classname = "I_CargoNet_01_ammo_F";
            supplyCost = COST_FOB_BOX;
            removeDefaultLoadout = 1;
            resources = 50;
            picture = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
            class Attributes {
              FOBBoxObject = 1;
            };
        };
    };
};
