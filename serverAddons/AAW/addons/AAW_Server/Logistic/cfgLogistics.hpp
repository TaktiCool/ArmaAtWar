class cfgLogistics {

    class NATO {
        objectToSpawn[] = {"mainBaseFlagWest"};
        constructionPoints = 100; // at Beginning of Round
        constructionPointsMax = 500; // maximal resources
        constructionPointsGrowth[] = {1, 12}; // [constructionPoints, per seconds]
        class MedicalBox {
            displayName = "Medical Box";
            classname = "Box_NATO_Ammo_F";
            constructionCost = 5;
            removeDefaultLoadout = 1;
            picture = "\A3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
            class Attributes {
                supplyType = "Medical";
                supplyCapacity = 1000;
                supplyPoints = 1000;
            };
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Ammo Box";
            picture = "\A3\ui_f\data\gui\cfg\respawnroles\assault_ca.paa";
            constructionCost = 10;
            class Attributes {
                supplyType = "AmmoInfantery";
                supplyCapacity = 5000;
                supplyPoints = 5000;
            };
        };

        class FOBBox {
            displayName = "FOB Box";
            classname = "B_CargoNet_01_ammo_F";
            removeDefaultLoadout = 1;
            constructionCost = 50;
            picture = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
            class Attributes {
                FOBBoxObject = 1;
            };
        };
    };

    class CSAT {
        objectToSpawn[] = {"mainBaseFlagEast"};
        constructionPoints = 100; // at Beginning of Round
        constructionPointsMax = 500; // maximal resources
        constructionPointsGrowth[] = {1, 12}; // [constructionPoints, per seconds]
        class MedicalBox {
            displayName = "Medical Box";
            classname = "Box_East_Ammo_F";
            removeDefaultLoadout = 1;
            constructionCost = 5;
            picture = "\A3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
            class Attributes {
                supplyType = "Medical";
                supplyCapacity = 1000;
                supplyPoints = 1000;
            };
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Ammo Box";
            picture = "\A3\ui_f\data\gui\cfg\respawnroles\assault_ca.paa";
            constructionCost = 10;
            class Attributes {
                supplyType = "AmmoInfantery";
                supplyCapacity = 5000;
                supplyPoints = 5000;
            };
        };


        class FOBBox {
            displayName = "FOB Box";
            classname = "O_CargoNet_01_ammo_F";
            constructionCost = 50;
            removeDefaultLoadout = 1;
            resources = 50;
            picture = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
            class Attributes {
                FOBBoxObject = 1;
            };
        };
    };
    class AAF {
        objectToSpawn[] = {"mainBaseFlagGuer"};
        constructionPoints = 100; // at Beginning of Round
        constructionPointsMax = 500; // maximal resources
        constructionPointsGrowth[] = {1, 12}; // [constructionPoints, per seconds]
        class MedicalBox {
            displayName = "Medical Box";
            classname = "Box_IND_Ammo_F";
            removeDefaultLoadout = 1;
            picture = "\A3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
            constructionCost = 5;
            class Attributes {
                supplyType = "Medical";
                supplyCapacity = 1000;
                supplyPoints = 1000;
            };
        };

        class BasicAmmoBox : MedicalBox {
            displayName = "Ammo Box";
            picture = "\A3\ui_f\data\gui\cfg\respawnroles\assault_ca.paa";
            constructionCost = 10;
            class Attributes {
                supplyType = "AmmoInfantery";
                supplyCapacity = 5000;
                supplyPoints = 5000;
            };
        };

        class FOBBox {
          displayName = "FOB Box";
          classname = "I_CargoNet_01_ammo_F";
          constructionCost = 50;
          removeDefaultLoadout = 1;
          resources = 50;
          picture = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
          class Attributes {
              FOBBoxObject = 1;
          };
        };
    };
};
