#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Initialization for Map Icons

    Parameter(s):
    None

    Returns:
    None
*/
GVAR(IconNamespace) = call FUNC(createNamespace);
GVAR(IconHoveredEventNamespace) = call FUNC(createNamespace);
GVAR(IconSelectedEventNamespace) = call FUNC(createNamespace);
