#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Delete a Location

    Parameter(s):
    Namespace <Location>

    Returns:
    None
*/
params [["_namespace", locationNull, [locationNull]]];

GVAR(allCustomNamespaces) deleteAt (GVAR(allCustomNamespaces) find _namespace);
deleteLocation _namespace;
nil
