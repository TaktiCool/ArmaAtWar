

//Input Vars
_unit = (nearestObjects[player,["B_Truck_01_repair_F", "O_Truck_03_repair_F"], 10]) select 0;
_id = _this select 2;
_number = (_unit getVariable "deploy_state") select 1;
_marker = format["respawn_%1_%2", playerSide, _number];
_constTime = ["FARP_TIME", 10] call BIS_fnc_getParamValue;
_fobObj = nearestObjects [_unit, ["CamoNet_BLUFOR_big_F","CamoNet_OPFOR_big_F","Box_FIA_Wps_F"], 10];

//Next lets change the state of the vehicle for JIP players.
_unit setVariable ["deploy_state", 0, true];

//Display text to players
_text = "A FARP is being packed up at Grid: ";
_str = format ["%1%2", _text, mapGridPosition position _unit];
["FARPDeconstruction",[_str]] remoteExec ["BIS_fnc_showNotification", playerSide, false];

//Wait for Construction Delay
sleep _constTime;

//Delete the Respawn marker
[_marker] remoteExec ["DRK_fnc_deleteMarkerFARP",playerSide,true];

//Clean up the FOB Objects (Camonet, ammobox etc)
{
  detach _x;
  deleteVehicle _x;
} forEach _fobObj;

//Unlock the FARP
[_unit, 0] remoteExec ["lock", _unit, true];

//Refuel the FARP as per mission params
_fuel = ["FARP_REFUEL_ON_UNDEPLOY", 0] call BIS_fnc_getParamValue;
[_unit, _fuel] remoteExec ["DRK_fnc_setFuel", _unit];

//Next lets change the state of the vehicle for JIP players.
_unit setVariable ["deploy_state", ["mobile", _number], true];

