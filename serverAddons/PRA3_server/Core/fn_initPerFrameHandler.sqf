#include "macros.hpp"
/*
	Project Reality ArmA 3

	Author: joko // Jonas

	Description:
	init for PFH

	Parameter(s):
	None

	Returns:
	None
*/
GVAR(PFHCache) = call FUNC(createNamespace);
GVAR(PFHCache) setVariable [QGVAR(PerframehandlerArray),[]];
[QGVAR(OnEachFrame), "onEachFrame", {
	private _handler = GVAR(PFHCache) getVariable QGVAR(PerframehandlerArray);
	{
		_x params ["_fnc", "_args", "_delay", "_delta"];

		// call Function if
		if (diag_tickTime > _delta) then {
			if (_fnc isEqualType "") then {
				if (_fnc find "PRA3_Event_" > 0) then {
					[_fnc, _args] call EFUNC(Events,localEvent);
				} else {
					_fnc = missionNamespace getVariable [_fnc, {}];
					[_params, _forEachIndex] call _fnc;
				};
			} else {
				[_params, _forEachIndex] call _fnc;
			};
			// Set the new execution time depending on the provided delay.
			_x set [3, _delta + _delay];
		};
	} forEach _handler;

	while {!(GVAR(waitArray) isEqualTo []) && {GVAR(waitArray) select 0 select 0 <= time}} do {
		private _entry = GVAR(waitArray) deleteAt 0;
		(_entry select 2) call (_entry select 1);
	};

	GVAR(waitUntilArray) = GVAR(waitUntilArray) select {
		if ((_x select 2) call (_x select 1)) then {
			(_x select 2) call (_x select 0);
			false
		} else {
			true
		};
	};
}] call BIS_fnc_addStackedEventHandler;
