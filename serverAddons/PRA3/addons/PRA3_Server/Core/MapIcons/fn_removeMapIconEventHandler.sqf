#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Remove a Map Icon Draw Event

    Parameter(s):
    0: Icon Id <String>
    1: Icon Event Name <String>
    2: Event ID <Number>

    Returns:
    None
*/
params [["_uid", "", [""]], ["_event", "", [""]], ["_id", 0, [0]]];

// build Namespace Variablename
_eventNameSpace = format [QGVAR(MapIcon_%1_EventNamespace), _eventName];
private _namespace = missionNamespace getVariable _eventNameSpace;

private _eventArray = [_namespace, _uid, []] call FUNC(getVariable);
if (count _eventArray >= _id) exitWith {};
_eventArray set [_id, nil];
