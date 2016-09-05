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
    FUNCTIONSCONFIG(Common)
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
