#include "macros.hpp"
if (hasInterface) then {


    GVAR(colorEffectCC) = ["colorCorrections", 1632, [1, 1, 0.15, [0.3, 0.3, 0.3, 0], [0.3, 0.3, 0.3, 0.3], [1, 1, 1, 1]]] call CFUNC(createPPEffect);
    GVAR(vigEffectCC) = ["colorCorrections", 1633, [1, 1, 0, [0.15, 0, 0, 1], [1.0, 0.5, 0.5, 1], [0.587, 0.199, 0.114, 0], [1, 1, 0, 0, 0, 0.2, 1]]] call CFUNC(createPPEffect);
    GVAR(blurEffectCC) = ["dynamicBlur", 525, [0]] call CFUNC(createPPEffect);
    GVAR(PPEffects) = [GVAR(colorEffectCC),GVAR(vigEffectCC),GVAR(blurEffectCC)];


    // Animation Event
    ["UnconsciousnessChanged", FUNC(UnconsciousnessChanged)] call CFUNC(addEventhandler);

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
            _target getVariable [QGVAR(bloodLoss), 0] == 0 &&
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
            [{(_this select 0) setDamage (_this select 1); (_this select 0) forceWalk false;}, _healSpeed, [cursorObject, 1 - _maxHeal]] call CFUNC(wait);
        }
    ] call CFUNC(addAction);

    [
        "Revive Unit",
        "CAManBase",
        5,
        {
            _target getVariable [QGVAR(bloodLoss), 0] == 0 &&
            _target getVariable [QGVAR(isUnconscious), false] &&
            {!(_target getVariable [QGVAR(medicalActionIsInProgress), false])}
        }, {
            private _reviveSpeed = 60;
            if (PRA3_Player getVariable [QGVAR(isMedic), false]) then {
                _reviveSpeed = 20;
            };
            [{
                _this setVariable [QGVAR(isUnconscious), false, true];
                ["UnconsciousnessChanged", _this, [false, _this]] call CFUNC(targetEvent);
            }, _reviveSpeed, cursorObject] call CFUNC(wait);
        }
    ] call CFUNC(addAction);


    GVAR(actionKeyPressed) = false;
    [{
        (findDisplay 46) displayAddEventHandler ["KeyDown", {
            params ["_ctrl","_key"];

            if (_key == 57 && !GVAR(actionKeyPressed) && {typeOf cursorObject isKindOf "CAManBase" && (PRA3_Player distance cursorObject) < 3}) then {
                GVAR(actionKeyPressed) = true;
                [{
                    (_this select 0) params ["_target"];
                    if (cursorObject != _target || !GVAR(actionKeyPressed)) exitWith {
                        [_this select 1] call CFUNC(removePerFrameHandler);
                    };

                    if (!isNull GVAR(actions)) then {
                        {
                            _x params ["_condition", "_code", "_args"];
                            if (_args call _condition) then {_args call _code};
                        } count GVAR(actions);

                    };

                }, 0, [cursorObject]] call CFUNC(addPerFrameHandler);

                hint "SPACE DOWN";
                true;
            };
            false;
        }];

        (findDisplay 46) displayAddEventHandler ["KeyUp", {
            params ["_ctrl","_key"];

            if (_key == 57) then {
                GVAR(actionKeyPressed) = false;

                hint "SPACE UP";
            };
            false;
        }];
    }, {!isNull (findDisplay 46)}, _this] call CFUNC(waitUntil);

};
