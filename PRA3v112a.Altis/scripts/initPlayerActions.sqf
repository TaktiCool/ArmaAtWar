// Add FARP actions to player.
player addAction ["== Deploy FARP ==", DRK_fnc_deployFARP, [], -999, false, true,"",
	"(typeOf cursorTarget == 'B_Truck_01_Repair_F') && ((cursorTarget getVariable 'deploy_state') select 0 == 'mobile') && (alive cursorTarget) && (cursorTarget distance getMarkerPos 'respawn_west_base' > 1000) && (playerSide == west) && (cursorTarget distance player < 5)"];

player addAction ["== Mobilize FARP ==", DRK_fnc_undeployFARP, [], -999, false, true, "", 
	"(typeOf cursorTarget == 'B_Truck_01_Repair_F') && ((cursorTarget getVariable 'deploy_state') select 0 == 'deployed') && (alive cursorTarget) && (cursorTarget distance getMarkerPos 'respawn_west_base' > 1000) && (playerSide == west) && (cursorTarget distance player < 5) && (typeOf vehicle player == 'B_Soldier_SL_F' || typeOf vehicle player == 'B_soldier_repair_F')"];

player addAction ["== Deploy FARP ==", DRK_fnc_deployFARP, [], -999, false, true, "", 
	"(typeOf cursorTarget == 'O_Truck_03_Repair_F') && ((cursorTarget getVariable 'deploy_state') select 0 == 'mobile') && (alive cursorTarget) && (cursorTarget distance getMarkerPos 'respawn_east_base' > 1000) && (playerSide == east) && (cursorTarget distance player < 5)"];

player addAction ["== Mobilize FARP ==", DRK_fnc_undeployFARP, [], -999, false, true, "", 
	"(typeOf cursorTarget == 'O_Truck_03_Repair_F') && ((cursorTarget getVariable 'deploy_state') select 0 == 'deployed') && (alive cursorTarget) && (cursorTarget distance getMarkerPos 'respawn_east_base' > 1000) && (playerSide == east) && (cursorTarget distance player < 5) && (typeOf vehicle player == 'O_Soldier_SL_F' || typeOf vehicle player == 'O_soldier_repair_F')"];

//Add Repair and rearm option to players
player addAction ["== Repair and Rearm ==", DRK_fnc_repDRK, [vehicle player], -999, false, true, "", "!(vehicle player isKindOf 'Man' ) && (count nearestObjects[vehicle player, ['Land_HelipadSquare_F','Land_HelipadCircle_F','Land_HelipadCivil_F','Land_HelipadRescue_F','Land_HelipadEmpty_F'], 5] > 0) && (driver vehicle player == player)"];

