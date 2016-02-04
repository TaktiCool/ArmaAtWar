/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

//Disable Artillery Computers
enableEngineArtillery false;

//Restriction Checker
[] execVM "scripts\restrictions.sqf";

//Thermal Nerf
[] execVM "scripts\thermalNerf.sqf";

//Add markers if enabled in options
if ("PLAYER_MARKERS" call BIS_fnc_getParamValue != 0) then {
	[] execVM "scripts\player_markers.sqf";
};

TOOLTIPEHHANDLE = player addEventHandler ["Respawn", {
	(format ["Welcome %1, to PR:A3", name player]) hintC [
		"Change your role from the base flag pole.",
		"Get in touch with your squad leader.",
		"Play as a team.",
		"Try not to waste vehicle assets.",
		"Use voice comms where possible.",
		"Reference map often and place markers to assist friendlies where appropriate"
	];
	//Replace the ticket that joining the mission for the fisrt time would remove.
	[playerSide, 1] call BIS_fnc_respawnTickets;
}];