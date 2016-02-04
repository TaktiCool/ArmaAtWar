/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/
_unit = _this select 0;
_number = _this select 1;
_side = _this select 2;
_marker = format["respawn_%1_%2", _side, _number];

_fobObj = nearestObjects [_unit, ["CamoNet_BLUFOR_big_F","CamoNet_OPFOR_big_F","Box_FIA_Wps_F"], 10];

waitUntil {sleep 1; not alive _unit};

//Remove FOB marker
[_marker] remoteExec ["DRK_fnc_deleteMarkerFARP", _side, true];

//Remove FOB Objects.
{
  detach _x;
  deleteVehicle _x;
} forEach _fobObj;

//Display text to players
_text = "A FARP has been destroyed at Grid: ";
_str = format ["%1%2", _text, mapGridPosition position _unit];
["FARPDestruction",[_str]] remoteExec ["BIS_fnc_showNotification", _side, false];