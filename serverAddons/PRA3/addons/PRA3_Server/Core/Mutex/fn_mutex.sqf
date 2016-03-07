#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Executes a block of code and prevents it from being partially executed on different clients.

    Parameter(s):
    0: Code which gets executed <Code>

    Returns:
    <Anything>
*/
params [["_code", {}], ["_args", []]];

// Cache the function and args
GVAR(mutexCache) pushBack [_code, _args];

// Tell the server that there is something to execute
GVAR(mutexToken) = PRA3_Player;
publicVariableServer QGVAR(mutexToken);