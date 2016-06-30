#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Set Variable at a Namespace/Logic/Object and save the name to get it back from CFUNC(allVaraibles)

    Parameter(s):
    0: Object to set Variable on <Namespace>
    1: Variable Name <String>
    2: Variable Content <Any>
    3: Variable Cachename <String> (default: PRA3_allVariableCache)
    4: Global? <Bool> (default: false)

    Remark:
    4: get ignored if Namespace is a Location

    Returns:
    None
*/
params ["_namespace", "_varName", "_varContent", ["_cacheName", "PRA3_allVariableCache"], ["_global", false, [false]]];

[_namespace, _varName, _varContent, _global] call CFUNC(setVar);

private _cache = [_namespace, _cacheName, []] call CFUNC(getVariable);

if (isNil "_varContent") then {
    private _i = _cache find _varName
    if (_i != -1) then {
        _cache deleteAt _i;
    };
} else {
    _cache pushBackUnique _varName;
};

[_namespace, _cacheName, _cache, _global] call CFUNC(setVar);
