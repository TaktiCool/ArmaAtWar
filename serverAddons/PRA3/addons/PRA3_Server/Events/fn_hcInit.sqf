#include "macros.hpp"
/*
	Arma Mission Enhancement - Core\fn_clientInit.sqf

	Author: NetFusion

	Description:
	This function is the entry point for the core module. It is called by autoloader for server. It adds OEF EH to trigger some common events.

	Parameter(s):
	-

	Returns:
	-

	Example:
	-
*/

// To ensure that the briefing is done during briefings we trigger an event if the mission starts.
[{
	// If time is greater than zero trigger the event and remove the OEF EH to ensure that the event is only triggered once.
	if (time > 0) then {
		["missionStarted"] call FUNC(Events,localEvent);
		(_this select 0) call FUNC(removePerFrameHandler);
	};
}] call FUNC(addPerFrameHandler);
