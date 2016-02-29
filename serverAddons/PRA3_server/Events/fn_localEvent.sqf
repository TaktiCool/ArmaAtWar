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

_event = format [GEVENT(%1), _event];
private _eventFunctions = GVAR(EventNamespace) getVariable _event;

if !(isNil "_eventFunctions") then {
	{
		_args call _x;
		nil
	} count _eventFunctions;
};
