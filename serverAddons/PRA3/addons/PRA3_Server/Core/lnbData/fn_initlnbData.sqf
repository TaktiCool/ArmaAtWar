#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    init for ListBox Data

    Parameter(s):
    None

    Returns:
    None
*/
GVAR(lnbDataStorage) = call FUNC(createNamespace);
GVAR(lnbDataStorage) setVariable [QGVAR(allVariablesCache), []];
