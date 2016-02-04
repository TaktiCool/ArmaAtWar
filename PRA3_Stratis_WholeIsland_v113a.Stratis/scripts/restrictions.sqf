/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/
#include "..\hpp\restrictedVehicles.hpp"

while {true} do 
{
	_playerRole = player getVariable ["unitRole", ""];
	_isCombatPilot = player getVariable ["isCombatPilot", ""];
	_isLogisticPilot = player getVariable ["isLogisticPilot", ""];
	_isLogisticCrew = player getVariable ["isLogisticCrew", ""];
	_isVehicleCommander = player getVariable ["isVehicleCommander", ""];
	_isVehicleCrew = player getVariable ["isVehicleCrew", ""];
	
	_currentVeh = typeOf vehicle player;

	//Check for Air Vehicles
	if (_currentVeh in _restrictedCAS) then {
		
		_index = vehicle player getCargoIndex player;
		if ((_index == -1) && (_isCombatPilot != 1)) then {moveOut player; ["VehicleCheck",["","You Cannot Operate this Vehicle"]] call BIS_fnc_showNotification;};
	};
	//Check for Land Vehicles
	if (_currentVeh in _restrictedLand) then {
		_index = vehicle player getCargoIndex player;
		if ((_index == -1) && (_isVehicleCommander != 1 || _isVehicleCrew != 1)) then {moveOut player; ["VehicleCheck",["","You Cannot Operate this Vehicle"]] call BIS_fnc_showNotification;};
			if (commander vehicle player == player && _isVehicleCommander != 1) then {
				moveOut player; ["VehicleCheck",["","You Cannot Operate this Vehicle"]] call BIS_fnc_showNotification;
			};
			if ((driver vehicle player == player || gunner vehicle player == player) && _isVehicleCrew != 1) then {
				moveOut player; ["VehicleCheck",["","You Cannot Operate this Vehicle"]] call BIS_fnc_showNotification;
			}
	};
	//Check for Logi Chopper Vehicles
	if (_currentVeh in _restrictedLogiAir) then {
		_index = vehicle player getCargoIndex player;
		if (_index == -1) then {
			if (driver vehicle player == player && _isLogisticPilot != 1) then {
				moveOut player; ["VehicleCheck",["","You Cannot Operate this Vehicle"]] call BIS_fnc_showNotification;
			};
			if (driver vehicle player != player && _isLogisticCrew != 1) then {
				moveOut player; ["VehicleCheck",["","You Cannot Operate this Vehicle"]] call BIS_fnc_showNotification;
			};
		};
	};
	sleep 0.1;
};
