#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Drop Dragged Objecte

    Parameter(s):
    0: Unit that Drag a Object <Object>

    Returns:
    None
*/
params ["_unit"];
private _draggedObject = _unit getVariable [QGVAR(Item), objNull];
detach _draggedObject;
_unit playAction "released";
if (_unit == CLib_Player) then {
    ["forceWalk","Logistic",false] call PRA3_Core_fnc_setStatusEffect;
};
if (isNull _draggedObject) exitWith {};
["enableSimulation", [_draggedObject, true]] call CFUNC(serverEvent);
_unit setVariable [QGVAR(Item), objNull, true];
_draggedObject setVariable [QGVAR(Player), objNull, true];
private _position = getPosATL _draggedObject;
if (_position select 2 < 0) then {
    _position set [2, 0];
    _draggedObject setPosATL _position;
};
["fixFloating", _draggedObject, _draggedObject] call CFUNC(targetEvent);
["fixPosition", _draggedObject, _draggedObject] call CFUNC(targetEvent);
if (_unit isEqualTo vehicle _unit) then {
    _unit action ["SwitchWeapon", _unit, _unit, 0];
};
