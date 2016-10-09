#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Action to unload an unconscious unit out of a vehicle

    Parameter(s):
    -

    Returns:
    -
*/

[
    {"Unload wounded person"},
    ["LandVehicle", "Air", "Ship"],
    3,
    {
        call {
            scopeName "ActionCondition";
            private _cond = false;
            {
                //hintSilent format ["TEST: %1", _x getVariable [QGVAR(isUnconscious), false]];
                if (_x getVariable [QGVAR(isUnconscious), false]) then {
                    _cond = true;
                    breakTo "ActionCondition";
                };
            } count crew _target;
            _cond;
        };
    },
    {
        params ["_targetVehicle"];
        scopeName "unloadUnit";
        private _draggedUnit = objNull;
        {
            if (_x getVariable [QGVAR(isUnconscious), false]) then {
                _draggedUnit = _x;
                breakTo "unloadUnit";
            };
        } count crew _targetVehicle;

        if (isNull _draggedUnit) exitWith {};

        [QGVAR(unloadUnit), _draggedUnit, [getPosASL CLib_Player]] call CFUNC(targetEvent);
    }
] call CFUNC(addAction);

[QGVAR(unloadUnit), {
    if (vehicle CLib_Player != CLib_Player) then {
        (_this select 0) params ["_position"];
        unassignVehicle CLib_Player;
        CLib_Player action ["Eject", vehicle CLib_Player];
        [{
            params ["_position"];
            CLib_Player setPosASL _position;

            if !(CLib_Player getVariable [QGVAR(isUnconscious), false]) then {
                if (driver CLib_Player == CLib_Player) then {
                    [QGVAR(stopGettingDraggedAnimation),[_draggedObject]] call CFUNC(globalEvent);
                };
            };
        }, 0.5, [_position]] call CFUNC(wait);
    };

}] call CFUNC(addEventhandler);
