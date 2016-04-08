#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Add Map Icon

    Parameter(s):
    0: Icon Id <String>

    Remarks:
    None

    Returns:
    None
*/
params ["_id"];

private _idx = GVAR(MapIconIndex) find _id;
if (_idx >= 0) then {
    GVAR(IconNamespace) setVariable [_id, nil];
    GVAR(MapIconIndex) deleteAt _idx;
};
