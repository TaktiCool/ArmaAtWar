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
GVAR(currentMutexClient) = 0;

// Queue of clients who requested mutex executing
GVAR(mutexQueue) = [];

DFUNC(checkNextMutexClient) = {
    if (!(GVAR(mutexQueue) isEqualTo [])) then {
        GVAR(currentMutexClient) = GVAR(mutexQueue) deleteAt 0;
        [QGVAR(mutexLock), GVAR(currentMutexClient)] call CFUNC(targetEvent);
    };
};

// Handle disconnect of client
[QGVAR(mutex), "onPlayerDisconnected", {
    params ["_id", "_name", "_uid", "_owner", "_jip"];

    // Clean the queue
    GVAR(mutexQueue) = GVAR(mutexQueue) select {_x != _owner};

    // If the client is currently executing reset the lock
    if (GVAR(currentMutexClient) == _owner) then {
        call FUNC(checkNextMutexClient);
    };

    false
}] call BIS_fnc_addStackedEventHandler;

// EH which fired if some client requests mutex executing
[QGVAR(mutexRequest), {
    // We enqueue the value in the queue
    GVAR(mutexQueue) pushBackUnique (owner (_this select 0));

    if (GVAR(currentMutexClient) == 0) then {
        // Tell the client that he can start and remove him from the queue
        call FUNC(checkNextMutexClient);
    };
}] call CFUNC(addEventHandler);

[QGVAR(unlockMutex), {
    GVAR(currentMutexClient) = 0;

    // Tell the client that he can start and remove him from the queue
    call FUNC(checkNextMutexClient);
}] call CFUNC(addEventHandler);
