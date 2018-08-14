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
params [["_type", "", [""]], ["_callbackType", "", [""]], ["_pointId", "", [""]], "_args"];

// build Namespace Variablename
private _callbackNameSpace = format [QGVAR(Deployment_%1_CallbackNamespace), _type];
private _namespace = missionNamespace getVariable [_callbackNameSpace, objNull];
if (isNull _namespace) exitWith {
    LOG("Warning: RespawnType is Unknown: " + _type);
    nil
};
private _data = _namespace getVariable [_callbackType, []];
private _ret = nil;
{
    _ret = [_pointId, _ret, _args] call _x;
    nil
} count _data;

_ret;
