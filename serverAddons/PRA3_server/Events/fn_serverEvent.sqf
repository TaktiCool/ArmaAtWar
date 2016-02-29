#include "macros.hpp"
/*
	Project Reality ArmA 3

	Author: joko // Jonas

	Description:
	trigger a event on the Server

	Parameter(s):
	0: Event Name <String>
	1: Arguments <Any>

	Returns:
	None
*/
[["_event", "EventError", [""]], ["_args", []], ["_persistent", 0, ["", 0]]];

[_event, _args] remoteExecCall [QFUNC(localEvent), 2, _persistent];
