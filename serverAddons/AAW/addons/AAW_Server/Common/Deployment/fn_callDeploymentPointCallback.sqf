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

// build Namespace Variablename
private _callbackNameSpace = format [QGVAR(Deployment_%1_CallbackNamespace), _type];
private _namespace = missionNamespace getVariable _callbackNameSpace;
private _data = _namespace getVariable [_callbackType, [{_this select 2}]];
private _ret = nil;
{
    _ret = [_pointId, _args, _ret] call _x;
} count _data;

_ret;
