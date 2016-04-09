#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Draws the Map Icons

    Parameter(s):
    0: Map <Control>

    Remarks:
    None

    Returns:
    None
*/
params ["_map"];

{
    private _icon = GVAR(IconNamespace) getVariable _x;

    if !(isNil "_icon") then {
        _map drawIcon (_icon select (1 + (_icon select 0)));
    };
    nil
} count GVAR(MapIconIndex);
