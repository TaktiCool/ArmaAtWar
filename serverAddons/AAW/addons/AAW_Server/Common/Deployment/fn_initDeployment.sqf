#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, NetFusion

    Description:
    Init for deployment system

    Parameter(s):
    None

    Returns:
    None
*/
DFUNC(setDeploymentCustomData) = {
    LOG("AAW_Common_fnc_setDeploymentCustomData was replaced with AAW_Common_fnc_setDeploymentData");
    _this call FUNC(setDeploymentData);
};
DFUNC(getDeploymentCustomData) = {
    LOG("AAW_Common_fnc_getDeploymentCustomData was replaced with AAW_Common_fnc_getDeploymentData");
    _this call FUNC(getDeploymentData);
};
