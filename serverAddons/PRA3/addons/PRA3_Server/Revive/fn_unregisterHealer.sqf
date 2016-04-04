#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Unregisters a Healer from PRA3_Player

    Parameter(s):
    -

    Returns:
    -
*/
(_this select 0) params ["_healer"];

if (_healer in GVAR(currentHealers)) then {
    private _index = GVAR(currentHealers) find _healer;
    GVAR(currentHealers) deleteAt _index;
};

call FUNC(updateHealingStatus);
