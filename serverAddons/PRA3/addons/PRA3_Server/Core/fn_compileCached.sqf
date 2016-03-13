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
params [["_functionPath", "", [""]], ["_functionVarName", "", [""]]];

private _cachedFunction = parsingNamespace getVariable _functionVarName;
private _fncCode = if (isNil "_cachedFunction") then {
    private _header = format ["private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'%1'} else {_fnc_scriptName}; private _fnc_scriptName = '%1'; scriptName _fnc_scriptName; scopeName 'Main'; ", _functionVarName, _debug];
    private _funcString = _header + preprocessFileLineNumbers _functionPath;
    compileFinal _funcString;
} else {
    _cachedFunction
};

{
    _x setVariable [_functionVarName, _fncCode];
    nil
} count [missionNamespace, uiNamespace, parsingNamespace];

GVAR(functionCache) pushBack _functionVarName;
nil
