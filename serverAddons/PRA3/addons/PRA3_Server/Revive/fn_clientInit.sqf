#include "macros.hpp"

GVAR(SELECTIONS) = ["", "head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];
private _cfg = missionConfigFile >> "PRA3" >> "CfgRevive";

// bleedout Timer Variables
GVAR(reviveBleedingTime) = getNumber (_cfg >> "reviveBleedingTime");
GVAR(reviveBleedOutTime) = getNumber (_cfg >> "reviveBleedOutTime");

// Actions Varaibles
// - Heal
GVAR(healingTime) = getNumber (_cfg >> "healingTime");
GVAR(healCoef) = getNumber (_cfg >> "healCoef");
GVAR(maxHeal) = getNumber (_cfg >> "maxHeal");
// - Revive
GVAR(reviveSpeed) = getNumber (_cfg >> "reviveSpeed");
GVAR(reviveCoef) = getNumber (_cfg >> "reviveCoef");
// - Bandage
GVAR(bandageSpeed) = getNumber (_cfg >> "bandageSpeed");
GVAR(bandageCoef) = getNumber (_cfg >> "bandageCoef");

// Damage Coefs
GVAR(unconBleedCoef) = getNumber (_cfg >> "unconBleedCoef");
GVAR(bleedCoef) = getNumber (_cfg >> "bleedCoef");
GVAR(damageCoef) = getArray (_cfg >> "damageCoef");

// Damage Values
GVAR(preventInstantDeath) = getNumber (_cfg >> "preventInstantDeath") isEqualTo 1;
GVAR(maxDamage) = getNumber (_cfg >> "maxDamage");

GVAR(currentHealers) = [];
GVAR(healingPFH) = -1;

GVAR(playerSwitch) = false;

DFUNC(resetPPEffects) = {
    if !(isNil QGVAR(PPEffects)) then {
        {
            _x ppEffectEnable false;
            nil
        } count GVAR(PPEffects);
    };

    if !(isNil QGVAR(ppEffectPFHID)) then {
        [GVAR(ppEffectPFHID)] call CFUNC(removePerFrameHandler);
        GVAR(ppEffectPFHID) = nil;
    };
};

DFUNC(resetMedicalVars) = {
    _this setVariable [QGVAR(bleedOutTime), 0, true];
    _this setVariable [QGVAR(isUnconscious), false, true];
    _this setVariable [QGVAR(DeathCause), "", true] ;
    [_this, QGVAR(DamageSelection), [0,0,0,0,0,0,0]] call CFUNC(setVariablePublic);
    [_this, QGVAR(bloodLoss), 0] call CFUNC(setVariablePublic);
    [_this, QGVAR(HealingProgress), 0] call CFUNC(setVariablePublic);
    [_this, QGVAR(HealingRate), 0] call CFUNC(setVariablePublic);
    [_this, QGVAR(HealingTimestamp), -1] call CFUNC(setVariablePublic);
};

DFUNC(updateHealingStatus) = {
    private _damageSelection = PRA3_Player getVariable QGVAR(DamageSelection);
    private _maxDamage = 0;
    {
        if (_x > _maxDamage) then {
            _maxDamage = _x;
        };
        nil;
    } count _damageSelection;

    private _healingRate = 0;
    {
        private _healingTime = GVAR(healingTime);
        if !(_x getVariable [QGVAR(isMedic), false]) then {
            _healingTime = _healingTime * GVAR(healCoef);
        };
        _healingRate = _healingRate + 1 / _healingTime;

        nil;
    } count GVAR(currentHealers);

    private _healingProgress = 1 - _maxDamage / GVAR(maxDamage);

    PRA3_Player setVariable [QGVAR(healingProgress), _healingProgress, true];
    PRA3_Player setVariable [QGVAR(healingRate), _healingRate, true];
    PRA3_Player setVariable [QGVAR(healingTimestamp), serverTime, true];
};

// Bleedout Timer
[QFUNC(bleedoutTimer), 0] call CFUNC(addPerFrameHandler);

["healUnit", {
    [PRA3_Player, QGVAR(DamageSelection), [0,0,0,0,0,0,0]] call CFUNC(setVariablePublic);
}] call CFUNC(addEventhandler);

["unregisterHealer", {
    (_this select 0) params ["_healer"];

    if (_healer in GVAR(currentHealers)) then {
        private _index = GVAR(currentHealers) find _healer;
        GVAR(currentHealers) deleteAt _index;
    };

    call FUNC(updateHealingStatus);
}] call CFUNC(addEventhandler);

["registerHealer", {
    (_this select 0) params ["_healer"];
    GVAR(currentHealers) pushBackUnique _healer;

    call FUNC(updateHealingStatus);

    if (GVAR(healingPFH) < 0) then {
        GVAR(healingPFH) = [{

            if (objNull in GVAR(currentHealers)) then {
                GVAR(currentHealers) = GVAR(currentHealers) select {!isNull _x};
            };

            private _damageSelection = PRA3_Player getVariable QGVAR(DamageSelection);
            private _lastTimestamp = PRA3_Player getVariable [QGVAR(healingTimestamp),-1];

            if (_lastTimestamp < 0) exitWith {};

            private _healingRate = PRA3_Player getVariable [QGVAR(healingRate),-1];
            private _maxDamage = 0;
            {
                if (_x > _maxDamage) then {
                    _maxDamage = _x;
                };
                nil;
            } count _damageSelection;

            if ((serverTime - _lastTimestamp) <= 0) exitWith {};

            _maxDamage = _maxDamage - (serverTime - _lastTimestamp) * _healingRate * GVAR(maxDamage);

            _maxDamage = _maxDamage max 0;

            _damageSelection = _damageSelection apply {
                [_x, _maxDamage] select (_x > _maxDamage);
            };

            [PRA3_Player, QGVAR(DamageSelection), _damageSelection] call CFUNC(setVariablePublic);

            if (_maxDamage < 0.7) then {
                PRA3_Player forceWalk false;
            };

            if (count GVAR(currentHealers) == 0 || _maxDamage == 0) exitWith {
                GVAR(healingPFH) = -1;
                PRA3_Player setVariable [QGVAR(healingProgress), 1 - _maxDamage / GVAR(maxDamage), true];
                PRA3_Player setVariable [QGVAR(healingRate), 0, true];
                PRA3_Player setVariable [QGVAR(healingTimestamp), serverTime, true];
                [_this select 1] call CFUNC(removePerFrameHandler);
            };
            PRA3_Player setVariable [QGVAR(healingProgress), 1 - _maxDamage / GVAR(maxDamage)];
            PRA3_Player setVariable [QGVAR(healingTimestamp), serverTime];



        }, 0.1, []] call CFUNC(addPerFrameHandler);
    };

}] call CFUNC(addEventhandler);

["stopBleeding", {
    [PRA3_Player, QGVAR(bloodLoss), 0] call CFUNC(setVariablePublic);
}] call CFUNC(addEventhandler);


["Killed", {
    (_this select 0) params ["_unit","_killer"];
    setPlayerRespawnTime 10e10;
    if (_unit getVariable [QGVAR(DeathCause), ""] == "") then {
        private _gear = [_unit] call CFUNC(saveGear);
        _unit setVariable [QGVAR(killer), _killer];
        ["UnconsciousnessChanged", [true, _unit]] call CFUNC(localEvent);



        [{
            (_this select 0) params ["_unit", "_gear"];

            GVAR(playerSwitch) = true;
            [side group _unit, group _unit, getPosWorld _unit] call EFUNC(Mission,respawn);
            GVAR(playerSwitch) = false;


            ["switchMove", [PRA3_Player, "acts_InjuredLyingRifle02"]] call CFUNC(globalEvent);

            {
                PRA3_Player setVariable [_x, _unit getVariable _x, true];
            } forEach allVariables _unit;

            [_gear, PRA3_Player] call CFUNC(restoreGear);

            PRA3_Player setDir direction _unit;

            deleteVehicle _unit;

        }, 3, [_unit, _gear]] call CFUNC(wait);
    } else {
        if (!isNull _killer) then {
            _killer = _unit getVariable [QGVAR(killer), objNull];
        };
        [QGVAR(Killed), [_unit, _killer]] call CFUNC(localEvent);
        ["UnconsciousnessChanged", [false, _unit]] call CFUNC(localEvent);
    };
}] call CFUNC(addEventhandler);


["Respawn", {
    if (!GVAR(playerSwitch)) then {
        (_this select 0) select 0 call FUNC(resetMedicalVars);
        ["UnconsciousnessChanged", [false, PRA3_Player]] call CFUNC(localEvent);
    };
}] call CFUNC(addEventhandler);

PRA3_player addEventHandler ["handleDamage", FUNC(handleDamage)];

// disable Healing
PRA3_player addEventHandler ["HitPart", {0}];
PRA3_player addEventHandler ["Hit", {0}];

// reset all Eventhandler on player Changed Event
["playerChanged", {
    ((_this select 0) select 0) addEventHandler ["handleDamage", FUNC(handleDamage)];
    ((_this select 0) select 0) addEventHandler ["HitPart", {0}];
    ((_this select 0) select 0) addEventHandler ["Hit", {0}];
}] call CFUNC(addEventhandler);


addMissionEventHandler ["Draw3D", {
    if (!alive PRA3_Player || !isNull (findDisplay 49)) exitWith {};

    // Use the camera position as center for nearby player detection.
    private _cameraPosAGL = positionCameraToWorld [0, 0, 0];
    private _cameraPosASL = AGLToASL _cameraPosAGL;
    private _fov = (call CFUNC(getFOV)) * 3;

    // use Nametags nearObjects to not call it Multible Times
    private _nearUnits = [QEGVAR(Nametags,nearUnits), {_this nearObjects ["CAManBase", 31]}, _cameraPosAGL, 1, QGVAR(clearNearUnits)] call CFUNC(cachedCall);

    {
        private _targetSide = side (group _x);

        if (_x != PRA3_Player && alive _x && playerSide getFriend _targetSide >= 0.6 && {_x getVariable [QGVAR(isUnconscious), false] || _x getVariable [QGVAR(bloodLoss), 0] != 0 || !(_x getVariable [QGVAR(DamageSelection),[0,0,0,0,0,0,0]] isEqualTo [0,0,0,0,0,0,0])}) then {
            private _tagPositionAGL = _x modelToWorldVisual (_x selectionPosition "spine2");
            private _tagPositionASL = AGLtoASL _tagPositionAGL;
            private _wts = worldToScreen _tagPositionAGL;

            if (!(_wts isEqualTo []) && {(lineIntersectsSurfaces [_cameraPosASL, _tagPositionASL, PRA3_Player, _x] isEqualTo [])}) then {

                // Calculate the alpha value of the display color based on the distance to player object.
                private _distance = _cameraPosAGL distance _tagPositionAGL;
                if (_distance <= 0 || _distance > 31) exitWith {};
                private _alpha = ((1 - 0.2 * (_distance - 25)) min 1) * 0.8;

                private _size =_fov * 1 / _distance;

                _alpha = _alpha * ((1 - ( abs ((_wts select 0) - 0.5) min 0.7)) max 0);

                private _color = [1, 1, 1, _alpha];

                private _text = "";
                private _icon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
                if (_x getVariable [QGVAR(isUnconscious), false] && _x getVariable [QGVAR(bloodLoss), 0] == 0) then {
                    if (cursorTarget isEqualTo _x && !(_x getVariable [QGVAR(medicalActionIsInProgress), false])) then {
                        _text = "Press Space to Revive";
                    };
                } else {
                    if (_x getVariable [QGVAR(bloodLoss), 0] != 0) then {
                        _icon = "\A3\Ui_f\data\IGUI\Cfg\Cursors\unitbleeding_ca.paa";
                    } else {
                        if !(_x getVariable [QGVAR(DamageSelection),[0,0,0,0,0,0,0]] isEqualTo [0,0,0,0,0,0,0]) then {
                            _icon = "\A3\UI_f\data\IGUI\Cfg\Actions\heal_ca.paa";
                        };
                    };
                };
                drawIcon3D [_icon, _color, _tagPositionAGL, 3 * _size, 3 * _size, 0, _text, 2, 0.15 * _size, "PuristaMedium", "center", true];
            };
        };
    } count _nearUnits;
}];
