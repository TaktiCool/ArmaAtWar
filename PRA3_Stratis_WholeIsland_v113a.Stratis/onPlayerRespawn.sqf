/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/

//Add back a ticket if the player was only incapacitated and not killed
if !(player getVariable ["BIS_revive_incapacitated", false]) then {
	[playerSide, -1] call BIS_fnc_respawnTickets;
};

//If the player is only knocked out then give him his chosen kit back
if (player getVariable ["BIS_revive_incapacitated", false]) then {
	sleep 1;
	[player, [player, "inv"]] call BIS_fnc_loadInventory;
};

//Equip player with their last loadout
[player, [player, "inv"]] call BIS_fnc_loadInventory;

//Give all players an unarmed generic soldier on initial spawn, otherwise their previous kit.
if (playerSide == east && isNil 'CURRENTKIT') then { 
	[player,configfile >> "CfgVehicles" >> "o_soldier_unarmed_f"] call BIS_fnc_loadInventory;
};
if (playerSide == west && isNil 'CURRENTKIT') then {		
		[player,configfile >> "CfgVehicles" >> "b_soldier_unarmed_f"] call BIS_fnc_loadInventory;
};




[] execVM "scripts\initPlayerActions.sqf";

player removeEventHandler ["Respawn", TOOLTIPEHHANDLE];
