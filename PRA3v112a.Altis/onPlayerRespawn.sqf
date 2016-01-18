waitUntil {alive player};
//Add back a ticket if the player was only incapacitated and not killed
if !(player getVariable ["BIS_revive_incapacitated", false]) then {[playerSide, -1] call BIS_fnc_respawnTickets};

//Set Role variable flags - this system is bad compared to a role changing system that doesnt require leaving the game and resynchronising. One day they'll get it.
_useFactory = ["B_Soldier_SL_F","O_Soldier_SL_F","B_officer_F","O_officer_F","B_Pilot_F","O_Pilot_F"];
_isPilot = ["B_Pilot_F","O_Pilot_F","B_Helipilot_F","O_Helipilot_F"];
_isCrew = ["B_crew_F","O_crew_F","B_officer_F","O_officer_F"];

if (typeOf player in _useFactory) then {player setVariable ["useFactory", 1, true];};
if (typeOf player in _isPilot) then {player setVariable ["isPilot", 1, true];};
if (typeOf player in _isCrew) then {player setVariable ["isCrewman", 1, true];};


[] execVM "scripts\initPlayerActions.sqf";

player removeEventHandler ["Respawn", TOOLTIPEHHANDLE];
