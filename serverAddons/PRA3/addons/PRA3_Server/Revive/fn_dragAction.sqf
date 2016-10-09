#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Initialization of drag action

    Parameter(s):
    None

    Returns:
    None
*/

DFUNC(dropPlayer) = {
    params ["_unit"];
    private _draggedObject = _unit getVariable [QGVAR(draggedPlayer), objNull];
    detach _draggedObject;
    _unit playAction "released";
    [QGVAR(stopGettingDraggedAnimation),[_draggedObject]] call CFUNC(globalEvent);
    /*
    if (_unit == PRA3_Player) then {
        ["forceWalk","Logistic",false] call PRA3_Core_fnc_setStatusEffect;
    };
    */
    if (isNull _draggedObject) exitWith {};
    ["enableSimulation", [_draggedObject, true]] call CFUNC(serverEvent);
    _unit setVariable [QGVAR(draggedPlayer), objNull, true];
    _draggedObject setVariable [QGVAR(draggedBy), objNull, true];
    private _position = getPosATL _draggedObject;
    if (_position select 2 < 0) then {
        _position set [2, 0];
        _draggedObject setPosATL _position;
    };
    ["fixFloating", _draggedObject, _draggedObject] call CFUNC(targetEvent);
    ["fixPosition", _draggedObject, _draggedObject] call CFUNC(targetEvent);
};

[
    {"Drag"},
    "CAManBase",
    2,
    {
        alive _target && _target getVariable [QGVAR(isUnconscious),false];
    },
    {
        params ["_draggedUnit"];
        [{
            params ["_draggedUnit", "_unit"];

            private _position = getPos _unit;
            _draggedUnit setPos _position;
            private _attachPoint = [0,0,0];
            _unit setVariable [QGVAR(draggedPlayer), _draggedUnit, true];
            _draggedUnit setVariable [QGVAR(draggedBy), _unit, true];


            _attachPoint = [0, 1.1, ((_draggedUnit modelToWorld [0,0,0]) select 2) - ((_unit modelToWorld [0,0,0]) select 2)];

            _attachPoint = _attachPoint vectorAdd (_draggedUnit getVariable ["logisticOffset", [0,0,0]]);
            _draggedUnit attachTo [_unit, _attachPoint];

            _unit playActionNow "grabDrag";

            [QGVAR(startGettingDraggedAnimation),[_draggedUnit]] call CFUNC(globalEvent);

            [{
                params ["_args", "_id"];
                _args params ["_unit"];
                if (_unit == vehicle _unit) exitWith {};
                [_unit] call FUNC(dropPlayer);
                [_id] call CFUNC(removePerFrameHandler);
            }, 1,_unit] call CFUNC(addPerFrameHandler);
        }, [_draggedUnit, PRA3_Player], "logistic"] call CFUNC(mutex);
    }
] call CFUNC(addAction);

[QGVAR(startGettingDraggedAnimation), {
    (_this select 0) params ["_unit"];
    if (local _unit) then {
        _unit setDir 180;
    };

    _unit switchMove "AinjPpneMrunSnonWnonDb_grab";

}] call CFUNC(addEventhandler);

[QGVAR(stopGettingDraggedAnimation), {
    (_this select 0) params ["_unit"];
    _unit switchMove "unconsciousrevivedefault";
}] call CFUNC(addEventhandler);


[
    "Drop",
    PRA3_Player,
    0,
    {!(isNull (PRA3_Player getVariable [QGVAR(draggedPlayer), objNull]))},
    {
        [PRA3_Player] call FUNC(dropPlayer);
    }, ["ignoredCanInteractConditions",["isNotPlayerDragging"]]
] call CFUNC(addAction);

["isNotPlayerDragging", {
    isNull (_caller getVariable [QGVAR(draggedPlayer), objNull]) &&
    isNull (_target getVariable [QGVAR(draggedPlayer), objNull])
 }] call CFUNC(addCanInteractWith);
