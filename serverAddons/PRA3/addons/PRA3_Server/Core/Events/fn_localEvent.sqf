#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Trigger Event on a Traget

    Parameter(s):
    0: Event Name <String>
    1: Arguments <Any> (default: nil)

    Returns:
    None
*/

params [["_eventName", "", [""]], ["_args", []]];

DUMP("Local event: " + _eventName)
_eventName = format ["PRA3_Event_%1", _eventName];
private _eventArray = GVAR(EventNamespace) getVariable _eventName;
if !(isNil "_eventArray") then {
    {
        _x params ["_eventFunctions", "_data"];
        [_args, _data] call _eventFunctions;
        nil
    } count _eventArray;
};
nil
