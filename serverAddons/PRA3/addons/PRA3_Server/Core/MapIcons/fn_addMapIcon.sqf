#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Add Map Icon

    Parameter(s):
    0: Icon Id <String>
    1: Standard Icon <Array>
    2: Hover Icon <Array>
    3: Selected Icon <Array>
    4: Auto Scale <Boolean>

    Remarks:
    Icon <Array>:
        0: Texture <String>
        1: Color <Array> [r,g,b,a]
        2: Position <Position or Object>
        3: Width <Number>
        4: Height <Number>
        5: Angle <Number>
        6: Text <String>
        7: Shadow <Boolean/Number>
        8: Text Size <Number>
        9: Font <String>
        10: Align <String>

    Returns:
    None
*/
params ["_id", ["_standardIcon", []], ["_hoverIcon", []], ["_selectedIcon", []], ["_autoScale", true]];

GVAR(IconNamespace) setVariable [_id, [0, _standardIcon, _hoverIcon, _selectedIcon, _autoscale]];
GVAR(MapIconIndex) pushBackUnique _id;
