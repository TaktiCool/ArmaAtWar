#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Append Unit to SendFunctions Queue if the mission is allready Trigger else it just pushes the functions

    Parameter(s):
    0: Client UID <Number>

    Returns:
    None
*/

params [["_functionName", ""], ["_clientID", -1], ["_index", 0]];

if (GVAR(useFunctionCompression)) then {
    private _functionCode = parsingNamespace getVariable [_functionName + "_Compressed", ""];
} else {
    private _functionCode = parsingNamespace getVariable [_functionName, {}];
    // Remove leading and trailing braces from the code.
    _functionCode = _functionCode call CFUNC(codeToString);
};

// Transfer the function name, code and progress to the client.
GVAR(receiveFunction) = [_functionName, _functionCode, _index / GVAR(countRequiredFnc)];


DUMP("sendFunction: " + _functionName + ", " + str (GVAR(receiveFunction) select 2))

_clientID publicVariableClient QGVAR(receiveFunction);
