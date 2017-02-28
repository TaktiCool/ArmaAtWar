#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    get kit details

    Parameter(s):
    0: Kit name
    1: Requested details <Array>

    Returns:
    Array With all Strings <Array>
*/
params ["_kitName", "_details"];

private _prefix = format [QGVAR(Kit_%1_%2_), playerSide, _kitName];

_details apply {[_prefix + (_x select 0), _x select 1] call CFUNC(getSettingOld)}
