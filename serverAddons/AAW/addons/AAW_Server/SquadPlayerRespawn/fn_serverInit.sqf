#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    Server init for Squad Respawn

    Parameter(s):
    None

    Returns:
    None
*/
["SQUAD", "onPlaced", {}] call FUNC(fn_registerDeploymentPointTypeCallback);
["SQUAD", "onPrepare", {}] call FUNC(fn_registerDeploymentPointTypeCallback);
["SQUAD", "onSpawn", {}] call FUNC(fn_registerDeploymentPointTypeCallback);
["SQUAD", "onDestroy", {}] call FUNC(fn_registerDeploymentPointTypeCallback);
["SQUAD", "isAvailableFor", {}] call FUNC(fn_registerDeploymentPointTypeCallback);
["SQUAD", "isLocked", {}] call FUNC(fn_registerDeploymentPointTypeCallback);
