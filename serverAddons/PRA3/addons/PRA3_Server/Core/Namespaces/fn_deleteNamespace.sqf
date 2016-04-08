#include "macros.hpp"
/*
    Project Reality ArmA 3 - Core\fn_createNamespace.sqf

    Author: joko // Jonas

    Description:
    Delete a Location

    Parameter(s):
    Namespace <Location>

    Returns:
    None
*/
params [["_namespace", locationNull, [locationNull]]];
deleteLocation _namespace;
if !(isNil "JK_debug_fnc_delteNamespace") then {
    [_namespace] call JK_debug_fnc_delteNamespace;
};
