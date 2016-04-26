#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Init for Interaction

    Parameter(s):
    None

    Returns:
    None
*/

if !(hasInterface) exitWith {};
GVAR(Interaction_Actions) = [];
GVAR(PlayerInteraction_Actions) = [];
["cursorTargetChanged", QFUNC(loop)] call FUNC(addEventhandler);
["playerChanged", {
    params ["_data", "_params"];
    _data params ["_currentPlayer", "_oldPlayer"];

    {
        _x params ["_id", "_text", "_callback", "_args", "_condition"];
        _oldPlayer removeAction _id;
        _id = _currentPlayer addAction [_currentPlayer call _text, _callback, _args, 1.5, false, true, "", _condition];
        _x set [0, _id];
        nil
    } count GVAR(PlayerInteraction_Actions);
}] call FUNC(addEventhandler);
