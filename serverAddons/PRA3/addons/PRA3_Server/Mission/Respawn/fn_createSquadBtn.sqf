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
params["_btn"];

private _description = ctrlText 204;

ctrlSetText [204, ""];

private _group = createGroup playerSide;
_group setVariable ["PRA3_description",_description, true];

[PRA3_player] join _group;

["new_group",[_group]] call EFUNC(Events,globalEvent);
