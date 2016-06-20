#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Client Init of Map Graphics

    Parameter(s):
    None

    Returns:
    None
*/

// Array of Map Controls
with uiNamespace do {
    GVAR(MapGraphicsMapControls) = [];
};

//Namespace for Layer
GVAR(MapGraphicsGroup) = call FUNC(createNamespace);

//Render Cache
GVAR(MapGraphicsCache) = [];
