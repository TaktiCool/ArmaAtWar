#include "macros.hpp"
GVAR(importentNamespaces) = [missionNamespace,uiNamespace/*,parsingNamespace*/];

// Per Frame Eventhandler
PREP(addPerFrameHandler)
PREP(removePerFrameHandler)
PREP(initPerFrameHandler)
PREP(wait)
PREP(waitUntil)

// Namespaces
PREP(createNamespace)
PREP(deleteNamespace)

// Other Functions
PREP(getLogicGroup)

// Interaction
EPREP(Interaction,addAction)
EPREP(Interaction,init)

// Nametags
EPREP(Nametags,draw3D)
