#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas

    Description:
    Checks if a Deployment Point is still a Deployment Point

    Parameter(s):
    0: PointID <String>

    Returns:
    is Deployment Point <Bool>
*/
params ["_pointID"];
!isNil {GVAR(DeploymentPointStorage) getVariable _pointID};
