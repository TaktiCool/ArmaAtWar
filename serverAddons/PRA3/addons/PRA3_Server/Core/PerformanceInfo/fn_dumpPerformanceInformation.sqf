#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Dump all PRA3 Relevant Varibles to Config

    Parameter(s):
    0: Object or Client owner on what the Dump should get Created <Object, Number>

    Returns:
    None
*/
params ["_unit"];

if !(local _unit) exitWith {
    [_unit] remoteExecCall [_fnc_scriptName, _unit];
};

private ["_var", "_unit", "_fnc_outputText", "_text"];

private _fnc_outputText = {
    if (count (_this select 0) > 1000) exitWith {};
    diag_log text (_this select 0);
    sendlogfile = [(_this select 0), "PERFORMACE_DUMP_" + getPlayerUID PRA3_Player];
    publicVariableServer "sendlogfile";
};

_text = format [
"------PRA3 Debug------
time = %1
ServerTime =%2
------Performance------
diag_fps = %3
count PRA3_core_waitArray = %4
count PRA3_core_waitUntilArray = %5
count PerframeHandler = %6 (AllTime %7)
count diag_activeSQFScripts = %8
count diag_activeSQSScripts = %9
count diag_activeMissionFSMs = %10",
time,
diag_fps,
count GVAR(waitArray),
count GVAR(waitUntilArray),
count GVAR(perFrameHandlerArray), {!(isNil "_x")} count GVAR(PFHhandles),
count diag_activeSQFScripts,
count diag_activeSQSScripts,
count diag_activeMissionFSMs
];
[_text] call _fnc_outputText;


_text = format ["
------Player------
typeOf = %1
animationState = %2",
if (isNull PRA3_Player) then {"null"} else {typeOf PRA3_Player},
if (isNull PRA3_Player) then {"null"} else {animationState PRA3_Player}];
[_text] call _fnc_outputText;


_text = format ["
------PRA3 Variables------"];
[_text] call _fnc_outputText;

private _searchSpaces = [missionNamespace, parsingNamespace, uiNamespace /*dont work in Multiplayer*/];
_searchSpaces append GVAR(allCustomNamespaces);

_searchSpaces append allMissionObjects "";

private _temp = [];
{
    private _space = _x;
    _count = {
        if (_x find "pra3" != -1) then {
            private _var = _space getVariable _x;
            if !(_var isEqualType {}) then {
                if (_var isEqualType []) then {
                    if ((count _var) < 5) then {
                        _text = format ["%1;%2: %3", _space, _x, _var];
                        _temp pushBack _text;
                    };
                } else {
                    _text = format ["%1;%2: %3", _space, _x, _var];
                    _temp pushBack _text;
                };
                true
            } else {
                false
            };
        } else {
            false
        };
    } count (allVariables _space);
    _text = format ["%1 have %2 Varialbe", _space , _count];
    [_text] call _fnc_outputText;
} count _searchSpaces;
{
    [_x] call _fnc_outputText;
} count _temp;
