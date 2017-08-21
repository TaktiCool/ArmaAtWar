#include "macros.hpp"
/*
    Community Lib - CLib

    Author: NetFusion

    Description:
    PreStart

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(wsServer) = "tcp://localhost:8888";

DUMP("CONNECTING");
GVAR(connectionId) = [-1, "CLibSocket", "Connect", GVAR(wsServer)] call CFUNC(extensionRequest);
if (GVAR(connectionId) == "error") exitWith {};

[-1, "CLibSocket", "Send", format ["%1:%2", GVAR(connectionId), "SERVER"]] call CFUNC(extensionRequest);
