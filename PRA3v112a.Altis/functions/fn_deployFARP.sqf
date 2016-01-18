/*
	Create a FARP

	by JohnnyShootos
*/


///////////////////////// SETUP VARS /////////////////////////
//Input Vars
_unit = (nearestObjects[player,["B_Truck_01_repair_F", "O_Truck_03_repair_F"], 6]) select 0;
_number = (_unit getVariable "deploy_state") select 1;
_deployID = _this select 2;
_sidePlayer = playerSide;

//Get the construction time - second paramter is the default if the FARP_TIME parameter does not exist
_constTime = ["FARP_TIME", 10] call BIS_fnc_getParamValue;

//Code the faction to the variable just ot make further script more readable
_sideFARP = side _unit;
if (_sideFARP == civilian) then {_sideFARP = side (_this select 1)};

//Create a unique name for the marker as markers cannot have the smae name
_markerName = format["respawn_%1_%2", _sidePlayer, _number];

//Choose an appropriate flag marker for the marker to be displayed on the map. Criteria for selection is the side of the FARP
_markerType = "";

switch (_sideFARP) do {
	
	case east: { _markerType = "flag_CSAT" };
	case west: { _markerType = "flag_NATO" };
	case independent: {_markerType = "flag_AAF" };
	case civilian: { _markerType = "flag_Altis" };
};


/////////////////////// DO THE THINGS /////////////////////////

//Next lets change the state of the vehicle for JIP players.
_unit setVariable ["deploy_state", ["deployed", _number], true];

//LETS DISPLAY SOME TEXT TO THE PLAYERS IN THE SAME FACTION AS THE FARP TO LET THEM KNOW ITS GOING UP

//Text parts
_text = "A FARP is being constructed at Grid: ";
_grid = mapGridPosition position _unit;

//Concatenate the parts into a single string
_str = format ["%1%2", _text, _grid ];

//Display that string to the players
["FARPConstruction",[_str]] remoteExec ["BIS_fnc_showNotification", _sidePlayer, false];

{
  moveOut _x;
} forEach crew _unit;

// Lock the FARP vehicle
[_unit, 2] remoteExec ["lock", _unit, true];

// Remove its fuel too coz we can
[_unit, 0] remoteExec ["DRK_fnc_setFuel", _unit];

// Construciton Delay
sleep _constTime;

// NOW LETS MAKE THE FARP HAPPEN

// Creating camouflage net 
_netType = "";
if (_sideFARP == west) then {_netType = "CamoNet_BLUFOR_big_F"} else {_netType = "CamoNet_OPFOR_big_F"};

_net = createVehicle [_netType, [0,0,1000], [], 0, "CAN_COLLIDE"];
_net enableSimulation false;
_net attachTo [_unit, [0,0,0.3]];


// Creating Equipment Resupply Station
if (["FARP_ARSENAL", 0] call BIS_fnc_getParamValue != 0 ) then {
	_ammo = createVehicle ["Box_FIA_Wps_F", [0,0,1000], [], 0, "CAN_COLLIDE"];
	clearWeaponCargoGlobal _ammo;
	clearItemCargoGlobal _ammo;
	clearMagazineCargoGlobal _ammo;
	clearBackpackCargoGlobal _ammo;
	_ammo attachTo [_unit, [-5,-4,-1]];
	_ammo setVariable ["R3F_LOG_disabled", true];
	[_ammo, _sidePlayer] execVM "scripts\arsenalFARP.sqf";
};

//Create a unique respawn marker
[_markerName, _unit, _markerType] remoteExec ["DRK_fnc_createMarkerFARP", _sidePlayer, true];

//Let the people know
_text = "A FARP is Operational at Grid: ";
_str = format ["%1%2", _text, _grid ];
["FARPOperational",[_str]] remoteExec ["BIS_fnc_showNotification", _sidePlayer, false];

//Add a monitor to clean up the FOB when it is destroyed.
[_unit, _number, _sidePlayer] remoteExec ["DRK_fnc_destroyedFARP", 2, false];







