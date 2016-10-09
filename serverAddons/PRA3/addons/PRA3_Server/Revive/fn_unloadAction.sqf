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

        [QGVAR(unloadUnit), _draggedUnit, [getPosASL PRA3_player]] call CFUNC(targetEvent);
    }
] call CFUNC(addAction);

[QGVAR(unloadUnit), {
    if (vehicle PRA3_player != PRA3_player) then {
        (_this select 0) params ["_position"];
        unassignVehicle PRA3_player;
        PRA3_player action ["Eject", vehicle PRA3_player];
        [{
            params ["_position"];
            PRA3_player setPosASL _position;

            if !(PRA3_player getVariable [QGVAR(isUnconscious), false]) then {
                if (driver PRA3_player == PRA3_player) then {
                    [QGVAR(stopGettingDraggedAnimation),[_draggedObject]] call CFUNC(globalEvent);
                };
            };
        }, 0.5, [_position]] call CFUNC(wait);
    };

}] call CFUNC(addEventhandler);
