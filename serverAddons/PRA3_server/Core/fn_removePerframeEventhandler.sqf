#include "macros.hpp"
/*
	Project Reality ArmA 3

	Author: joko // Jonas

	Description:
	Remove a Perframe Eventhandler per ID

	Parameter(s):
	0: Index of PFH <Number>

	Returns:
	None
*/
#include "macros.hpp"
params ["_index"];
private _handler = GVAR(PFHCache) getVariable QGVAR(PerframehandlerArray);
_handler deleteAt _index;
GVAR(PFHCache) setVariable [QGVAR(PerframehandlerArray), _handler];
