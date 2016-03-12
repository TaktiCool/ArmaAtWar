#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Get Player Name if the Unit is Dead

    Parameter(s):
    0: Unit what the name will be get Detected <Object>

    Returns:
    Name Of the Unit <String>
*/
params ["_unit"];
private _ret = _unit getVariable QGVAR(playerName);
// fallback if the Unit dont have a Name set
if (isNil "_ret") then {
    _ret = name _unit;
};
_ret
