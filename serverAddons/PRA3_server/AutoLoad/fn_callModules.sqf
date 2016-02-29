#include "macros.hpp"
/*
	Project Reality ArmA 3 - Autoload\fn_callModules.sqf

	Author: NetFusion

	Description:
	Calls all init functions of all required modules for server and client. This should be called after modules are loaded (functions transferred).

	Parameter(s):
	None

	Returns:
	None

	Example:
	call FUNC(callModules);
*/

// Cycle through all available functions and determine whether to call them or not.
{
	// Client only functions.
	if (hasInterface && (_x find "_fnc_clientInit" > 0)) then {
		call compile ("call " + _x);
		DUMP("Call: " + _x)
	};
	// Server only functions.
	if (isServer && (_x find "_fnc_serverInit" > 0)) then {
		call compile ("call " + _x);
		DUMP("Call: " + _x)
	};
	// HC only functions.
	if (!isServer && !hasInterface && (_x find "_fnc_hcInit" > 0)) then {
		call compile ("call " + _x);
		DUMP("Call: " + _x)
	};
	// Functions for both.
	if (_x find "_fnc_init" > 0) then {
		call compile ("call " + _x);
		DUMP("Call: " + _x)
	};
	true
} count GVAR(requiredFunctions);
