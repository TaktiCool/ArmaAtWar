class Sides {
    class West {
        name = "NATO";
        playerClass = "B_Soldier_F";
        //flag = "a3\data_f\Flags\flag_nato_co.paa";
        flag = "a3\Data_f\cfgFactionClasses_BLU_ca.paa";
        mapIcon = "a3\ui_f\data\Map\Markers\NATO\b_installation.paa";
        color[] = {0, 0.3, 0.8, 1};
        squadRallyPointObjects[] = {{"Land_TentDome_F", {0,0,0}}};
        FOBBoxObject = "B_CargoNet_01_ammo_F";
        FOBObjects[] = {{"B_CargoNet_01_ammo_F", {0,0,0}},{"Land_SatellitePhone_F", {0,0,1.631}}};

        #include "kitsWest.hpp"

        #include "cfgLogisticWest.hpp"
    };

    class East : West {
        name = "CSAT";
        playerClass = "O_Soldier_F";
        //flag = "a3\data_f\Flags\flag_csat_co.paa";
        flag = "a3\Data_f\cfgFactionClasses_OPF_ca.paa";
        mapIcon = "a3\ui_f\data\Map\Markers\NATO\o_installation.paa";
        color[] = {0.5, 0, 0, 1};
        squadRallyPointObjects[] = {{"Land_TentA_F", {0,0,0}}};
        FOBBoxObject = "O_CargoNet_01_ammo_F";
        FOBObjects[] = {{"O_CargoNet_01_ammo_F", {0,0,0}},{"Land_SatellitePhone_F", {0,0,1.631}}};

        #include "kitsEast.hpp"

        #include "cfgLogisticEast.hpp"

    };
};
