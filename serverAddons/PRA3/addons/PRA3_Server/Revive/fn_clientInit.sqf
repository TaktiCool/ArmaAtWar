#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Client Init of Revive Module

    Parameter(s):
    -

    Returns:
    -
*/

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

GVAR(lastKilledFrame) = 0;


// PP Effects
GVAR(colorEffectCC) = ["colorCorrections", 1632, [1, 1, 0.15, [0.3, 0.3, 0.3, 0], [0.3, 0.3, 0.3, 0.3], [1, 1, 1, 1]]] call CFUNC(createPPEffect);
GVAR(vigEffectCC) = ["colorCorrections", 1633, [1, 1, 0, [0.15, 0, 0, 1], [1.0, 0.5, 0.5, 1], [0.587, 0.199, 0.114, 0], [1, 1, 0, 0, 0, 0.2, 1]]] call CFUNC(createPPEffect);
GVAR(blurEffectCC) = ["dynamicBlur", 525, [0]] call CFUNC(createPPEffect);
GVAR(PPEffects) = [GVAR(colorEffectCC),GVAR(vigEffectCC),GVAR(blurEffectCC)];


// Bleedout Timer
[QFUNC(bleedoutTimer), 0] call CFUNC(addPerFrameHandler);

[{
    private _action = PRA3_Player getVariable [QGVAR(medicalActionInProgress),""];
    if (_action == "") exitWith {
        if (!isnull (uiNamespace getVariable [UIVAR(MedicalInfo), displayNull])) then {
            ([UIVAR(MedicalInfo)] call bis_fnc_rscLayer) cutFadeOut 0.1;
        };
    };
    private _display =  uiNamespace getVariable [UIVAR(MedicalInfo), displayNull];
    if (isnull _display) then {
        ([UIVAR(MedicalInfo)] call bis_fnc_rscLayer) cutRsc [UIVAR(MedicalInfo),"plain", 0];
        _display =  uiNamespace getVariable [UIVAR(MedicalInfo), displayNull];
    };
    private _text = "<img size='1' color='#ffffff' image='\A3\UI_f\data\IGUI\Cfg\Actions\heal_ca.paa'/><br />You'll be ";

    if (_action == "BANDAGE") then {
        _text = _text + "bandaged!";
    };

    if (_action == "HEAL") then {
        _text = _text + "healed!";
    };

    if (_action == "REVIVE") then {
        _text = _text + "revived!";
    };

    (_display displayCtrl 5000) ctrlSetStructuredText parseText _text;
    (_display displayCtrl 5000) ctrlSetFade 0;
    (_display displayCtrl 5000) ctrlCommit 0;
}, 0.2] call CFUNC(addPerFrameHandler);

["healUnit", {
    [PRA3_Player, QGVAR(DamageSelection), [0,0,0,0,0,0,0]] call CFUNC(setVariablePublic);
}] call CFUNC(addEventhandler);

["stopBleeding", {
    [PRA3_Player, QGVAR(bloodLoss), 0] call CFUNC(setVariablePublic);
}] call CFUNC(addEventhandler);

["unregisterHealer", QFUNC(unregisterHealer)] call CFUNC(addEventhandler);
["registerHealer", QFUNC(registerHealer)] call CFUNC(addEventhandler);

["Killed", QFUNC(killedEH)] call CFUNC(addEventhandler);

["UnconsciousnessChanged", QFUNC(UnconsciousnessChanged)] call CFUNC(addEventhandler);


["Respawn", {
    (_this select 0) params ["_unit"];
    _unit setVariable [QGVAR(bleedOutTime), 0, true];
    DUMP("resetMedicalVars: UnconChanged")
    ["UnconsciousnessChanged", [false, _unit]] call CFUNC(localEvent);
    [_unit, QGVAR(DamageSelection), [0,0,0,0,0,0,0]] call CFUNC(setVariablePublic);
    [_unit, QGVAR(bloodLoss), 0] call CFUNC(setVariablePublic);
    [_unit, QGVAR(HealingProgress), 0] call CFUNC(setVariablePublic);
    [_unit, QGVAR(HealingRate), 0] call CFUNC(setVariablePublic);
    [_unit, QGVAR(HealingTimestamp), -1] call CFUNC(setVariablePublic);
}] call CFUNC(addEventhandler);


// reset all Eventhandler on player Changed Event
["playerChanged", {
    (_this select 0) params ["_currentPlayer", "_oldPlayer"];
    _currentPlayer addEventHandler ["handleDamage", FUNC(handleDamage)];
    // disable Healing
    _currentPlayer addEventHandler ["HitPart", {0}];
    _currentPlayer addEventHandler ["Hit", {0}];
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
