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

if (isNil QGVAR(allCustomNamespaces)) then {
    GVAR(allCustomNamespaces) = [];
};

GVAR(allCustomNamespaces) pushBack _ret;

_ret
