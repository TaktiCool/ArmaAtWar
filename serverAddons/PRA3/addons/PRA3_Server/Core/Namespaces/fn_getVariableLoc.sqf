#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    get Default Variable for Locations

    Parameter(s):
    0: NameSpace <Any>
    1: Variable Name <String>
    2: Default <Any>

    Returns:
    Varibale <Any>
*/

params ["_namespace", "_varName", "_default"];

if !(_namespace isEqualType locationNull) exitWith {
    _namespace getVariable [_varName, _default];
};

private _ret = _namespace getVariable _varName;

if (isNil "_ret") exitWith {_default};

_ret
