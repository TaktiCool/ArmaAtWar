#include "macros.hpp"
/*
    Project Reality ArmA 3 - Events\fn_localEvent.sqf

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

_event = format ["Event_PRA3_", _event];
private _eventArray = GVAR(EventNamespace) getVariable _event;

if !(isNil "_eventArray") then {
    _eventArray params ["_eventFunctions", "_data"];
    {
        [_args, _data] call _x;
        nil
    } count _eventFunctions;
};
