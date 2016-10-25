#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Destroy FOB

    Parameter(s):
    None

    Returns:
    None
*/
params ["_object"];

private _pointId = _object getVariable [QGVAR(pointId), ""];
if (_pointId == "") exitWith {};

[_pointId] call EFUNC(Common,removePoint);