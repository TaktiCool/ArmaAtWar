class baseFNC {
    preInit = 0;
    postInit = 0;
    preStart = 0;
    #ifdef isDev
        recompile = 1;
    #else
        recompile = 0;
    #endif
};

class basePreFNC: baseFNC {
    preInit = 1;
};

class basePreStartFNC: baseFNC {
    preStart = 1;
};

class cfgFunctions {

    createShortcuts = 1;

    //init = "pr\PRA3\addons\PRA3_Server\init.sqf";

    #include "Core\cfgFunctions.hpp"

    #include "Revive\cfgFunctions.hpp"

    #include "Kit\cfgFunctions.hpp"
    #include "Logistic\cfgFunctions.hpp"

    #include "Mission\cfgFunctions.hpp"
    #include "Deployment\cfgFunctions.hpp"
    #include "RespawnUI\cfgFunctions.hpp"
    #include "Squad\cfgFunctions.hpp"

    #include "Sector\cfgFunctions.hpp"
    #include "Tickets\cfgFunctions.hpp"

    #include "VehicleRespawn\cfgFunctions.hpp"
    #include "Nametags\cfgFunctions.hpp"

    #include "UnitTracker\cfgFunctions.hpp"

    #include "CompassUI\cfgFunctions.hpp"

    #include "GarbageCollector\cfgFunctions.hpp"
};
