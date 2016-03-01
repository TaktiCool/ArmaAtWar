#include "macros.hpp"
/*
    Project Reality ArmA 3 - Core\fn_compile.sqf

    Author: joko // Jonas

    Description:
    Compile and Compress a function

    Parameter(s):
    0: Path to Function <STRING>
    1: Function Name <STRING>

    Returns:
    None
*/
if !(isServer) exitWith {};
params [["_functionPath", "", [""]], ["_functionVarName", "", [""]]];

private _funcString = preprocessFileLineNumbers _functionPath;

// 0.NewLine 1.Tab
private _toRemoveString = [10, 9];

private _funcArray = toArray _funcString;

_funcArray = _funcArray select {!(_x in _toRemoveString)};

_funcString = toString _funcArray;

_fncCode = compileFinal preprocessFileLineNumbers _functionPath;
{
    _x setVariable [_functionName, _fncCode];
    nil
} count [missionNamespace, uiNamespace, parsingNamespace];

EGVAR(AutoLoad,functionCache) pushBack _functionName;
nil
