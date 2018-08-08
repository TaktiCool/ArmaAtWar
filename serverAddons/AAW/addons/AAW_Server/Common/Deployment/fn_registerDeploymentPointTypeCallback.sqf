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

// build Namespace Variablename
private _callbackNameSpace = format [QGVAR(Deployment_%1_CallbackNamespace), _type];
private _namespace = missionNamespace getVariable _callbackNameSpace;

// Check if namespace exist and if not create and save it
if (isNil "_namespace") then {
    _namespace = true call CFUNC(createNamespace);
    missionNamespace setVariable [_callbackNameSpace, _namespace, true];
};

private _callbacks = _namespace getVariable [_callbackType, []];

_callbacks pushBack _callback;

_namespace setVariable [_callbackType, _eventArray, true];
