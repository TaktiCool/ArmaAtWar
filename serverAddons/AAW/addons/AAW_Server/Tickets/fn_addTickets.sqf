#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy

    Description:
    removesTicket

    Parameter(s):
    0: side <Side>
    0: tickets <Number>

    Returns:
    -
*/

params [["_side", sideUnknown], ["_tickets", 0]];

private _allTickets = missionNamespace getVariable format [QGVAR(sideTickets_%1), _side];
if !(isNil "_allTickets") then {
    _allTickets = _allTickets + _tickets;
    missionNamespace setVariable [format [QGVAR(sideTickets_%1), _side], _allTickets];
    publicVariable (format [QGVAR(sideTickets_%1), _side]);
    "ticketsChanged" call CFUNC(globalEvent);
};
