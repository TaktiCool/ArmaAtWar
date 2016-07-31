#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Create a New Statemaschine.

    Parameter(s):
    None

    Returns:
    StateMaschine Object <Location>
*/

private _namespace = false call CFUNC(createNamespace);

_namespace setVariable [SMVAR(nextStateData), "init"];
