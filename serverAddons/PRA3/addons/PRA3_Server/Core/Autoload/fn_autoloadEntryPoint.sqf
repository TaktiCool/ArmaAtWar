#include "macros.hpp"
/*
    Project Reality ArmA 3 - Autoload\fn_autoloadEntryPoint.sqf

    Author: NetFusion

    Description:
    Entry point for autoloader. This should be the first called function for everything to work properly.
    Provides an entry point for all clients. Must be called in preInit.

    Parameter(s):
    None

    Returns:
    None
*/

// Transfers entry function from server to all clients.
if (isServer) then { [getArray (missionConfigFile >> "PRA3" >> "loadModules"), FUNC(loadModules)] remoteExec ["BIS_fnc_call", 0, true]; };
