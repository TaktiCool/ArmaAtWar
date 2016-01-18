["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

//Disable Artillery Computers
enableEngineArtillery false;

//Restriction Checker
[] execVM "scripts\restrictions.sqf";

//Add markers if enabled in options
if ("PLAYER_MARKERS" call BIS_fnc_getParamValue != 0) then {
	[] execVM "scripts\player_markers.sqf";
};

TOOLTIPEHHANDLE = player addEventHandler ["Respawn", {
	(format ["Welcome to Project Reality", name player]) hintC [
		"You can view your current squad by pressing U",
		"Use communication and follow your Squad Leader's orders",
		"Capture sectors in order to earn your team resources",
		"Kill enemy vehicles and infantry to deplete enemy tickets",
		"A team is victorious when all enemy tickets are depleted",
		"Visit www.bluedrake42.com for additional information"
	];
	//Replace the ticket that joining the mission for the first time would remove.
	[playerSide, 1] call BIS_fnc_respawnTickets;
	//Set EH to remove the secondary hint
	hintC_arr_EH = findDisplay 72 displayAddEventHandler ["unload", {
		0 = _this spawn {
			_this select 0 displayRemoveEventHandler ["unload", hintC_arr_EH];
			hintSilent "";
		};
	}];
}]