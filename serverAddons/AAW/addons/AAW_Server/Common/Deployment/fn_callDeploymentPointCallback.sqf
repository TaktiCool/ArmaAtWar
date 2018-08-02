#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    Get all spawn points

    Parameter(s):
    0: Deployment Point Type <String>
    1: Callback Type <String>
    2: Parameter <Anything>

    Returns:
    Callback Return
*/
params [["_type", "", [""]], ["_callbackType", "", [""]], ["_pointId", "", [""]], ["_args", {}, [{}]]];

private _varName = format [QGVAR(%1_%2), _type, _callbackType];
private _data = GVAR(DeploymentPointTypes) getVariable [_varName, [{_this select 2}]];
private _ret = nil;
{
    _ret = [_pointId, _args, _ret] call _x;
} count _data;

_ret;
