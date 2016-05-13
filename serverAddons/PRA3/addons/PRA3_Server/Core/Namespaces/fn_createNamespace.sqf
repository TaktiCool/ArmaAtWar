#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Create a Location

    Parameter(s):
    None

    Returns:
    Namespace <Location>

    Example:
    -
*/
private _ret = createLocation ["fakeTown", [-100000,-100000,-100000], 0, 0];
if !(isNil "JK_debug_fnc_addNewNamespace") then {
    [_ret, "LocationNamespace"] call JK_debug_fnc_addNewNamespace;
};
_ret
