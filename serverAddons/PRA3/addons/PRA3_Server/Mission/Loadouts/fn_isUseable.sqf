#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Check if Loadout is usable or all Loadouts are away(in Group)

    Parameter(s):
    0: Unit that will have the Loadout <Object>
    1: Class that the Unit want to have <String>

    Remarks:
    _loadoutName: Current Loadout
    _maxCountGroup: Maximal Group Count
    _maxCountSide: Maximal Side Count


    Returns:
    is Selectable <Bool>
*/
params ["_unit", "_class"];

private _loadout = GVAR(LoadoutCache) getVariable _class;
if (isNil "_loadout") exitWith {false};
_loadout params ["", "", "", "_var"];
_var params ["_maxCountGroup", "_maxCountSide", "_condition"];
private _ret = call _condition;
if (isNil "_ret") exitWith {false};
_ret;
