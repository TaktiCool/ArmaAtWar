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
        1: Texture <String>
        2: Color <Array> [r,g,b,a]
        3: Position <Position or Object>
        4: Width <Number>
        5: Height <Number>
        6: Angle <Number>
        7: Text <String>
        8: Shadow <Boolean/Number>
        9: Text Size <Number>
        10: Font <String>
        11: Align <String>

    Returns:
    None
*/
params ["_id",["_standardIcon",[]],["_hoverIcon",[]],["_selectedIcon",[]],["_autoScale",true]];

GVAR(IconNamespace) setVariable [_id, [0, _standardIcon, _hoverIcon, _selectedIcon, _autoscale]];
GVAR(MapIconIndex) pushBackUnique _id;
