#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Return allVariables that set with CFUNC(setVariable) from a Namespace

    Parameter(s):
    0: Namespace <Namespace>
    1: Variable Cachename <String> (default: PRA3_allVariableCache)

    Returns:
    <Array<Strings>> All Variable Names
*/
params ["_namespace", ["_cacheName", "PRA3_allVariableCache"]];

[_namespace, _cacheName, []] call CFUNC(getVariable);
