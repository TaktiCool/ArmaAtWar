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

_text = "";
_lastTarget = cursorObject;
PRA3_Player setVariable [QGVAR(lastTarget), _lastTarget, true];
{
    _x params ["_onObject", "_text", "_condition", "_code", "_args"];
    _text = (call (_text));
    private _objActions = _lastTarget getVariable [QGVAR(Interaction_Actions), []];
    if (!(_x in _objActions)) then {
        if (_onObject isEqualType "") then {
            if (_lastTarget isKindOf _onObject) then {
                _lastTarget addAction [_text, _code, _args, 1.5, true, true, "", _condition];
                _objActions pushBack _x;
                _lastTarget setVariable [QGVAR(Interaction_Actions), _objActions];
            };
        };
        if (_onObject isEqualType objNull) then {
            if ([_lastTarget] find _onObject > -1) then {
                _lastTarget addAction [_text, _code, _args, 1.5, true, true, "", _condition];
                _objActions pushBack _x;
                _lastTarget setVariable [QGVAR(Interaction_Actions), _objActions];
            };
        };
    };
    false
} count GVAR(Interaction_Actions);

[FUNC(loop),{!isNull cursorObject && cursorObject != _this}, _lastTarget] call CFUNC(waitUntil);
