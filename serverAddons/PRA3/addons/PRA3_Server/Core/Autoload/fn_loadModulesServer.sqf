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
private _modules = [];

// Function for Cross Dependencys
private _fnc_addDependencyModule = {
    params ["_name"];
    private _i = _modules pushBackUnique _name;
    if (_i != -1) then {
        if (_name in (GVAR(Dependencies) select 0)) then {
            private _index = (GVAR(Dependencies) select 0) find _name;
            {
                _x call _fnc_addDependencyModule;
                nil
            } count ((GVAR(Dependencies) select 1) select _index);
        };
    };
};

{
    _x call _fnc_addDependencyModule;
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

    // required Function that the Client needed
    GVAR(RequiredFncClient) = GVAR(requiredFunctions) select {(toLower(_x) find "_fnc_serverinit" < 0)};

    // Count requiredFunctions array and filter serverinit they dont need to sendet
    GVAR(countRequiredFnc) = count GVAR(RequiredFncClient) - 1;

    QGVAR(registerClient) addPublicVariableEventHandler {

        // Determine client id by provided object (usually the player object).
        private _clientID = owner (_this select 1);

        {
            // Extract the code out of the function.
            private _functionCode = parsingNamespace getVariable [_x, {}];
            // Remove leading and trailing braces from the code.
            _functionCode = _functionCode call CFUNC(codeToString);

            // Transfer the function name, code and progress to the client.
            GVAR(receiveFunction) = [_x, _functionCode, _forEachIndex / GVAR(countRequiredFnc)];
            _clientID publicVariableClient QGVAR(receiveFunction);
        } forEach GVAR(RequiredFncClient);
    };
};
// Call all required function on the server.
call FUNC(callModules);
