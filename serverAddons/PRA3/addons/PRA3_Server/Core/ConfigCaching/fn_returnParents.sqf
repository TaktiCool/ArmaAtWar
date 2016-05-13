#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Return all Parents of a ConfigClass and Cache them in a Namespace

    Parameter(s):
    0: ConfigPath <ConfigPath>
    1: return Names <Bool>

    Returns:
    all Partent Classes <Array<ConfigPath>>
*/
params ["_config", ["_returnNames", false]];

private _ret = GVAR(configCache) getVariable format [QGVAR(%1_%2), _config, _returnNames];
if (isNil "_ret") then {
    _ret = _this call BIS_fnc_returnParents;
    GVAR(configCache) setVariable [format [QGVAR(%1_%2), _config, _returnNames], _ret];
};
_ret
