#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    -

    Returns:
    -
*/

{
    private _varName = format [QGVAR(baseGroup%1),_x];
    missionNamespace setVariable [_varName, createGroup (call compile _x)];
    publicVariable _varName;
    nil
} count GVAR(competingSides);