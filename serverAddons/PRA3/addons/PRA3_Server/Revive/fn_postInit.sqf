#include "macros.hpp"
if (hasInterface) then {



    // ToDo write it with HodKeyEH @BadGuy
    // Todo write it Function based
    [
        "Stop Bleeding",
        "CAManBase",
        5,
        {
            _target getVariable [QGVAR(bloodLoss), 0] != 0 &&
            {!(_target getVariable [QGVAR(medicalActionIsInProgress), false])} &&
            {"FirstAidKit" in (items PRA3_Player) || {"FirstAidKit" in (items _target)}}
        }, {
            private _healSpeed = 60;
            if (PRA3_Player getVariable [QGVAR(isMedic), false]) then {
                private _healSpeed = 10;
            };
            [{(_this select 0) setVariable [QGVAR(bloodLoss), 0, true];}, _healSpeed, cursorObject] call CFUNC(wait);
        }
    ] call CFUNC(addAction);

    [
        "Heal Unit",
        "CAManBase",
        5,
        {
            _target getVariable [QGVAR(bloodLoss), 0] != 0 &&
            {!(_target getVariable [QGVAR(isUnconscious), false])} &&
            {!(_target getVariable [QGVAR(medicalActionIsInProgress), false])} &&
            {"Medikit" in (items PRA3_Player) || {"Medikit" in (items _target)}}
        }, {
            private _maxHeal = 0.75;
            private _healSpeed = 60;
            if (PRA3_Player getVariable [QGVAR(isMedic), false]) then {
                private _maxHeal = 1;
                private _healSpeed = 10;
            };
            [{(_this select 0) setDamage 1 - (_this select 1);}, _healSpeed, [cursorObject, _maxHeal]] call CFUNC(wait);
        }
    ] call CFUNC(addAction);

    [
        "Revive Unit",
        "CAManBase",
        5,
        {
            _target getVariable [QGVAR(bloodLoss), 0] != 0 &&
            _target getVariable [QGVAR(isUnconscious), false] &&
            {!(_target getVariable [QGVAR(medicalActionIsInProgress), false])}
        }, {
            private _reviveSpeed = 60;
            if (PRA3_Player getVariable [QGVAR(isMedic), false]) then {
                _reviveSpeed = 20;
            };
            [{
                PRA3_Player setVariable [QGVAR(isUnconscious), false, true];
                ["UnconsciousnessChanged", false] call CFUNC(localEvent);
            }, _reviveSpeed, cursorObject] call CFUNC(wait);
        }
    ] call CFUNC(addAction);

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
