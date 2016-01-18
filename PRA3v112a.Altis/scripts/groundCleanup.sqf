//Simple cleanup script for the bases.

_unit = _this select 0;
_radius = ["CLEANUP_RADIUS", 250] call BIS_fnc_getParamValue;
_loopTime = ["CLEANUP_TIME", 60] call BIS_fnc_getParamValue;

while {true} do {

	if (alive _unit) then {
		//Cleanup dropped gear
		{ 
			deleteVehicle _x 
		} foreach (nearestObjects[_unit,["GroundWeaponHolder"],_radius]);
	};

	sleep _loopTime;
};