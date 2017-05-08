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
    hintC "AAW_Common_fnc_setDeploymentCustomData was replaced with AAW_Common_fnc_setDeploymentPointData";
    LOG("AAW_Common_fnc_setDeploymentCustomData was replaced with AAW_Common_fnc_setDeploymentPointData");
    _this call FUNC(setDeploymentPointData);
};
DFUNC(getDeploymentCustomData) = {
    hintC "AAW_Common_fnc_getDeploymentCustomData was replaced with AAW_Common_fnc_getDeploymentData";
    LOG("AAW_Common_fnc_getDeploymentCustomData was replaced with AAW_Common_fnc_getDeploymentData");
    _this call FUNC(getDeploymentPointData);
};
