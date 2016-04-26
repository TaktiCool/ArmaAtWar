#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Init for Mutex System on Client

    Parameter(s):
    None

    Returns:
    None
*/

// Storage for mutex functions
GVAR(mutexCache) = [];

// EH which fires on server response
[QGVAR(mutexLock), {
    // Its time to execute out cached functions.
    {
        _x params ["_code", "_args"];
        _args call _code;
        nil
    } count GVAR(mutexCache);

    // Empty the cache
    GVAR(mutexCache) = [];

    // Tell the server that we finished
    [QGVAR(unlockMutex)] call CFUNC(serverEvent);
}] call CFUNC(addEventHandler);
