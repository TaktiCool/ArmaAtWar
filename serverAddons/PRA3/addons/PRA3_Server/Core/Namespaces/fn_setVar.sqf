#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Wraper for setVariable for namespaces

    Parameter(s):
    0: Object to set Variable on <Namespace>
    1: Variable Name <String>
    2: Variable Content <Any>
    3: Global <Bool> (default: false)

    Remark:
    3: get ignored if Namespace is a Location


    Returns:
    None
*/
params ["_namespace", "_varName", "_varContent", ["_global"]];
if (_namespace isEqualType locationNull) then {
    _namespace setVariable [_varName, _varContent];
} else {
    _namespace setVariable [_varName, _varContent, _global];
};
