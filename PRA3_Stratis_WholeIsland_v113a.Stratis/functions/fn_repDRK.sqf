/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/
_object = vehicle (_this select 0);
_type = typeOf _object; 
_typeName = getText (configfile >> "CfgVehicles" >> _type >> "displayName");



x_reload_time_factor = 20;
x_repair_time_factor = 20;
x_refuel_time_factor = 20;

if (!(_object isKindOf "Man")) then {
	_object setVehicleAmmo 0;

	_object groupChat format ["Servicing %1... Please stand by...", _typeName];
	_object setFuel 0;
	_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");

	if (count _magazines > 0) then {
		_removed = [];
		{
			if (!(_x in _removed)) then {
				_object removeMagazines _x;
				_removed = _removed + [_x];
			};
		} forEach _magazines;
		{
			_object groupChat format ["Reloading %1", _x];
			sleep x_reload_time_factor;
			_object addMagazine _x;
		} forEach _magazines;
	};

	_count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");

	if (_count > 0) then {
		for "_i" from 0 to (_count - 1) do {
			scopeName "xx_reload2_xx";
			_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
			_magazines = getArray(_config >> "magazines");
			_removed = [];
			{
				if (!(_x in _removed)) then {
					_object removeMagazines _x;
					_removed = _removed + [_x];
				};
			} forEach _magazines;
			{
				_object groupChat format ["Reloading %1", _x];
				sleep x_reload_time_factor;
				_object addMagazine _x;
				sleep x_reload_time_factor;
			} forEach _magazines;
			_count_other = count (_config >> "Turrets");
			if (_count_other > 0) then {
				for "_i" from 0 to (_count_other - 1) do {
					_config2 = (_config >> "Turrets") select _i;
					_magazines = getArray(_config2 >> "magazines");
					_removed = [];
					{
						if (!(_x in _removed)) then {
							_object removeMagazines _x;
							_removed = _removed + [_x];
						};
					} forEach _magazines;
					{
						_object groupChat format ["Reloading %1", _x]; 
						sleep x_reload_time_factor;
						_object addMagazine _x;
						sleep x_reload_time_factor;
					} forEach _magazines;
				};
			};
		};
	};
	_object setVehicleAmmo 1;	// Reload turrets / drivers magazine

	sleep x_reload_time_factor;
	_object groupChat "Repairing...";
	_object setDamage 0;
	sleep x_repair_time_factor;
	_object groupChat "Refueling...";
	while {fuel _object < 0.99} do {
		//_object setFuel ((fuel _vehicle + 0.1) min 1);
		sleep x_refuel_time_factor;
		_object setFuel 1;
		sleep 0.01;
	};
	
	_object groupChat format ["%1 is ready...", _typeName];

	if (true) exitWith {};
};