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

/* MapIconArray
    Item:
        0: State <Number> (0) Standard, (1) Hovered, (2) Selected
        1: Standard Icon <Array>
        2: Hover Icon <Array>
        3: Selected Icon <Array>
        4: Auto Scale <Boolean>
*/
with uiNamespace do {
    GVAR(MapIconMapControls) = []; // Array of Map Controls
};

GVAR(MapIconIndex) = [];
GVAR(IconNamespace) = call FUNC(createNamespace); //Namspace for Icons
// GVAR(IconHoveredEventNamespace) = call FUNC(createNamespace); // Namespace for Icon "Hover"-Events
// GVAR(IconSelectedEventNamespace) = call FUNC(createNamespace); // Namespace for Icon "Selected"-Events
[{
    ((findDisplay 12) displayCtrl 51) call FUNC(registerMapControl);
}, {!(isNull ((findDisplay 12) displayCtrl 51))}] call FUNC(waitUntil);
