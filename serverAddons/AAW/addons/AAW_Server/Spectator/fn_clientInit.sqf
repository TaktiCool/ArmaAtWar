#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Client Init for Spectator

    Parameter(s):
    None

    Returns:
    None
*/
if !(side CLib_player == sideLogic && {player isKindOf "VirtualSpectator_F"}) exitWith {};
[{
    ["Terminate"] call BIS_fnc_EGSpectator;
    // Create Camera
    
}, {
    (missionNamespace getVariable ["BIS_EGSpectator_initialized", false]) && !isNull findDisplay 60492;
}] call CFUNC(waitUntil);
