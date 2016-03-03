#include "macros.hpp"
/*
    Project Reality ArmA 3 - Autoload\fn_callModules.sqf

    Author: NetFusion

    Description:
    Calls all init functions of all required modules for server and client. This should be called after modules are loaded (functions transferred).

    Parameter(s):
    None

    Returns:
    None

    Example:
    call FUNC(callModules);
*/
private _init = [];
private _serverInit = [];
private _postInit = [];
private _clientInit = [];
private _hcInit = [];
// Cycle through all available functions and determine whether to call them or not.
{
    // Client only functions.
    if (_x find "_fnc_clientInit" > 0) then {
        _clientInit pushBack _x;
    };
    // Server only functions.
    if (_x find "_fnc_serverInit" > 0) then {
        _serverInit pushBack _x;
    };
    // HC only functions.
    if (_x find "_fnc_hcInit" > 0) then {
        _hcInit pushBack _x;
    };
    // Functions for both.
    if (_x find "_fnc_init" > 0) then {
        _init pushBack _x;
    };
    if (_x find "_fnc_postInit" > 0) then {
        _postInit pushBack _x;
    };
    nil
} count GVAR(requiredFunctions);

{
    call compile ("call "+ _x);
    DUMP("Call: " + _x)
    nil
} count _init;

if (isServer) then {
    {
        call compile ("call "+ _x);
        DUMP("Call: " +  _x)
        nil
    } count _serverInit;
};

if (hasInterface) then {
    {
        call compile ("call "+ _x);
        DUMP("Call: " + _x)
        nil
    } count _clientInit;
};

if (!hasInterface && !isServer) then {
    {
        call compile ("call "+ _x);
        DUMP("Call: " + _x)
        nil
    } count _hcInit;
};

{
    call compile ("call "+ _x);
    DUMP("Call: " + _x)
    nil
} count _postInit;
