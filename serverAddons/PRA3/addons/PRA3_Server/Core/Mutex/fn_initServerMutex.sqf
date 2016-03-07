#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Init for Mutex System on Server

    Parameter(s):
    None

    Returns:
    None
*/
// Variable which indicates if some client is currently executing
GVAR(mutexLock) = false;

// Queue of clients who requested mutex executing
GVAR(mutexQueue) = [];

// EH which fired if some client requests mutex executing
[QGVAR(mutexRequest), {
    // We enqueue the value in the queue
    GVAR(mutexQueue) pushBackUnique (_this select 0);
}] call CFUNC(addEventHandler);

// We check on each frame if we can switch the mutex client
[{
    // Check if mutex lock is open and client in the queue
    if (!GVAR(mutexLock) && !(GVAR(mutexQueue) isEqualTo [])) then {
        // Lock the mutex
        GVAR(mutexLock) = true;
        // Tell the client that he can start and remove him from the queue
        [QGVAR(mutexLock), GVAR(mutexQueue) deleteAt 0] call CFUNC(targetEvent);
    };
}] call CFUNC(addPerFrameHandler);
