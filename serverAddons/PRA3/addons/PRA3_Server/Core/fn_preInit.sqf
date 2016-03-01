#include "macros.hpp"

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

// Interaction
EPREP(Interaction,addAction)
EPREP(Interaction,clientInitInteraction)
EPREP(Interaction,loop)

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
