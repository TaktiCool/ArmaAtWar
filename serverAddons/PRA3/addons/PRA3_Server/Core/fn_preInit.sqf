#include "macros.hpp"


GVAR(importentNamespaces) = [missionNamespace,uiNamespace/*,parsingNamespace*/];
// The autoloader uses this array to get all function names.
GVAR(functionCache) = [];

// Autoload
EPREP(Autoload,autoloadEntryPoint)
EPREP(Autoload,callModules)
EPREP(Autoload,loadModules)
EPREP(Autoload,loadModulesServer)

// Per Frame Eventhandler
PREP(addPerFrameHandler)
PREP(removePerFrameHandler)
PREP(initPerFrameHandler)
PREP(execNextFrame)
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
EPREP(Events,clientInitEvents)
EPREP(Events,serverInit)
EPREP(Events,hcInit)

// Interaction
EPREP(Interaction,addAction)
EPREP(Interaction,clientInitInteraction)
EPREP(Interaction,loop)
EPREP(Interaction,inRange)

// Mutex
EPREP(Mutex,initClientMutex)
EPREP(Mutex,initServerMutex)
EPREP(Mutex,mutex)

// Notification System
EPREP(Notification,clientInitNotification)

// Init
PREP(init)

// Other Functions
PREP(getLogicGroup)
PREP(isAlive)
PREP(cachedCall)
PREP(addPerformanceCounter)
PREP(blurScreen)
PREP(fixFloating)

// We call the autoloader here. This starts the mod work.
call FUNC(autoloadEntryPoint);
