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
// Queue of clients who requested mutex executing
GVAR(mutexes) = call CFUNC(createNamespace); // Entries are [currentClient, clientQueue]

DFUNC(checkNextMutexClient) = {
    params ["_mutexId"];

    private _mutex = [GVAR(mutexes), _mutexId, [0, []]] call CFUNC(getVariable);
    _mutex params ["_currentClient", "_clientQueue"];

    if (!(_clientQueue isEqualTo [])) then {
        _currentClient = _clientQueue deleteAt 0;
        GVAR(mutexes) setVariable [_mutexId, [_currentClient, _clientQueue]];
        [QGVAR(mutexLock), _currentClient, _mutexId] call CFUNC(targetEvent);
    };
};

// Handle disconnect of client
[QGVAR(mutex), "onPlayerDisconnected", {
    params ["_id", "_name", "_uid", "_owner", "_jip"];

    {
        private _mutex = [GVAR(mutexes), _x, [0, []]] call CFUNC(getVariable);
        _mutex params ["_currentClient", "_clientQueue"];

        // Clean the queue
        private _index =_clientQueue find _owner;
        if (_index != -1) then {
            _clientQueue deleteAt _index;
        };
        GVAR(mutexes) setVariable [_x, [_currentClient, _clientQueue]];

        // If the client is currently executing reset the lock
        if (_currentClient == _owner) then {
            _x call FUNC(checkNextMutexClient);
        };

        nil
    } count (allVariables GVAR(mutexes));

    false
}] call BIS_fnc_addStackedEventHandler;

// EH which fired if some client requests mutex executing
[QGVAR(mutexRequest), {
    (_this select 0) params ["_clientObject", "_mutexId"];

    private _mutex = [GVAR(mutexes), _mutexId, [0, []]] call CFUNC(getVariable);
    _mutex params ["_currentClient", "_clientQueue"];

    // We enqueue the value in the queue
    _clientQueue pushBackUnique (owner _clientObject);
    GVAR(mutexes) setVariable [_mutexId, [_currentClient, _clientQueue]];

    if (_currentClient == 0) then {
        // Tell the client that he can start and remove him from the queue
        _mutexId call FUNC(checkNextMutexClient);
    };
}] call CFUNC(addEventHandler);

[QGVAR(unlockMutex), {
    (_this select 0) params ["_mutexId"];

    private _mutex = [GVAR(mutexes), _mutexId, [0, []]] call CFUNC(getVariable);
    _mutex params ["_currentClient", "_clientQueue"];
    GVAR(mutexes) setVariable [_mutexId, [0, _clientQueue]];

    // Tell the client that he can start and remove him from the queue
    _mutexId call FUNC(checkNextMutexClient);
}] call CFUNC(addEventHandler);
