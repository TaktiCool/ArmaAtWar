#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    Get all spawn points

    Parameter(s):
    0: Deployment Point Type <String>
    1: Callback Type <String>
    2: Callback <Code>

    Returns:
    None
*/
if !(isServer) exitWith {
    [_this, _fnc_scriptName, 2] call CFUNC(remoteExec);
};
params [["_type", "", [""]], ["_callbackType", "", [""]], ["_callback", {}, [{}]]];

private _varName = format [QGVAR(%1_%2), _type, _callbackType];
private _data = GVAR(DeploymentPointTypes) getVariable [_varName, []];
_data pushback _callback;
GVAR(DeploymentPointTypes) setVariable [_varName, _data, true];
