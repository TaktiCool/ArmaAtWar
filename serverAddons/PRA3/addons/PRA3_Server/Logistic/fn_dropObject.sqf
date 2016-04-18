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
if (_unit == vehicle _unit) exitWith {};
private _draggedObject = _unit getVariable [QGVAR(Item), objNull];
detach _draggedObject;
_unit playAction "released";
["forceWalk", [_unit, false]] call CFUNC(localEvent);
if (isNull _draggedObject) exitWith {};
["enableSimulation", [_draggedObject, true]] call CFUNC(serverEvent);
_unit setVariable [QGVAR(Item), objNull, true];
_draggedObject setVariable [QGVAR(Player), objNull, true];
detach _draggedObject;
private _position = getPosATL _draggedObject;
if (_position select 2 < 0) then {
    _position set [2, 0];
    _draggedObject setPosATL _position;
};
["fixFloating", _draggedObject, _draggedObject] call CFUNC(targetEvent);
if (_unit isEqualTo vehicle _unit) then {
    _unit action ["SwitchWeapon", _unit, _unit, 0];
};