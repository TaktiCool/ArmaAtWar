#include "macros.hpp"
/*
        Project Reality ArmA 3

    Author: NetFusion

    Description:
    Continuously checks whether an action should be added to the cursorTarget.

    Parameter(s):
    -

    Remarks:
    * Should only be called once per mission.

    Returns:
    -

    Example:
    true call FUNC(loop);
*/

private _lastTarget = cursorTarget;

private _objActions = _lastTarget getVariable [QGVAR(Interaction_Actions), []];

{
    _x params ["_onObject", "_text", "_condition", "_code", "_args"];
    _text = call (_text);

    if !(_x in _objActions) then {
        if (_onObject isEqualType "") then {
            if (_lastTarget isKindOf _onObject) then {
                _lastTarget addAction [_text, _code, _args, 1.5, true, true, "", _condition];
                _objActions pushBack _x;
            };
        };

        if (_onObject isEqualType objNull) then {
            if ([_lastTarget] find _onObject > -1) then {
                _lastTarget addAction [_text, _code, _args, 1.5, true, true, "", _condition];
                _objActions pushBack _x;
            };
        };
    };
    nil
} count GVAR(Interaction_Actions);

_lastTarget setVariable [QGVAR(Interaction_Actions), _objActions];

[FUNC(loop),{!isNull cursorTarget && cursorTarget != _this}, _lastTarget] call CFUNC(waitUntil);
