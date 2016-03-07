#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    -

    Returns:
    -
*/

// Storage for mutex functions
GVAR(mutexCache) = [];

// EH which fires on server response
QGVAR(mutexLock) addPublicVariableEventHandler {
    // Its time to execute out cached functions.
    {
        _x params ["_code", "_args"];
        _args call _code;
        nil
    } count GVAR(mutexCache);

    // Empty the cache
    GVAR(mutexCache) = [];

    // Tell the server that we finished
    GVAR(mutexLock) = false;
    publicVariableServer QGVAR(mutexLock);
};