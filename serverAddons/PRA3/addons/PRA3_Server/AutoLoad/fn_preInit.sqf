#include "macros.hpp"
EGVAR(Core,importentNamespaces) = [missionNamespace,uiNamespace/*,parsingNamespace*/];
// The autoloader uses this array to get all function names.
EGVAR(AutoLoad,functionCache) = [];

// Autoload
PREP(autoloadEntryPoint)
PREP(callModules)
PREP(loadModules)
PREP(loadModulesServer)



// We call the autoloader here. This starts the mod work.
call FUNC(autoloadEntryPoint);
