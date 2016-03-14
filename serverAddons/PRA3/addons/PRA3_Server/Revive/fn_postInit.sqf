#include "macros.hpp"
if (hasInterface) then {


    GVAR(colorEffectCC) = ["colorCorrections", 1632, [1, 1, 0.15, [0.3, 0.3, 0.3, 0], [0.3, 0.3, 0.3, 0.3], [1, 1, 1, 1]]] call CFUNC(createPPEffect);
    GVAR(vigEffectCC) = ["colorCorrections", 1633, [1, 1, 0, [0.15, 0, 0, 1], [1.0, 0.5, 0.5, 1], [0.587, 0.199, 0.114, 0], [1, 1, 0, 0, 0, 0.2, 1]]] call CFUNC(createPPEffect);
    GVAR(blurEffectCC) = ["dynamicBlur", 525, [0]] call CFUNC(createPPEffect);
    GVAR(PPEffects) = [GVAR(colorEffectCC),GVAR(vigEffectCC),GVAR(blurEffectCC)];


    // Animation Event
    ["UnconsciousnessChanged", {
        (_this select 0) params ["_state", "_unit"];

        if (_state) then {
            if (_unit isEqualTo PRA3_Player) then {
                {
                    _x ppEffectEnable true;
                    nil
                } count GVAR(PPEffects);
                GVAR(ppEffectPFHID) = [{
                    if (alive PRA3_Player) then {
                        private _bloodLevel = PRA3_Player getVariable [QGVAR(bleedOutTime), 0];
                        _bright = 0.2 + (0.1 * _bloodLevel);
                        _intense = 0.6 + (0.4 * _bloodLevel);
                        {
                            _effect = GVAR(PPEffects) select _forEachIndex;
                            _effect ppEffectAdjust _x;
                            _effect ppEffectCommit 1;
                        } forEach [
                            [1, 1, 0.15 * _bloodLevel, [0.3, 0.3, 0.3, 0], [_bright, _bright, _bright, _bright], [1, 1, 1, 1]],
                            [1, 1, 0, [0.15, 0, 0, 1], [1.0, 0.5, 0.5, 1], [0.587, 0.199, 0.114, 0], [_intense, _intense, 0, 0, 0, 0.2, 1]],
                            [0.7 + (1 - _bloodLevel)]
                        ];
                    } else {
                        [GVAR(ppEffectPFHID)] call CFUNC(removePerFrameHandler);
                    };
                }, 1] call CFUNC(addPerFrameHandler);
            };
            ["switchMove",["acts_InjuredLyingRifle02",_unit]] call CFUNC(globalEvent);
        } else {
            if (_unit isEqualTo PRA3_Player) then {
                {
                    _x ppEffectEnable false;
                    nil
                } count GVAR(PPEffects);

            };
            ["switchMove",["AmovPpneMstpSnonWnonDnon",_unit]] call CFUNC(globalEvent);
        };
    }] call CFUNC(addEventhandler);


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
            [{(_this select 0) setDamage (_this select 1);}, _healSpeed, [cursorObject, 1 - _maxHeal]] call CFUNC(wait);
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
                _this setVariable [QGVAR(isUnconscious), false, true];
                ["UnconsciousnessChanged", _this, [false, _this]] call CFUNC(targetEvent);
            }, _reviveSpeed, cursorObject] call CFUNC(wait);
        }
    ] call CFUNC(addAction);
    /*
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
    */
};
