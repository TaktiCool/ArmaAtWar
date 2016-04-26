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
(_this select 0) params ["_lastTarget"];

private _objActions = _lastTarget getVariable [QGVAR(Interaction_Actions), []];
if (_objActions isEqualTo GVAR(Interaction_Actions)) exitWith {};
{
    _x params ["_onObject", "_text", "_condition", "_code", "_args"];
    _text = _lastTarget call (_text);

    if !(_x in _objActions) then {
        if (_onObject isEqualType "") then {
            if (_lastTarget isKindOf _onObject) then {
                _lastTarget addAction [_text, _code, _args, 1.5, true, true, "", _condition];
                _objActions pushBackUnique _x;
            };
        };

        if (_onObject isEqualType objNull) then {
            if ([_lastTarget] find _onObject > -1) then {
                _lastTarget addAction [_text, _code, _args, 1.5, true, true, "", _condition];
                _objActions pushBackUnique _x;
            };
        };
    };
    nil
} count GVAR(Interaction_Actions);

_lastTarget setVariable [QGVAR(Interaction_Actions), _objActions];
