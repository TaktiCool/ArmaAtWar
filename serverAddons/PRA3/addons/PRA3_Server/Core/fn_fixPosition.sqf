#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: commy2 Ported by joko // Jonas

    Description:
    Fixes position of an object. E.g. moves object above ground and adjusts to terrain slope. Requires local object.

    Parameter(s):
    0: Object <Object>

    Returns:
    None
*/
// setVectorUp requires local object
if (!local _this) exitWith {
    ["fixPosition", _this] call CFUNC(targetEvent);
};

if ((getText (configFile >> "CfgVehicles" >> (typeOf _this) >> "simulation")) == "house") then {
    //Houses don't have gravity/physics, so make sure they are not floating
    private _posAbove = (getPos _this) select 2;
    TRACE_2("house",_this,_posAbove);
    if (_posAbove > 0.1) then {
        private _newPosASL = (getPosASL _this) vectorDiff [0,0,_posAbove];
        _this setPosASL _newPosASL;
    };
};

private _position = getPos _this;

// don't place the object below the ground
if (_position select 2 < -0.1) then {
    _position set [2, -0.1];
    _this setPos _position;
};

// adjust position to sloped terrain, if placed on ground
if (getPosATL _this select 2 == _position select 2) then {
    _this setVectorUp surfaceNormal _position;
};
