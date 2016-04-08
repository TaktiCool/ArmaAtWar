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
GVAR(MapIconIndex) = [];
GVAR(MapIconMapControls) = []; // Array of Map Controls
GVAR(IconNamespace) = call FUNC(createNamespace); //Namspace for Icons
GVAR(IconHoveredEventNamespace) = call FUNC(createNamespace); // Namespace for Icon "Hover"-Events
GVAR(IconSelectedEventNamespace) = call FUNC(createNamespace); // Namespace for Icon "Selected"-Events

[{
    {
        if (ctrlShown _x) then {
            [_x] call FUNC(drawMapIcons);
        };
        nil
    } count GVAR(MapIconMapControls);
}] call CFUNC(addPerFrameHandler);
