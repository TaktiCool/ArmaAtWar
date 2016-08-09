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
        _x params ["_id", "_text", "_condition", "_callback", "_args", "_priority", "_showWindow", "_hideOnUse", "_shortcut", "_radius", "_unconscious", "_onActionAdded"];
        _oldPlayer removeAction _id;
        private _argArray = [_currentPlayer call _text, _callback, _args, _priority, _showWindow, _hideOnUse, _shortcut, _condition, _radius, _unconscious];
        private _id = _currentPlayer addAction _argArray;
        [_id, _currentPlayer, _argArray] call _onActionAdded;
        _x set [0, _id];
        nil
    } count GVAR(PlayerInteraction_Actions);
}] call FUNC(addEventhandler);
