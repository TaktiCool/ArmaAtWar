#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Check if Kit is usable or all Kits are away(in Group)

    Parameter(s):
    0: Unit that will have the Kit <Object>
    1: Class that the Unit want to have <String>

    Remarks:
    _kitName: Current Kit
    _maxCountGroup: Maximal Group Count
    _maxCountSide: Maximal Side Count
    _unit: Unit Object

    Returns:
    is Selectable <Bool>
*/
params ["_unit", "_class"];

private _Kit = GVAR(KitCache) getVariable _class;
if (isNil "_Kit") exitWith {false};

_Kit params ["", "", "", "_var"];
_var params ["_maxCountGroup", "_maxCountSide", "_condition"];
private _KitName = _class;
private _ret = call _condition;
if (isNil "_ret") exitWith {false};
_ret;
