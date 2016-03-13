#include "macros.hpp"
if (hasInterface) then {
    [{
        hint "TEST";
        (findDisplay 46) displayAddEventHandler ["KeyDown", {
        	params ["_ctrl","_key"];

        	if (_key == 57) then {
        		hint "SPACE DOWN";
        	};
            false;
        }];

        (findDisplay 46) displayAddEventHandler ["KeyUp", {
        	params ["_ctrl","_key"];

        	if (_key == 57) then {
        		hint "SPACE UP";
        	};
            false;
        }];
    }, {!isNull (findDisplay 46)}, _this] call CFUNC(waitUntil);
};
