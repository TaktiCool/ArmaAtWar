_type = _this select 0;
//var init
_isPilot = 0;
_isCrewman = 0;
_usefactory = 0;
_roleLimit = 0;
_className = '';


//import the amount of each restricted class available to a team
_numSL = ["NUM_SL", 6] call BIS_fnc_getParamValue;
_numAT = ["NUM_AT", 6] call BIS_fnc_getParamValue;
_numMedic = ["NUM_MEDIC", 6] call BIS_fnc_getParamValue;
_numAR = ["NUM_AR", 6] call BIS_fnc_getParamValue;
_numMarksman = ["NUM_MARKSMAN", 6] call BIS_fnc_getParamValue;
_numRepair = ["NUM_REPAIR", 6] call BIS_fnc_getParamValue;
_numCrewman = ["NUM_CREW", 10] call BIS_fnc_getParamValue;
_numDiver = ["NUM_DIVER", 4] call BIS_fnc_getParamValue;
_numPilot = ["NUM_PILOT", 4] call BIS_fnc_getParamValue;
_numSpotter = ["NUM_SPOTTER", 2] call BIS_fnc_getParamValue;
_numSniper = ["NUM_SNIPER", 2] call BIS_fnc_getParamValue;

//we figure out which unit the player is and kit him out accordingly
//array syntax [handle passed in from gui, isPilot, isCrewman, isSpotter, isSniper, isDiver, isRecon, maxRolesAvailable, OPFOR UNIT LOADOUT, BLUFOR UNIT LOADOUT]

_typeArray = [
	["teamLeader",0,0,1,_numSL, 'O_Soldier_SL_F', 'B_Soldier_SL_F'],
	["rifleman",0,0,0,999, 'O_Soldier_F', 'B_Soldier_F'],
	["riflemanAT",0,0,0,_numAT, 'O_Soldier_LAT_F', 'B_soldier_LAT_F'],
	["medic",0,0,0,_numMedic, 'O_medic_F', 'B_medic_F'],
	["autorifleman",0,0,0,_numAR, 'O_Soldier_AR_F', 'B_soldier_AR_F'],
	["marksman",0,0,0,_numMarksman, 'O_soldier_M_F', 'B_soldier_M_F'],
	["repair",0,0,0,_numRepair, 'O_soldier_repair_F', 'B_soldier_repair_F'],
	["crewman",0,1,0,_numCrewman, 'O_crew_F', 'B_crew_F'],
	["reconTeamLeader",0,0,1,1, 'O_recon_TL_F', 'B_recon_TL_F'],
	["reconMarksman",0,0,0,1, 'O_recon_M_F', 'B_recon_M_F'],
	["reconAT",0,0,0,1, 'O_recon_LAT_F', 'B_recon_LAT_F'],
	["reconMedic",0,0,0,1, 'O_recon_medic_F', 'B_recon_medic_F'],
	["diver",0,0,0,_numDiver, 'O_diver_F', 'B_diver_F'],
	["pilot",1,0,1,_numPilot, 'O_Pilot_F', 'B_Pilot_F'],
	["spotter",0,0,0,_numSpotter, 'O_spotter_F', 'B_spotter_F'],
	["sniper",0,0,0,_numSniper, 'O_ghillie_sard_F', 'B_ghillie_sard_F']
];

{
  if (_type in _x) then {
  	_isPilot = _x select 1;
	_isCrewman = _x select 2;
	_useFactory = _x select 3;
	_roleLimit = _x select 4;
	if (playerSide== east )then {_className = _x select 5};
	if (playerSide == west) then {_className = _x select 6};
  }
} forEach _typeArray;


_test = {side _x == playerSide && _x getVariable ["unitRole", ""] == _type} count playableUnits;

if (_test < _roleLimit) then {

	[player,configfile >> "CfgVehicles" >> _className] call BIS_fnc_loadInventory;

	player setVariable ["isPilot", _isPilot, true];
	player setVariable ["isCrewman", _isCrewman, true];
	player setVariable ["useFactory", _usefactory, true];

	//Some extras not in default kits
	if (_type == "rifleman") then { if (playerside == east) then {player addBackpack "B_Carryall_ocamo"} else {player addBackpack "B_Carryall_mcamo"}};
	if (_type == "sniper") then { if (playerside == east) then {player addPrimaryWeaponItem "bipod_02_F_hex"} else {player addPrimaryWeaponItem "bipod_01_F_mtp"}};
	if (_type == "diver") then { if (playerside == east) then {player linkItem "NVGoggles_OPFOR"} else {player linkItem "NVGoggles"}};


} else {
	["BadRoleSelection",["Too many units with this class already"]] call BIS_fnc_showNotification;
}
