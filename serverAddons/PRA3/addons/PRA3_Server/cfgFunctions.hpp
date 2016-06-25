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

    class PRA3_Core { \
        class Core { \
            file = "\pr\PRA3\addons\PRA3_Server\Core"; \
            class preInit: basePreFNC {}; \
            class preStart: basePreStartFNC {}; \
            class compile: baseFNC{}; \
        }; \
    };

    FUNCTIONSCONFIG(Revive)
    FUNCTIONSCONFIG(Kit)
    FUNCTIONSCONFIG(Logistic)
    FUNCTIONSCONFIG(Mission)
    FUNCTIONSCONFIG(Deployment)
    FUNCTIONSCONFIG(RespawnUI)
    FUNCTIONSCONFIG(Squad)
    FUNCTIONSCONFIG(Sector)
    FUNCTIONSCONFIG(Tickets)
    FUNCTIONSCONFIG(VehicleRespawn)
    FUNCTIONSCONFIG(Nametags)
    FUNCTIONSCONFIG(UnitTracker)
    FUNCTIONSCONFIG(CompassUI)
    FUNCTIONSCONFIG(GarbageCollector)
};
