/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/
["Initialize"] call BIS_fnc_dynamicGroups;
["RegisterInitialPlayerGroups"] call BIS_fnc_dynamicGroups;

//attaching poles
[] call DRK_fnc_attachPoles;

//Time Accel
if (["TIME_ACCEL", 1] call BIS_fnc_getParamValue != 1) then {
	setTimeMultiplier (["TIME_ACCEL", 1] call BIS_fnc_getParamValue);
};

//Add cleanup of DC'd player
addMissionEventHandler ["HandleDisconnect", {
	
	_player = _this select 0;

	deleteVehicle _player;
}];

//Start Cleanup centered on the bases (flags to be specific)
[ob1] execVM "scripts\groundCleanup.sqf";
[ob7] execVM "scripts\groundCleanup.sqf";