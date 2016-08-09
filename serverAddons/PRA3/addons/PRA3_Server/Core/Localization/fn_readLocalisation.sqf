#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    ReadLocalisation

    Parameter(s):
    0: Localisation Name <String>

    Returns:
    Localisted Text
*/
params [["_locaName", "STR_PRA3_ERROR"]];
[LVAR(Namespace), _locaName, "Error"] call CFUNC(getVariable);
