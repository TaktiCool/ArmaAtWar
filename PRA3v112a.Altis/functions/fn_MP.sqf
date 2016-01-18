//// DRK_fnc_MP ////

with missionnamespace do {
	private ["_params","_functionName","_target","_isPersistent","_isCall","_ownerID"];

	_params = 	[_this,0,[]] call bis_fnc_param;
	_functionName =	[_this,1,"",[""]] call bis_fnc_param;
	_target =	[_this,2,true,[objnull,true,0,[],sideUnknown,grpnull,""]] call bis_fnc_param;
	_isPersistent =	[_this,3,false,[false]] call bis_fnc_param;
	_isCall =	[_this,4,false,[false]] call bis_fnc_param;

	//--- Send to server
	BIS_fnc_MP_packet = [0,_params,_functionName,_target,_isPersistent,_isCall];
	publicvariableserver "BIS_fnc_MP_packet";

	//--- Local execution
	if !(ismultiplayer) then {
		["BIS_fnc_MP_packet",BIS_fnc_MP_packet] spawn BIS_fnc_MPexec;
	};

	BIS_fnc_MP_packet
};