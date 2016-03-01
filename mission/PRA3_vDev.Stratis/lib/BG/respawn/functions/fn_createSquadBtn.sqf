#include "script_macros.hpp"

params["_btn"];

private _description = ctrlText 204;

ctrlSetText [204, ""];

private _group = createGroup playerSide;
_group setVariable ["BG_description",_description, true];

[player] join _group;

["new_group",[_group]] call CBA_fnc_globalEvent;
