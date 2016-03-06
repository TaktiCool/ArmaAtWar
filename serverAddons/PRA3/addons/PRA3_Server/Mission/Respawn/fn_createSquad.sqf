#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Handles "Create Squad"-Button Events

    Parameter(s):
    0: Button <Control>

    Returns:
    None
*/
private _currentSide = side group PRA3_Player;

private _newSquad = createGroup _currentSide;
_newSquad setVariable [QGVAR(Id), GVAR(squadIds) select 0, true]; //@todo persistent group names
_newSquad setVariable [QGVAR(Description), ctrlText 204, true];
ctrlSetText [204, ""];

[PRA3_Player] join _newSquad;

[QGVAR(updateSquadList)] call CFUNC(globalEvent); //@todo only currentSide needs to update
