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

GVAR(wsServer) = "ws://localhost:8888";

DUMP("CONNECTING");
GVAR(connectionId) = [-1, "CLibWebSocket", "Connect", GVAR(wsServer)] call CFUNC(extensionRequest);
if (GVAR(connectionId) == "error") exitWith {};

[-1, "CLibWebSocket", "Send", format ["%1:%2", GVAR(connectionId), ["SERVER", serverName] joinString ":"]] call CFUNC(extensionRequest);
