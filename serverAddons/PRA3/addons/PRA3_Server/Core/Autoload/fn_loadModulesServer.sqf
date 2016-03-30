#include "macros.hpp"
/*
    Project Reality ArmA 3 - Autoload\fn_loadModulesServer.sqf

    Author: NetFusion

    Description:
    Server side modules loader (used when AME is present on client too). Prepares the functions for transmission to clients. Should run before client register with server.

    Parameter(s):
    - ARRAY - server only: the names of the requested modules

    Returns:
    -

    Example:
    ["Module1", "Module2"] call FUNC(loadModulesServer);
*/


// Find all functions which are part of the requested modules and store them in an array.
GVAR(requiredFunctions) = [];
private _modules = +_this;

{
    if (_x in (GVAR(Dependencies) select 0)) then {
        private _index = (GVAR(Dependencies) select 0) find _x;
        {
            _modules pushBackUnique _x;
            nil
        } count ((GVAR(Dependencies) select 1) select _index);
    };
    nil
} count _this;

{
    // Extract the module name out of the full function name.
    // 1: Remove "PRA3_" prefix
    private _functionModuleName = _x select [5, count _x - 6];
    // 2: All characters until the next "_" are the module name.
    _functionModuleName = _functionModuleName select [0, _functionModuleName find "_"];

    // Push the function name on the array if its in the requested module list.
    if (_functionModuleName in _modules) then {
        GVAR(requiredFunctions) pushBack _x;
    };
    true
} count GVAR(functionCache);

// EH for client registration. Starts transmission of function code.
if (isServer) then {
    QGVAR(registerClient) addPublicVariableEventHandler {

        // Determine client id by provided object (usually the player object).
        private _clientID = owner (_this select 1);
        // Count requiredFunctions array and filter serverinit they dont need to sendet
        private _count = {toLower(_x) find "_fnc_serverinit" < 0} count GVAR(requiredFunctions);
        {
            // check if this is a serverInit and dont share it
            if (toLower(_x) find "_fnc_serverinit" < 0) then {
                // Extract the code out of the function.
                private _functionCode = parsingNamespace getVariable [_x, {}];
                // Remove leading and trailing braces from the code.
                _functionCode = _functionCode call CFUNC(codeToString);

                // Transfer the function name, code and progress to the client.
                GVAR(receiveFunction) = [_x, _functionCode, _forEachIndex / _count];
                _clientID publicVariableClient QGVAR(receiveFunction);
            };
        } forEach GVAR(requiredFunctions);
    };
};
GVAR(requiredFunctions)
// Call all required function on the server.
call FUNC(callModules);
