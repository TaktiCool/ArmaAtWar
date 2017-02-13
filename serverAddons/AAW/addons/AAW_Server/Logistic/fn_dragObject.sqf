#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas

    Description:
    Attach Object to Player and let him drag it

    Parameter(s):
    0: Object that the Unit will Drag <Object> (Default: objNull)
    1: Player that Drag the Object <Object> (Default: objNull)

    Returns:
    None
*/

params [
    ["_draggedObject", objNull, [objNull]],
    ["_unit", objNull, [objNull]]
];

#define MAXWEIGHT 800

private _currentWeight = _draggedObject call FUNC(getWeight);
if (_currentWeight >= MAXWEIGHT) exitWith {
    [format [MLOC(itemToHeavy), _currentWeight - MAXWEIGHT]] call EFUNC(Common,displayNotification);
};

if (_draggedObject isKindOf "StaticWeapon") then {
    private _gunner = gunner _draggedObject;
    if (alive _gunner && !isNull _gunner) then {
        _gunner setPosASL getPosASL _gunner;
    };
};

private _position = getPos _unit;
_draggedObject setPos _position;
private _attachPoint = [0, 0, 0];
_unit setVariable [QGVAR(Item), _draggedObject, true];
_draggedObject setVariable [QGVAR(Player), _unit, true];
if (_draggedObject isKindOf "StaticWeapon" || _currentWeight >= MAXWEIGHT / 2) then {
    _unit playActionNow "grabDrag";
    _attachPoint = [0, 1.3, ((_draggedObject modelToWorld [0, 0, 0]) select 2) - ((_unit modelToWorld [0, 0, 0]) select 2)];
} else {
    _attachPoint = [0, 1.3, ((_draggedObject modelToWorld [0, 0, 0]) select 2) - ((_unit modelToWorld [0, 0, 0]) select 2) + 0.5];
    _unit action ["SwitchWeapon", _unit, _unit, 99];
    if (_unit == CLib_Player) then {
        ["forceWalk", "Logistic", true] call CFUNC(setStatusEffect);
    };
};

_attachPoint = _attachPoint vectorAdd (_draggedObject getVariable ["logisticOffset", [0, 0, 0]]);
_draggedObject attachTo [_unit, _attachPoint];

[{
    params ["_args", "_id"];
    _args params ["_unit"];
    if (isNull objectParent _unit) exitWith {};
    [_unit] call FUNC(dropObject);
    [_id] call CFUNC(removePerFrameHandler);
}, 1, _unit] call CFUNC(addPerFrameHandler);
