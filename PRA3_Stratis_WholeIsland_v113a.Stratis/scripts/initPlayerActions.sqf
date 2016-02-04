/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/
// Add FARP actions to player.
player addAction ["== Deploy FARP ==", DRK_fnc_deployFARP, [], -999, false, true,"",
	"(typeOf cursorTarget == 'B_Truck_01_Repair_F') && ((cursorTarget getVariable 'deploy_state') select 0 == 'mobile') && (alive cursorTarget) && (cursorTarget distance getMarkerPos 'respawn_west_base' > 1000) && (playerSide == west) && (cursorTarget distance player < 5)"];

player addAction ["== Mobilize FARP ==", DRK_fnc_undeployFARP, [], -999, false, true, "", 
	"(typeOf cursorTarget == 'B_Truck_01_Repair_F') && ((cursorTarget getVariable 'deploy_state') select 0 == 'deployed') && (alive cursorTarget) && (cursorTarget distance getMarkerPos 'respawn_west_base' > 1000) && (playerSide == west) && (cursorTarget distance player < 5) && (player getVariable ['useFactory', 0] == 1)"];

player addAction ["== Deploy FARP ==", DRK_fnc_deployFARP, [], -999, false, true, "", 
	"(typeOf cursorTarget == 'O_Truck_03_Repair_F') && ((cursorTarget getVariable 'deploy_state') select 0 == 'mobile') && (alive cursorTarget) && (cursorTarget distance getMarkerPos 'respawn_east_base' > 1000) && (playerSide == east) && (cursorTarget distance player < 5)"];

player addAction ["== Mobilize FARP ==", DRK_fnc_undeployFARP, [], -999, false, true, "", 
	"(typeOf cursorTarget == 'O_Truck_03_Repair_F') && ((cursorTarget getVariable 'deploy_state') select 0 == 'deployed') && (alive cursorTarget) && (cursorTarget distance getMarkerPos 'respawn_east_base' > 1000) && (playerSide == east) && (cursorTarget distance player < 5) && (player getVariable ['useFactory', 0] == 1)"];

//Add Repair and rearm option to players
player addAction ["== Repair and Rearm ==", DRK_fnc_repDRK, [vehicle player], -999, false, true, "", "!(vehicle player isKindOf 'Man' ) && (count nearestObjects[vehicle player, ['Land_HelipadSquare_F','Land_HelipadCircle_F','Land_HelipadCivil_F','Land_HelipadRescue_F','Land_HelipadEmpty_F'], 5] > 0) && (driver vehicle player == player)"];
//west
player addAction ["== Get Kit Loadout ==", {createDialog "PRA3_KitSelector";}, [], -999, true, true, "", "playerSide == west && ob1 distance player < 10"];
//east
player addAction ["== Get Kit Loadout ==", {createDialog "PRA3_KitSelector";}, [], -999, true, true, "", "playerSide == east && ob7 distance player < 10"];


KILLED_EH = player addEventHandler ["Killed", {
	_unit = _this select 0;
	CURRENTKIT = [_unit, [player, "inv"]] call BIS_fnc_saveInventory;
}]