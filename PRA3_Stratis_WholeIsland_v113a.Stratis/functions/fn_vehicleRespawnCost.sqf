/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/
#include <h\vehicleCostTable.hpp>

//if !(isServer) exitWith {};

systemChat format["Array Count: %1",count _array];

_type = typeOf (_this select 0);
systemChat format ["Type: %1", _type];
_cost = 0;
systemChat format ["Type: %1", _type];
_side = objNull;
systemChat format ["Type: %1", _type];

{
  if (_type in _x) then { systemChat format ["Array: %1", _x]; _cost = _x select 1; _side = _x select 2; };
} forEach _array;

[_side, _cost] call BIS_fnc_respawnTickets; 