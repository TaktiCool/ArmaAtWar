#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Executes a block of code and prevents it from being partially executed on different clients.

    Parameter(s):
    0: Code which gets executed <Code>
    1: Aruments for the Code <Any>

    Returns:
    <Any>
*/
params [["_code", {}], ["_args", []]];

// Cache the function and args
GVAR(mutexCache) pushBack [_code, _args];

// Tell the server that there is something to execute
[QGVAR(mutexRequest), PRA3_Player] call CFUNC(serverEvent);