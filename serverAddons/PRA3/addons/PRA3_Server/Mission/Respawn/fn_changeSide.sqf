#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    -

    Returns:
    -
*/
private _currentSide = side group PRA3_Player;
private _otherSide = call compile ((GVAR(competingSides) select { _x != str _currentSide }) select 0);

//@todo think about restrictions

// This does not update playerSide (at least until spawn)
[PRA3_Player] join (createGroup _otherSide);
[QGVAR(updateTeamInfo)] call CFUNC(localEvent);
[QGVAR(updateSquadList)] call CFUNC(globalEvent); //@todo only currentSide needs to update
