#include "..\hpp\restrictedVehicles.hpp"

while {true} do 
{
	_isNotPilot = player getVariable ["isPilot", 0] == 0;
	_isNotCrewman = player getVariable ["isCrewman", 0] == 0;
	_currentVeh = typeOf vehicle player;

	//Check for Air Vehicles
	if (_currentVeh in _restrictedAir) then {
		_index = vehicle player getCargoIndex player;
		if ((_index == -1) && _isNotPilot) then {moveOut player; ["VehicleCheck",["","You Cannot Operate this Vehicle"]] call BIS_fnc_showNotification;};
	};
	//Check for Land Vehicles
	if (_currentVeh in _restrictedLand) then {
		_index = vehicle player getCargoIndex player;
		if ((_index == -1) && _isNotCrewman) then {moveOut player; ["VehicleCheck",["","You Cannot Operate this Vehicle"]] call BIS_fnc_showNotification;};
	};
	sleep 0.1;
};
