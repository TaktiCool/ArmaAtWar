#include "script_macros.hpp"

params ["_dialog"];

[GVAR(respawnScreenPFH)] call CBA_fnc_removePerFrameHandler;
