/*
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
    true spawn JK_Core_fnc_Interaction_loop;
*/

_text = "";
_lastTarget = cursorTarget;
player setVariable ["JK_LastTarget",_lastTarget,true];
{
    params ["_onObject", "_text"];
    _text = (call (_text));
    _objActions = _lastTarget getVariable ["JK_Core_Interaction_Actions", []];
    if (!(_x in _objActions)) then {
        if (typeName _onObject == "STRING") then {
            if (_lastTarget isKindOf _onObject) then {
                _lastTarget addAction [_text, _x select 3, _x select 4, 1.5, true, true, "", _x select 2];
                _objActions pushBack _x;
                _lastTarget setVariable ["JK_Core_Interaction_Actions", _objActions];
            };
        };
        if (typeName _onObject == "OBJECT") then {
            if ([_lastTarget] find _onObject > -1) then {
                _lastTarget addAction [_text, _x select 3, _x select 4, 1.5, true, true, "", _x select 2];
                _objActions pushBack _x;
                _lastTarget setVariable ["JK_Core_Interaction_Actions", _objActions];
            };
        };
    };
    false
} count JK_Core_Interaction_Actions;
waitUntil {!isNull cursorTarget && cursorTarget != _lastTarget};
true spawn JK_Core_fnc_Interaction_loop;
