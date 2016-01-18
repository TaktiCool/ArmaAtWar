#include "..\hpp\vehicleCostTable.hpp"

if (isServer) then {

	_u = _this select 0;
	_t = typeOf _u;
	_c = 0;
	_s = objNull;
	
	{
	  if (_t in _x) then { _c = _x select 1; _s = _x select 2; };
	} forEach _array;

	[_s, -_c] call BIS_fnc_respawnTickets;
};