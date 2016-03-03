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

params [["_event", "", [""]], ["_args", []]];

_event = format ["PRA3_Event_%1", _event];
private _eventArray = GVAR(EventNamespace) getVariable _event;
if !(isNil "_eventArray") then {
    {
        _x params ["_eventFunctions", "_data"];
        [_args, _data] call _eventFunctions;
        nil
    } count _eventArray;
};
