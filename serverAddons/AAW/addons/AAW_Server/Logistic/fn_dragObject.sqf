#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    Attach Object to Player and let him drag it

    Parameter(s):
    0: Object that the Unit will Drag <Object>
    1: Player that Drag the Object <Object>

    Returns:
    None
*/

#define MAXWEIGHT 800

params ["_draggedObject", "_unit"];
private _currentWeight = _draggedObject call FUNC(getWeight);
if (_currentWeight >= MAXWEIGHT) exitWith {
    ["ITEM TOO HEAVY", format [MLOC(itemToHeavy), _currentWeight - MAXWEIGHT]] call MFUNC(displayHint);
};

if (_draggedObject isKindOf "StaticWeapon") then {
    private _gunner = gunner _draggedObject;
    if (!isNull _gunner && alive _gunner) then {
        _gunner setPosASL getPosASL _gunner;
    };
};

private _position = getPos _unit;
_draggedObject setPos _position;
private _attachPoint = [0, 0, 0];
_unit setVariable [QGVAR(Item), _draggedObject, true];
_draggedObject setVariable [QGVAR(Dragger), _unit, true];
if (_draggedObject isKindOf "StaticWeapon" || _currentWeight >= MAXWEIGHT / 2) then {
    _unit playActionNow "grabDrag";
    _attachPoint = [0, 1.3, ((_draggedObject modelToWorld [0, 0, 0]) select 2) - ((_unit modelToWorld [0, 0, 0]) select 2)];
} else {
    _attachPoint = [0, 1.3, ((_draggedObject modelToWorld [0, 0, 0]) select 2) - ((_unit modelToWorld [0, 0, 0]) select 2) + 0.5];
    _unit action ["SwitchWeapon", _unit, _unit, 99];
    [_unit, "forceWalk", "Logistic", true] call CFUNC(setStatusEffect);
};

_attachPoint = _attachPoint vectorAdd (_draggedObject getVariable ["logisticOffset", [0, 0, 0]]);
_draggedObject attachTo [_unit, _attachPoint];

[{
    params ["_args", "_id"];
    _args params ["_unit", "_draggedObject"];
    if (isNull objectParent _unit || !isNull _draggedObject) exitWith {};
    [_unit] call FUNC(dropObject);
    [_id] call CFUNC(removePerFrameHandler);
}, 1, [_unit, _draggedObject]] call CFUNC(addPerFrameHandler);
