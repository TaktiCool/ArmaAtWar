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
["SQUAD", "onPlaced", {}] call EFUNC(Common,registerDeploymentPointTypeCallback);
["SQUAD", "onPrepare", {}] call EFUNC(Common,registerDeploymentPointTypeCallback);
["SQUAD", "onSpawn", {}] call EFUNC(Common,registerDeploymentPointTypeCallback);
["SQUAD", "onDestroy", {}] call EFUNC(Common,registerDeploymentPointTypeCallback);
["SQUAD", "isAvailableFor", {}] call EFUNC(Common,registerDeploymentPointTypeCallback);
["SQUAD", "isLocked", {}] call EFUNC(Common,registerDeploymentPointTypeCallback);
