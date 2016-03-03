#include "macros.hpp"


CGVAR(importentNamespaces) = [missionNamespace,uiNamespace/*,parsingNamespace*/];
// The autoloader uses this array to get all function names.
EGVAR(AutoLoad,functionCache) = [];

// Autoload
EPREP(Autoload,autoloadEntryPoint)
EPREP(Autoload,callModules)
EPREP(Autoload,loadModules)
EPREP(Autoload,loadModulesServer)

// Per Frame Eventhandler
PREP(addPerFrameHandler)
PREP(removePerFrameHandler)
PREP(initPerFrameHandler)
PREP(wait)
PREP(waitUntil)

// Namespaces
PREP(createNamespace)
PREP(deleteNamespace)
PREP(getVariableLoc)


// Events
EPREP(Events,initEvents)
EPREP(Events,addEventhandler)

// Trigger Events
EPREP(Events,localEvent)
EPREP(Events,targetEvent)
EPREP(Events,globalEvent)
EPREP(Events,serverEvent)

// Base Eventhandler
EPREP(Events,clientInit)
EPREP(Events,serverInit)
EPREP(Events,hcInit)

// Interaction
EPREP(Interaction,addAction)
EPREP(Interaction,clientInitInteraction)
EPREP(Interaction,loop)
EPREP(Interaction,inRange)

// Nametags
EPREP(Nametags,draw3D)
EPREP(Nametags,clientInitNametag)

// Init
PREP(init)

// Other Functions
PREP(getLogicGroup)
PREP(isAlive)
PREP(cachedCall)
PREP(addPerformanceCounter)
PREP(blurScreen)



// We call the autoloader here. This starts the mod work.
call FUNC(autoloadEntryPoint);
