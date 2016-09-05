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

    class DOUBLE(PREFIX,Core) {
            singleFunctionConfig(Core,preInit,basePreFNC)
            singleFunctionConfig(Core,preStart,basePreStartFNC)
        };
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
