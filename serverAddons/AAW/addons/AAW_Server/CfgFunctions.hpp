class cfgFunctions {
    createShortcuts = 1;

    class AAW {
        class AAW {
            file = "\tc\AAW\addons\AAW_Server\WarLog";
            class preStart {
                preInit = 0;
                postInit = 0;
                preStart = 1;
                #ifdef ISDEV
                    recompile = 1;
                #else
                    recompile = 0;
                #endif
            };
        };
    };
};
