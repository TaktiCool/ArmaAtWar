#include "..\hpp\arsenalwhitelist.hpp"

_unit = _this select 0;
_side = _this select 1;

if (_side == east) then {

	[_unit, _opfWep, true, true] call BIS_fnc_addVirtualWeaponCargo;
	[_unit, _opfMag, true, true] call BIS_fnc_addVirtualMagazineCargo;
	[_unit, _opfItm, true, true] call BIS_fnc_addVirtualItemCargo;
	[_unit, _opfBag, true, true] call BIS_fnc_addVirtualBackpackCargo;

};

if (_side == west) then {

	[_unit, _bluWep, true, true] call BIS_fnc_addVirtualWeaponCargo;
	[_unit, _bluMag, true, true] call BIS_fnc_addVirtualMagazineCargo;
	[_unit, _bluItm, true, true] call BIS_fnc_addVirtualItemCargo;
	[_unit, _bluBag, true, true] call BIS_fnc_addVirtualBackpackCargo;

};
