class baseFNC {
    preInit = 0;
    postInit = 0;
    #ifdef isDev
        recompile = 1;
    #else
        recompile = 0;
    #endif
};

class basePreFNC: baseFNC {
    preInit = 1;
};

class cfgFunctions {
    #include "Core\cfgFunctions.hpp"
    #include "Logistic\cfgFunctions.hpp"
    #include "Mission\cfgFunctions.hpp"
	#include "Nametags\cfgFunctions.hpp"
    #include "Revive\cfgFunctions.hpp"
};
