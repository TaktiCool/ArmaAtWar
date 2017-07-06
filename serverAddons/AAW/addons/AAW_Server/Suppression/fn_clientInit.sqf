#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas & LAxemann

    Description:
    Client Init for Suppression Module

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(bulletArray)    = [];
GVAR(suppressed) = false;
GVAR(Threshold) = 0;    // Changing value
GVAR(lastShotAt) = 0;    // The time the player got shot at last time (Just creates the variable)
GVAR(variableHandler) = false call CFUNC(createNamespace);
GVAR(enabled) = true;

GVAR(cc) = ppEffectCreate ["colorCorrections", 1501];
GVAR(cc) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
GVAR(cc) ppEffectEnable true;
GVAR(cc) ppEffectCommit 0;

// Blur
GVAR(blur) = ppEffectCreate ["DynamicBlur", 800];
GVAR(blur) ppEffectAdjust [0];
GVAR(blur) ppEffectCommit 0.3;
GVAR(blur) ppEffectEnable true;

// RBlur
GVAR(rBlur) = ppEffectCreate ["RadialBlur", 1003];
GVAR(rBlur) ppEffectAdjust [0, 0, 0, 0];
GVAR(rBlur) ppEffectCommit 0;
GVAR(rBlur) ppEffectEnable true;


GVAR(impactCC) = ppEffectCreate ["colorCorrections", 1499];
GVAR(impactCC) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
GVAR(impactCC) ppEffectEnable true;
GVAR(impactCC) ppEffectCommit 0;

GVAR(impactBlur) = ppEffectCreate ["RadialBlur", 1002];
GVAR(impactBlur) ppEffectAdjust [0, 0, 0, 0];
GVAR(impactBlur) ppEffectCommit 0;
GVAR(impactBlur) ppEffectEnable true;

// Check if active, exec script if so
[FUNC(bulletHandler)] call CFUNC(addPerFrameHandler);
[{
    if (GVAR(Threshold) > 0) then {
    	private _subtract = call {
    		if (((time - GVAR(lastShotAt)) <= 1.75)) exitWith {0};
    		if (GVAR(Suppressed))  	exitWith {1.2};
    		2
    	};
    	GVAR(Threshold) = (GVAR(Threshold) - _subtract) max 0;
    };
}, 1] call CFUNC(addPerFrameHandler);
[FUNC(pinnedDown), 0.5] call CFUNC(addPerFrameHandler);

["playerChanged", {

    // Resets PinnedDown PP Effects
    GVAR(Suppressed) = false;
    GVAR(cc) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
    GVAR(cc) ppEffectCommit 0;

    // Blur
    GVAR(blur) ppEffectAdjust [0];
    GVAR(blur) ppEffectCommit 0;

    // RBlur
    GVAR(rBlur) ppEffectAdjust [0, 0, 0, 0];
    GVAR(rBlur) ppEffectCommit 0;

    // reset Variables that PPEffects dont get reactivated
    GVAR(Threshold) = 0;
    GVAR(lastShotAt) = 0;

    // Resets Impact PP Effects
    GVAR(impactBlur) ppEffectAdjust [0, 0, 0, 0];
    GVAR(impactBlur) ppEffectCommit 0;

    GVAR(impactCC) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
    GVAR(impactCC) ppEffectCommit 0;

    // rest CamShake Effect
    resetCamShake;
}] call CFUNC(addEventHandler);

// Bind Fired EH to all Units
["entityCreated", {
    (_this select 0) params ["_unit"];
    if (_unit isKindOf "CAManBase") then {
        _unit addEventHandler ["FiredMan", {
            _this call FUNC(fired);
        }];
    };
}] call CFUNC(addEventhandler);
